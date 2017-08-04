#!/usr/bin/env python3

import datetime
import dateutil.parser
import os
from path import cd
import simplejson as json
import sqlite3
import subprocess
import sys
import yaml

import log
warn, info, debug, fatal = log.reporters()

class UnsupportedDBType(Exception):
    pass
class DBNotFound(Exception):
   pass

class DBConn(object):
    def __init__(self, db_name="development", db_conf_file="", connect=True):
        """Open a database connection, creating db if needed, and generally
        get ready to store stuff.

        DB_NAME is the name of the database to target from dbconf.yml.

        If DB_CONF_FILE isn't specified, we use a stock one of defaults.

        Goose migrations used dbconf.yml files, so for convenience, we
        just read any needed data from that file.

        If CONNECT is true, we open a db connection.

        """
        self.db_name = db_name
        if os.path.exists(db_conf_file):
            # slurp dbconf.yml
            with open(db_conf_file) as INF:
                self.db_conf = yaml.load(INF)[db_name]
        else:
            info("dbconf.yml not found, using default config values (db will be leie.sqlite3)")
            self.db_name = "development"
            self.db_conf = yaml.load("development:\n  driver: sqlite3\n  open: leie.sqlite3\n")[self.db_name]

        # If we're not opening a connection, we're done
        if not connect:
            return

        # open and hang on to a db connection for later use
        if self.db_conf['driver'] == 'sqlite3':
            self.conn = sqlite3.connect(self.db_conf['open'])
        else:
            raise UnsupportedDBType("We don't support databases of type %s" % self.db_conf['driver'])

    def close(self):
        """Commit and close the db connection"""
        self.conn.commit()
        self.conn.close()

    def table_len(self, table):
        """Return the number of total rows in the TABLE"""
        c = self.conn.cursor()
        return (c.execute("SELECT Count(*) FROM %s" % table).fetchone()[0])

    def row_to_dict(self, row, field=None, description=None):
        """
        FIELD is a list or tuple of field names

        DESCRIPTION is the results of cursor.description from sqlite

        Either FIELD or DESCRIPTION must be present, but not both.

        ROW is a tuple of values

        Returns a dict with the keys taken from FIELD and the values taken from ROW.
        """
        assert field or description
        assert not (field and description)

        if description:
            field = [c[0] for c in description]

        field = ['id' if f == 'rowid' else f for f in field]
        return dict(zip(field, row))

class SQL(DBConn):
    """All the sql and goose stuff goes in this class.

    We generate the SQL here becuase in the future I think we might want some
    smart/scripted way to manage sql for different DB types."""

    def down(self, migration):
        """Returns schema sql for migrating the db down

        Specify a MIGRATION, the first being 0 on up to the latest.
        If you specify a migration beyond our total, we return
        None.

        """
        if migration == 0:
            return """
DROP TABLE exclusion;
DROP TABLE reinstatement;
"""
        if migration == 1:
            return "DROP TABLE log;"

    def goose(self):
        """Returns a dict of goose migrations.  The keys are filenames and the
        values are the contents of the goose files.

        We only have one migration so far, so this is pretty easy.
        """

        fnames = ["20170515130501_initial_create.sql"
                  ,"20170606100001_create_log.sql"
                  ]

        migrations = {}
        for a in range(len(fnames)):
            migrations[fnames[a]] = "-- +goose Up\n" + self.up(a) + "\n-- +goose Down\n" + self.down(a) + "\n"

        return migrations

    def goose_write(self, dirname=None):
        """Writes any needed migration files to the migrations directory
        specified by DIRNAME.  Leave DIRNAME as None to just use
        ./db as the migrations directory.

        Returns list of paths to created files.
        """
        if not dirname:
            dirname = os.path.join(os.path.dirname(__file__), "db")
        dirname = os.path.join(dirname, self.db_conf['driver'])
        os.makedirs(dirname, exist_ok=True)
        created = []
        for fname, migration in self.goose().items():
            fname = os.path.join(dirname, fname)
            if os.path.exists(fname):
                debug("Migration " +fname+" already exists. Overwriting.")
            created.append(fname)
            info("Writing migration to " + fname)
            with open(fname, 'w') as OUTF:
                OUTF.write(migration)
        return created

    def migrate(self):
        """Bring the db schema up to date by running any needed model
        migrations."""
        debug(self.db_conf)
        dirname = os.path.dirname(self.db_conf['open'])
        if not dirname:
            dirname = os.path.dirname(__file__)
        with cd(dirname):
            # Make sure the sqlite3 db exists before we try to migrate it
            if not os.path.exists(os.path.basename(self.db_conf['open'])):
                raise DBNotFound("DB %s doesn't exist, so we can't migrate it." % self.db_conf['open'])

            # Goose apparently returns 0 even when it errors, so we
            # have to check stderr and react accordingly.
            cmd = "goose -dir db/{0} {0} {1} up".format(self.db_conf['driver'], os.path.basename(self.db_conf['open']))
            debug("Executing `%s`" % cmd)
            p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
            out, err = p.communicate()
            out = out.decode("utf-8")
            err = err.decode("utf-8")
            if err != '':
                sys.stderr.write("%s\n%s" % (out, err))
                raise subprocess.CalledProcessError(0, cmd, out+err)
            return out

    def up(self, migration):
        """Returns schema sql for migrating the db up.

        Specify a MIGRATION, the first being 0 on up to the latest.
        If you specify a migration beyond our total, we return
        None.

        """

        # We only handle sqlite for now
        if self.db_conf['driver'] != "sqlite3":
            raise UnsupportedDBType("We don't have migrations for %s" % self.db_conf['driver'])

        if migration == 0:
            common_rows = """
            lastname text check(lastname is null or length(lastname) <= 20),
            firstname text check(firstname is null or length(firstname) <= 15),
            midname text check(midname is null or length(midname) <= 15),
            busname text  check(busname is null or length(busname) <= 30),
            general text  check(general is null or length(general) <= 20),
            specialty text check(specialty is null or length(specialty) <= 20),
            upin text check(upin is null or length(upin) <= 6),
            npi integer check(npi is null or npi<10000000000),
            dob text check(dob is null or length(dob) <= 23),
            address text check(address is null or length(address) <= 30),
            city text check(city is null or length(city) <= 20),
            state text check(state is null or length(state) <= 2),
            zip integer check(zip is null or zip < 100000),
            excltype text not null check(excltype is null or length(excltype) <= 8),
            excldate text not null check(excldate is null or length(excldate) <= 23),
            reindate text check(reindate is null or length(reindate) <= 23),
            waiverdate text check(waiverdate is null or length(waiverdate) <= 23),
            waiverstate text check(waiverstate is null or length(waiverstate) <= 2)
            """
            return("CREATE TABLE IF NOT EXISTS exclusion (" + common_rows + ");\n"
                   + "CREATE TABLE IF NOT EXISTS reinstatement (" + common_rows + ");\n")
        elif migration == 1:
            return """
            CREATE TABLE IF NOT EXISTS log (
            datetime text,
            datatype text,
            msg text);
            """
        else:
            return None


class LEIE(SQL):
    """This is a DAO class but not an ORM class.  We're modeling the
    database, not the data.  Maybe that will change, but it works for
    now.

    """

    def count_exclusions(self):
        """Return number of rows in the exclusion table"""
        return self.table_len("exclusion")

    def dedupe(self, table):
        """
        Remove any duplicate rows from TABLE
        """

        # Look for duplicate entries
        seen = set()
        uniq = []
        dup = []
        c = self.conn.cursor()
        for x in c.execute("SELECT * FROM %s" % table).fetchall():
            if x not in seen:
                uniq.append(x)
                seen.add(x)
            else:
                dup.append(x)

        # We're done if there are no dupes
        if not dup:
            return

        # Uh-oh, better fess up and clean up
        warn("Duplicate reinstatements found in %s!" % table)
        info("Cleaning duplicate reinstatements from %s" % table)
        c.execute("delete from {0} where rowid not in (select max(rowid) from {0} group by {1})".format(
            table,
            ", ".join(self.get_header(table))
            ))

    def dedupe_reinstatements(self):
        """
        Make sure there are no duplicate rows in the reinstatement table.

        """
        self.dedupe("reinstatement")

    def get_download_datetime(self, fname):
        """Return the logged time of the last download of the file named FNAME

        If it's not there, return None"""
        c = self.conn.cursor()
        all = c.execute("SELECT * FROM log WHERE msg=?", ["Downloaded " + fname]).fetchall()
        if not all:
            return None
        return dateutil.parser.parse(all[-1][0])

    def get_exclusions(self, limit=10, page=1, filter={}, form="list"):
        """Return all the rows from the log table up to LIMIT rows

        FORM can be 'list' or 'dict'.  If 'list', return rows as
        lists.  If dict, return rows as dicts.

        If PAGE is specified, we skip the first (PAGE-1)*LIMIT rows
        and return LIMIT rows from there.

        """
        assert form in ["list", "dict"]
        assert page >= 1
        assert limit >= 1

        crsr = self.conn.cursor()

        # Make strings for the filters to be inserted in to the sql
        # query. Also, make a list of arguments for the query.
        args = [limit*(page-1)]
        query = ["SELECT rowid, * FROM exclusion",
                 "WHERE rowid NOT IN ( SELECT rowid FROM exclusion ORDER BY excldate DESC LIMIT ?)"
                 ]
        for k,v in filter.items():
            if v:
                query.append("AND %s=?" % k)
                args.append(v)
        query.append("ORDER BY excldate DESC LIMIT ?")
        args.append(limit)

        # Return a range of rows
        rows = crsr.execute(" ".join(query), args).fetchall()

        if form == 'list':
            return rows
        return [Exclusion(self.row_to_dict(r, description=crsr.description)) for r in rows]

    def get_header(self, table):
        """Returns a list of the column names in TABLE"""
        c = self.conn.cursor()
        return [f[1] for f in c.execute("PRAGMA table_info(%s)" % table).fetchall()]

    def get_latest_date(self, table, field):
        """Find and return the latest month and year in the list of actions in
        TABLE by looking at dates in FIELD.  Return this value as a
        string formatted "YYYY-MM-DD".

        If there are no rows, return "".

        """

        crsr = self.conn.cursor()
        d = crsr.execute("SELECT {1} FROM {0} ORDER BY date({1}) DESC Limit 1".format(table, field)).fetchone()
        if not d:
            return ""
        return d[0][:10]

    def get_latest_exclusion_date(self):
        """Find and return the latest month and year in the list of exclusion
        actions.  Return this value as a string formatted
        "YYYY-MM-DD".

        If there are no rows, return "".

        """

        return self.get_latest_date("exclusion", "excldate")

    def get_latest_reinstatement_date(self):
        """Find and return the latest month and year in the list of
        reinstatement actions.  Return this value as a string
        formatted "YYYY-MM-DD".

        If there are no rows, return "".

        """
        return self.get_latest_date("reinstatement", "reindate")

    def get_log(self, rowid=None, limit=10, start=0, form="list"):
        """Return all the rows from the log table up to LIMIT rows

        if ROWID is set, we just return that row and LIMIT parameter has no effect.  If that row doesn't exist, return None.

        FORM can be 'list' or 'dict'.  If 'list', return rows as lists.  If dict, return rows as dicts.

        If START is specified... I dunno. not implemented yet.
        """

        assert form in ["list", "dict"]

        crsr = self.conn.cursor()

        # Return just the requested row
        if rowid:
            return crsr.execute("SELECT rowid, * FROM log WHERE rowid=?", [rowid]).fetchone()

        # Return a range of rows
        rows = crsr.execute("SELECT rowid, * FROM log ORDER BY datetime DESC LIMIT ?", [limit]).fetchall()
        if form == 'list':
            return rows
        return [self.row_to_dict(r, description=crsr.description) for r in rows]

    def log(self, datatype, message, now=""):
        """Add a MESSAGE string about a DATATYPE (either updated or
        reinstatement) to the log table in the db.

        Else, NOW = a datestring we can parse.  It can be anything
        whose str representation is a parseable datetime, including a
        datetime.

        """

        assert datatype in ["updated", "reinstatement"]

        info("%s: %s" % (datatype, message))

        # See http://sqlite.org/datatype3.html for info on date formats in sqlite3
        if not now:
            now = datetime.datetime.now().isoformat()
        else:
            now = dateutil.parser.parse(str(now)).isoformat()

        crsr = self.conn.cursor()
        crsr.execute("INSERT INTO log VALUES(?,?,?)", (now, datatype, message))
        self.conn.commit()

class Exclusion(dict):
    """Model of an exclusion.

    This is just a dict that we're wrapping in a class so we can
    attach methods to it.

    """
    def __init__(self, dictionary):
        dict.__init__(self)
        self.update(dictionary)

    def fhir(self, form="dict"):
        """Return the data of this instance in a way that complies with FHIR.
        First, we assemble it as a dict, then convert it to JSON or XML if FORM
        is json' or 'xml'.
        """
        ret = self.copy()
        ret['resourceType'] = 'Exclusion'
        if form == "dict":
            return ret
        if form == "xml":
            return dicttoxml.dictotoxml(ret)
        return json.dumps(ret)

def main(dirname=None):
    logger = log.logger()
    logger.info('Running model.py directly to produce schema/goose output.')
    conn = SQL(connect=False)
    fnames = conn.goose_write(dirname)
    logger.info('Finished running model.py directly to produce schema/goose output.')
    return fnames

if __name__ == '__main__':
    main()

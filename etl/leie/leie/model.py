#!/usr/bin/env python3

import os
from path import cd
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

class LEIE(object):
    """This is a DAO class but not an ORM class.  We're modeling the
    database, not the data.  Maybe that will change, but it works for
    now.

    """

    dbtype = None

    def __init__(self, db_name="development", db_conf_file="", connect=True):
        """Open a database connection, creating db if needed, and generally
        get ready to store stuff.

        DB_NAME is the name of the database to target from dbconf.yml.

        If DB_CONF_FILE isn't specified, we use a stock one of defaults.

        Goose migrations use dbconf.yml files, so for convenience, we
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

    def count_exclusions(self):
        """Return the number of total rows in the individual_exclusion and
        business_exclusion databases."""
        return self.count_table_tag("exclusion")

    def count_table_tag(self, table_tag):
        """Return the total number of rows in the individual_TABLE_TAG and
        business_TABLE_TAG tables."""
        c = self.conn.cursor()
        return (c.execute("SELECT Count(*) FROM individual_%s" % table_tag).fetchone()[0] +
                c.execute("SELECT Count(*) FROM business_%s" % table_tag).fetchone()[0])

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
        Make sure there are no duplicate rows in the individual_reinstatement or business_reinstatement tables.

        """
        self.dedupe("individual_reinstatement")
        self.dedupe("business_reinstatement")

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

        return self.get_latest_date("individual_exclusion", "excldate")

    def get_latest_reinstatement_date(self):
        """Find and return the latest month and year in the list of
        reinstatement actions.  Return this value as a string
        formatted "YYYY-MM-DD".

        Because business reinstatements are rare and individual
        reinstatements are common, we just look at the individual
        table for the date.  There are months with no business
        reinstatements.

        If there are no rows, return "".

        """
        return self.get_latest_date("individual_reinstatement", "reindate")

    def goose(self):
        """Returns a dict of goose migrations.  The keys are filenames and the
        values are the contents of the goose files.

        We only have one migration so far, so this is pretty easy.
        """

        migration = "-- +goose Up\n" + self.sql(0) + """\n-- +goose Down
DROP TABLE individual_exclusion;
DROP TABLE individual_reinstatement;
DROP TABLE business_exclusion;
DROP TABLE business_reinstatement;"""

        return {"20170515130501_initial_create.sql": migration}

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
                debug("Migration " +fname+" already exists.")
                continue
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
                raise subprocess.CalledProcessError(0, cmd, out+err)
            return out

    def sql(self, migration):
        """Returns schema sql for the db

        Specify a MIGRATION, the first being 0 on up to the latest.
        If you specify a migration beyond our total, we return
        None.

        """

        # We only handle sqlite for now
        if self.db_conf['driver'] != "sqlite3":
            raise UnsupportedDBType("We don't have migrations for %s" % self.db_conf['driver'])

        if migration == 0:
            common_rows = """
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
            indiv_rows = """
            lastname text check(lastname is null or length(lastname) <= 20),
            firstname text check(firstname is null or length(firstname) <= 15),
            midname text check(midname is null or length(midname) <= 15),"""
            bus_rows = """\nbusname text  check(busname is null or length(busname) <= 30),"""
            return("CREATE TABLE IF NOT EXISTS individual_exclusion (" + indiv_rows + common_rows + ");\n"
                   + "CREATE TABLE IF NOT EXISTS individual_reinstatement (" + indiv_rows + common_rows + ");\n"
                   + "CREATE TABLE IF NOT EXISTS business_exclusion (" + bus_rows + common_rows + ");\n"
                   + "CREATE TABLE IF NOT EXISTS business_reinstatement (" + bus_rows + common_rows + ");")
        else:
            # We only have the one migration for now
            return None

def main(dirname=None):
    conn = LEIE(connect=False)
    return conn.goose_write(dirname)

if __name__ == '__main__':
    logger = log.logger()
    logger.info('Running model.py directly to produce schema/goose output.')
    main()
    logger.info('Finished running model.py directly to produce schema/goose output.')

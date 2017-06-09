#!/usr/bin/env python3

"""This script loads code from LEIE data files into a database.

See README.mdwn for details and instructions.

"""

# System modules
from datetime import datetime
import dateutil.parser
import glob
import os
import petl as etl
import re
import sys

# Our modules
import log
import model
from path import get_existing_file

warn, info, debug, fatal = log.reporters()

date_re = re.compile(r'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
slash_date_re = re.compile(r'[0-9][0-9]/[0-9][0-9]/[0-9][0-9]$')
def munge_date(date_entry):
    """Return a string with a date in the format that SQLite wants
    (YYYY-MM-DD HH:MM:SS.sss). (see
    https://stackoverflow.com/questions/17227110/what-is-the-best-way-to-save-datetime-type-in-sqlite)

    DATE_ENTRY is either a YYMMDD string or a MM/DD/YY string.

    Some dates come with only a 2-digit year.  We assume all years are
    after 2000, but if that would put the date later than the current
    year, we change it to a year between 1900 and now.  We do
    sometimes see future dates, but they don't end up in the following
    year.  They end up later in the current month.  See, e.g., the
    entry for Jeffrey Shopes in 1610EXCL.csv:

    "SHOPE","JEFFREY","R ",,"IND- LIC HC SERV PRO","CHIROPRACTIC",,"1134286958","19701109","446 GREENBAG ROAD, ROUTE 857","MORGANTOWN","WV","26501","1128a1","20161120","00000000","00000000",

    You'll see that the exclusion date is 20161120 in a file with Oct
    2016 data that was published in early November.

    """

    f = date_entry
    if date_re.match(f):
        return "%s-%s-%s 00:00:00.000" % (f[:4], f[4:6], f[6:8])
    if slash_date_re.match(f):
        y = int(f[6:8])+2000
        if y > datetime.now().year+1:
            y -= 100
        return "%s-%s-%s 00:00:00.000" % (y, f[:2], f[3:5])

    # We shouldn't get here, but just in case dates get all funky, we
    # do our best guess at parsing the date:
    d = str(dateutil.parser.parse(f)) + ".000"
    warn("Unrecognized date format ({0}) parsed as {1}!".format(f, d))
    return d

def clean_and_separate(table):
    """Do some cleanup of TABLE and split into individual and business tables.

    TABLE is a petl table."""

    # Rename column to expand name
    table = etl.rename(table, {'WVRSTATE': 'waiverstate'})

    # More conversions
    table = etl.convert(table, {
        'EXCLTYPE': lambda f: f.strip(), # Trim extra spaces
        'EXCLDATE': munge_date, # Arrange date for sqlite
        'REINDATE': munge_date, # Arrange date for sqlite
        'WAIVERDATE': munge_date # Arrange date for sqlite
    })

    # Separate into two tables, as this is actually two different data sets
    individual = etl.select(table, "{LASTNAME} != '' and {FIRSTNAME} != ''")
    business = etl.select(table, "{LASTNAME} == '' and {FIRSTNAME} == ''")

    # Sanity check: Make sure we split the rows without dupes or
    # missing any.  The +1 is to account for the second header row
    # that gets counted when we have two tables.
    if len(business) + len(individual) != len(table) + 1:
        fatal("Separating business and individual exclusions came up with the wrong number of rows!")

    # Remove unused columns
    individual = etl.transform.basics.cutout(individual, "BUSNAME")
    business = etl.transform.basics.cutout(business, "LASTNAME", "FIRSTNAME", "MIDNAME", "DOB")

    # Do some cleanup conversions on individual data
    individual = etl.convert(individual, {'DOB': munge_date,
                                          'MIDNAME': lambda f: f if f != " " else ""  # no spaces as middle names
                                          })
    return individual, business

class Exclusions():
    """ETL helper class for handling exclusions."""

    def __init__(self, conn):
        """CONN is a database connection."""
        self.conn = conn

    def etl_from_table(self, table, force_reload=False):
        """Extract, translate, load exclusions (and not reinstatements) from
        a petl TABLE.

        Set FORCE_RELOAD to True to turn off the protections against
        reading the same csv file twice.  There is no harm in redoing
        a csv file, since the csv contents replaces the db table
        entirely.  We avoid reloading because it is faster and because
        it prevents the db from having an empty table for a moment
        between blowing away and refilling it.

        """
        if not force_reload:
            # If UPDATED.csv has the same number of rows and the same most
            # recent date as our db, we've already snarfed this csv file and
            # can skip it.
            db_latest = self.conn.get_latest_exclusion_date().replace('-','')
            db_num_rows = self.conn.count_exclusions()
            updated_latest = etl.cut(etl.sort(table, 'EXCLDATE'), 'EXCLDATE')[len(table)-1][0]
            updated_num_rows = len(table) - 1
            if (db_num_rows == updated_num_rows and db_latest == updated_latest):
                return

        # Massage data
        individual, business = clean_and_separate(table)

        # Save to db, BLOWING AWAY data in the existing tables.  If
        # tables don't exist, will create them, but without any
        # constraints.
        info("Replacing individual_exclusion and business_exclusion tables.")
        etl.todb(individual, self.conn.conn, 'individual_exclusion')
        etl.todb(business, self.conn.conn, 'business_exclusion')

    def etl_from_filename(self, fname, force_reload=False):
        """Extract, translate, load exclusions (and not reinstatements) from
        the file named FNAME.

        Set FORCE_RELOAD to True to turn off the protections against
        reading the same csv file twice.  There is no harm in redoing
        a csv file, since the csv contents replaces the db table
        entirely.  We avoid reloading because it is faster and because
        it prevents the db from having an empty table for a moment
        between blowing away and refilling it.

        """
        self.etl_from_table(etl.fromcsv(fname), force_reload)

    def etl_from_dir(self, data_dir="data", force_reload=False):
        """Extract, translate, load exclusions (and not reinstatements) from
        the DATA_DIR directory.

        CONN is a db connection


        Set FORCE_RELOAD to True to turn off the protections against
        reading the same csv file twice.  There is no harm in redoing
        a csv file, since the csv contents replaces the db table
        entirely.  We avoid reloading because it is faster and because
        it prevents the db from having an empty table for a moment
        between blowing away and refilling it.

        """

        # Get the data from updated CSV file
        self.etl_from_filename(os.path.join(data_dir,"UPDATED.csv"), force_reload)

class Reinstatements():
    """ETL helper class for handling reinstatements."""

    def __init__(self, conn):
        """CONN is a database connection."""
        self.conn = conn

    def etl_from_dir(self, data_dir="data"):
        """Extract, translate, load reinstatements (and not exclusions) from
        directory DATA_DIR.
        """

        # Get YYYYMM date of most recent reinstatement action
        most_recent = self.conn.get_latest_reinstatement_date().replace('-','')[:6] or "000000000"

        # Get the data from REIN CSV files.  Gather reinstatement actions
        # since most_recent
        total_indiv = []
        total_bus = []
        for fname in sorted(glob.glob(os.path.join(data_dir, "*REIN.csv"))):
            if int(os.path.basename(fname)[:4]) <= int(most_recent[2:]):
                continue
            debug("Processing " + fname)
            reinstated = etl.fromcsv(fname)
            individual, business = clean_and_separate(reinstated)
            total_indiv.append(individual)
            total_bus.append(business)

        # Save to db, APPENDING TO existing data tables.  Assumes tables
        # exist.
        if total_indiv:
            etl.appenddb(etl.cat(*total_indiv), self.conn.conn, 'individual_reinstatement')
        if total_bus:
            etl.appenddb(etl.cat(*total_bus), self.conn.conn, 'business_reinstatement')

        # It is possible to end up with duplicate rows if, say, an ETL
        # process is interrupted midway through.  So we should find and
        # remove dupes.
        self.conn.dedupe_reinstatements()

def main():

    # Figure out where our db is
    dbdir = get_existing_file(["/var/etl/leie/db",
                               "db",
                               "../db",
                               os.path.join(os.path.dirname(__file__), "db"),
                               os.path.join(os.path.dirname(__file__), "..", "db")],
                              "db")
    info("Using %s as db directory" % dbdir)

    # Get a database connection, create db if needed
    conn = model.LEIE("development", db_conf_file=os.path.join(dbdir, "dbconf.yml"))

    # Make sure the db schema is up to date, create tables, etc.
    conn.migrate()

    # Find data dir
    datadir = get_existing_file(["/var/etl/leie/data",
                                 "data",
                                 "../data",
                                 os.path.join(os.path.dirname(__file__), "data"),
                                 os.path.join(os.path.dirname(__file__), "..", "data")],
                                "data")
    info("Using %s as data directory" % datadir)

    # Do our ETL
    excl = Exclusions(conn)
    excl.etl_from_dir(datadir)
    rein = Reinstatements(conn)
    rein.etl_from_dir(datadir)

    # Close the db connection
    conn.close()

if __name__ == '__main__':
    os.chdir(os.path.dirname(__file__))
    logger = log.logger()
    info('Starting ETL of LEIE data.')
    main()
    info('Finished ETL of LEIE data.')

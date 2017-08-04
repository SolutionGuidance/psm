#!/usr/bin/env python3

"""This script loads code from LEIE data files into a database.

See README.mdwn for details and instructions.

"""

# System modules
from datetime import datetime
from datetime import date
import dateutil.parser
import glob
import os
import petl as etl
import re
import requests
import sys
import time

# Our modules
import log
import model
from path import get_datadir, get_dbdir, get_existing_file

warn, info, debug, fatal = log.reporters()

date_re = re.compile(r'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
slash_date_re = re.compile(r'[0-9][0-9]/[0-9][0-9]/[0-9][0-9]$')
def munge_date(date_entry):
    """Return a string with a date in the format that SQLite wants
    (YYYY-MM-DD). (see
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
        if '00000000' == date_entry:
            return None
        return "%s-%s-%s" % (f[:4], f[4:6], f[6:8])
    if slash_date_re.match(f):
        if '00/00/00' == date_entry:
            return None
        y = int(f[6:8])+2000
        if y > datetime.now().year+1:
            y -= 100
        return "%s-%s-%s" % (y, f[:2], f[3:5])

    # We shouldn't get here, but just in case dates get all funky, we
    # do our best guess at parsing the date:
    d = dateutil.parser.parse(f).date().isoformat()
    warn("Unrecognized date format ({0}) parsed as {1}!".format(f, d))
    return d

def clean(table):
    """Do some cleanup of TABLE

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

    # Do some cleanup conversions on individual data
    table = etl.convert(table, {'DOB': munge_date,
                                'MIDNAME': lambda f: f if f != " " else ""  # no spaces as middle names
    })
    return table

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
            db_num_rows = self.conn.table_len("exclusion")
            updated_latest = etl.cut(etl.sort(table, 'EXCLDATE'), 'EXCLDATE')[len(table)-1][0]
            updated_num_rows = len(table) - 1
            if (db_num_rows == updated_num_rows and db_latest == updated_latest):
                return

        # Massage data
        table = clean(table)

        # Save to db, BLOWING AWAY data in the existing table.  If
        # table doesn't exist, will create it, but without any
        # constraints.
        info("Replacing exclusions table.")
        etl.todb(table, self.conn.conn, 'exclusion')

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
        total = []
        total = []
        for fname in sorted(glob.glob(os.path.join(data_dir, "*REIN.csv"))):
            if int(os.path.basename(fname)[:4]) <= int(most_recent[2:]):
                continue
            debug("Processing " + fname)
            reinstated = etl.fromcsv(fname)
            reinstated = clean(reinstated)
            total.append(reinstated)

        # Save to db, APPENDING TO existing data tables.  Assumes tables
        # exist.
        if total:
            etl.appenddb(etl.cat(*total), self.conn.conn, 'reinstatement')

        # It is possible to end up with duplicate rows if, say, an ETL
        # process is interrupted midway through.  So we should find and
        # remove dupes.
        self.conn.dedupe_reinstatements()

def fname_is_stale(fname, url, conn):
    """Return True if URL's Last-Modified is after FNAME's mod datetime.

    Return False if FNAME's mod datetime is after URL's Last-Modified.

    Return True if filesize on disk differs from filesize in the headers

    Return True if FNAME doesn't exist.

    Return False if we can't quite download URL.

    Return False if we have a log entry in the db saying we already
    downloaded the file and it's not an UPDATED file.

    CONN is a model.LEIE instance and we use it just to get access to
    the db log

    """

    # We should only do csv files, so this is a sanity check.  I mean,
    # this routine could technically download things other than csv,
    # but it's not our goal to do so.
    assert fname.endswith(".csv")

    # If there is no already-existing file, it is stale
    if not os.path.exists(fname):
        return True

    # Check that we haven't already downloaded this according to the log
    if not fname.endswith("UPDATED.csv"):
        last = conn.get_download_datetime(os.path.basename(fname))
        if last != None:
            return False

    # Get head of url target
    r = requests.head(url)
    if r.status_code != 200:
        warn("Can't get head information about %s" % url)
        return False

    # If size indicated in header differs from size on disk, then
    # the file is stale.
    if int(r.headers["Content-Length"]) != os.path.getsize(fname):
        warn("Size differs from that on disk. File %s is stale." % fname)
        return True

    # Get mod times of url and fname
    mtime = datetime.fromtimestamp(os.path.getmtime(fname))  # file's mtime
    tz = time.tzname[time.localtime().tm_isdst]              # file's timezone
    mtime = dateutil.parser.parse("%s %s" % (str(mtime), tz) ) # add timezone to file's mtime info
    dt = dateutil.parser.parse(r.headers['Last-Modified'])   # url's last mod time

    # If the url version is newer than our file on disk, the file on
    # disk is stale
    if dt > mtime:
        return True

    # Retroactively log the download of the cached file
    if not fname.endswith("UPDATED.csv"):
        conn.log("reinstatement", "Downloaded %s" % os.path.basename(fname), mtime)
    else:
        conn.log("updated", "Downloaded %s" % os.path.basename(fname), mtime)

    # Looks like the cached file is still good
    return False

def dload_if_stale(fname, url, conn):
    """Download the file at URL and save it to FNAME, but only if the
    on-disk version is out of date.

    FNAME is the filename to save the file as

    URL is the url of the file to download

    CONN is a model.LEIE instance and we use it just to get access to the db log

    Returns True if we downloaded, else False
    """

    if fname_is_stale(fname, url, conn):
        debug("Downloading %s" % url)

        # We stream and write this in chunks in case it is huge. It's
        # not, now, but maybe it will grow.  Better safe than sorry.
        r=requests.get(url, stream=True)

        # Warn if we can't download properly
        if r.status_code != 200:
            warn("Fetching %s returned status code of %d. Discarding result" % (url, r.status_code))
            return False

        # Did we get forwarded to a 404 page?
        if "404" in r.url:
            warn("File not found: %s" % url)
            return False

        with open(fname, 'wb') as f:
            for chunk in r.iter_content(chunk_size=1024):
                if chunk: # filter out keep-alive new chunks
                    f.write(chunk)

        assert int(r.headers["Content-Length"]) == os.path.getsize(fname)

        return True

    return False

def download(datadir, conn):
    """Download UPDATED.csv and reinstatements to the DATADIR

    CONN is a model.LEIE instance we'll use to log to the database"""

    if dload_if_stale(os.path.join(datadir, "UPDATED.csv"),
                      'https://oig.hhs.gov/exclusions/downloadables/UPDATED.csv',
                      conn):
        conn.log("updated", "Downloaded UPDATED.csv")

    for year in range(2016,date.today().year+1):
        for month in range(1,13):
            if (year == date.today().year
                and month >= date.today().month):
                continue
            for suffix in ("REIN.csv", "EXCL.csv"):
                fname = "%2d%02d%s" % (year-2000, month, suffix)
                url = "https://oig.hhs.gov/exclusions/downloadables/%4d/%s" % (year, fname)
                if dload_if_stale(os.path.join(datadir, fname), url, conn):
                    conn.log("reinstatement", "Downloaded %s" % fname)

def main():
    os.chdir(os.path.dirname(__file__))
    logger = log.logger()
    info('Starting ETL of LEIE data.')

    # Figure out where we put data
    datadir = get_datadir()
    dbdir = get_dbdir()

    # Get a database connection, create db if needed
    conn = model.LEIE("development", db_conf_file=os.path.join(dbdir, "dbconf.yml"))

    # Make sure the db schema is up to date, create tables, etc.
    conn.migrate()

    assert os.path.exists(datadir)

    # Do our ETL
    download(datadir, conn)
    excl = Exclusions(conn)
    excl.etl_from_dir(datadir)
    rein = Reinstatements(conn)
    rein.etl_from_dir(datadir)

    # Close the db connection
    conn.close()

    info('Finished ETL of LEIE data.')

if __name__ == '__main__':
    main()

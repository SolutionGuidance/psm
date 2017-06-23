#!/usr/bin/env python3

"""
You can trim UPDATED.csv to only take every 100th line:

    awk 'NR == 1 || NR % 200 == 0' data/UPDATED.csv > tests/data/UPDATED.csv

Move that in to the tests/data dir for testing purposes.
"""

import re
import os
import pytest
import subprocess
import sys

# Add paths that will let us import our python files
for p in (os.path.dirname(__file__), os.path.dirname(os.path.dirname(__file__))):
    if not p in sys.path:
        sys.path.append(p)

# This is just to keep the test coverage reporter from complaining
import __init__

import etl
import model

@pytest.fixture
def conn():
    """Fixture to create db connection for tests, then close the
    connection and delete the db in teardown.

    """
    conn = model.LEIE("test", connect=False)
    if os.path.exists(conn.db_conf['open']):
        os.unlink(conn.db_conf['open'])
    conn = model.LEIE("test")
    conn.migrate()
    yield conn
    conn.close()
    os.unlink(conn.db_conf['open'])

def test_munge_date():
    assert etl.munge_date("20120620") == "2012-06-20 00:00:00.000"
    assert etl.munge_date("03/09/62") == "1962-03-09 00:00:00.000"
    assert etl.munge_date("03/09/01") == "2001-03-09 00:00:00.000"
    assert etl.munge_date("03/09/00") == "2000-03-09 00:00:00.000"
    assert etl.munge_date("03/09/99") == "1999-03-09 00:00:00.000"
    assert etl.munge_date("03/09/1999") == "1999-03-09 00:00:00.000"
    assert etl.munge_date("03/09/2000") == "2000-03-09 00:00:00.000"
    assert etl.munge_date("03/09/2001") == "2001-03-09 00:00:00.000"
    assert etl.munge_date("03/09/1801") == "1801-03-09 00:00:00.000"
    assert etl.munge_date("03/09/2101") == "2101-03-09 00:00:00.000"

    # Test the regexes that munge_data relies on
    assert etl.date_re.match("20120620")
    assert etl.date_re.match("20120620 junk")
    assert etl.slash_date_re.match("03/09/99")
    assert not etl.slash_date_re.match("03/09/1999")

def test_data_missing(conn):
    """This just does something dumb.  We want to know that a
    file-not-found creates the right error, as opposed to, say,
    creating a blackhole sent from the future to destroy the LHC.

    """

    excl = etl.Exclusions(conn)
    with pytest.raises(FileNotFoundError) as exc_info:
        excl.etl_from_dir(data_dir="tests/data/does/not/exist")
    exception = exc_info.value
    assert str(exception) == "[Errno 2] No such file or directory: 'tests/data/does/not/exist/UPDATED.csv'"

def test_exclusion(conn):
    print("We just do a complete exclusion ETL and then see if the results are as expected.")
    excl = etl.Exclusions(conn)
    excl.etl_from_dir("tests/data")
    rows = conn.count_exclusions()

    # And again twice to exercise the force_reload stuff
    excl.etl_from_filename("tests/data/UPDATED.csv", force_reload=True)
    excl.etl_from_filename("tests/data/UPDATED.csv")

    ## Make the right number of rows were written and we didn't duplicate the data
    assert conn.count_exclusions() == rows
    rows = int(subprocess.check_output("wc -l tests/data/UPDATED.csv", shell=True).decode("utf-8").split(' ')[0])
    assert conn.count_exclusions() == rows - 1

def test_reinstatement(conn):
    print("We just do a complete reinstatement ETL and then see if the results are as expected.")
    rein = etl.Reinstatements(conn)
    rein.etl_from_dir("tests/data")
    first_rows_in_db = conn.count_table_tag("reinstatement")

    # And again to test dupe remediation
    rein.etl_from_dir("tests/data")
    rows = subprocess.check_output("wc -l tests/data/*REIN*.csv", shell=True).decode("utf-8").strip().split("\n")
    rows = int(rows[-1].strip().split(' ')[0]) - (len(rows) - 1)
    assert conn.count_table_tag("reinstatement") == rows

#!/usr/bin/env python3

"""
Test model.py
"""

import os
import pytest
import subprocess
import sys

# Add paths that will let us import our python files
for p in (os.path.dirname(__file__), os.path.dirname(os.path.dirname(__file__))):
    if not p in sys.path:
        sys.path.append(p)

import model

from test_etl import conn
    
def test_goose_write():
    """Exercise the goose_writes part of the model"""
    conn = model.LEIE(connect=False)
    subprocess.run("rm -rf tests/db", shell=True)
    fnames = conn.goose_write("tests/db")
    assert os.path.exists("tests/db/sqlite3")
    assert len(fnames) >= 1
    for fname in fnames:
        assert os.path.exists(fname)

    # Again, to we make sure we bail if sql files already exist
    assert len(conn.goose_write("tests/db")) == 0
    
def test_main():
    """Main just does goose_write, so this is the mostly same test as
    test_goose_write"""
    subprocess.run("rm -rf tests/db", shell=True)
    fnames = model.main("tests/db")
    assert os.path.exists("tests/db/sqlite3")
    assert len(fnames) >= 1
    for fname in fnames:
        assert os.path.exists(fname)

def test_migrate():
    """Make sure goose migrations runs against the correct db and puts some sql there."""
    conn = model.LEIE("test", connect=False)
    if os.path.exists(conn.db_conf['open']):
        os.unlink(conn.db_conf['open'])
    conn = model.LEIE("test")    
    assert subprocess.check_output("echo .schema | sqlite3 %s" % conn.db_conf['open'], shell=True).decode("utf-8") == ""
    conn.migrate()
    assert subprocess.check_output("echo .schema | sqlite3 %s" % conn.db_conf['open'], shell=True).decode("utf-8") != ""
    conn.close()
    
def test_sql():
    """Make sure sql function returns something.

    We don't check that the migrations are valid sql.  Maybe we
    should.

    """
    
    conn = model.LEIE(connect=False)

    # At a minimum, there is one migration
    assert type(conn.sql(0)) == type("")
    
    # Make sure we get back a string and then None above a certain point
    max_reached = False
    for x in range(100):
        sql = conn.sql(x)
        if not max_reached:
            if sql:
                assert type(sql)==type("")
            else:
                assert sql == None
                max_reached = True
        else:
            assert sql == None

    
    conn.db_conf['driver'] = "LibraryDB"
    with pytest.raises(model.UnsupportedDBType) as exc_info:
        conn.sql(x)
    exception = exc_info.value
    assert str(exception) == "We don't have migrations for LibraryDB"

def test_unsupported_db_init():
    """Make sure we throw an error if the user names a weird db type"""
    with pytest.raises(model.UnsupportedDBType) as exc_info:
        conn = model.LEIE("test2")
    exception = exc_info.value
    assert str(exception) == "We don't support databases of type LibraryDB"
    

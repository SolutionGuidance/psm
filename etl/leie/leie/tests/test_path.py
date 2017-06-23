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

import path

def test_get_existing_file():
    # Setup
    os.makedirs("tests/exists", exist_ok=True)

    # Try some combinations of dirs that exist and don't exist in various orders
    assert path.get_existing_file([os.path.dirname(__file__), "tests/exists", "doesntexist"]) == os.path.dirname(__file__)
    assert path.get_existing_file(["doesntexist", os.path.dirname(__file__)]) == os.path.dirname(__file__)
    assert path.get_existing_file(["tests/exists", os.path.dirname(__file__), "doesntexist"]) == "tests/exists"

    # Should work the same with files
    assert path.get_existing_file([__file__, "tests/exists", "doesntexist"]) == __file__
    assert path.get_existing_file(["doesntexist", __file__]) == __file__
    assert path.get_existing_file(["tests/exists", __file__, "doesntexist"]) == "tests/exists"
    
    # Test fallback to default
    assert path.get_existing_file(["doesntexist"], "tests/exists") == "tests/exists"

    # Test create default dir
    assert path.get_existing_file(["doesntexist", "nope/me/neither"], "tests/doesnt/exist/yet", create=True) == "tests/doesnt/exist/yet"
    assert os.path.isdir("tests/doesnt/exist/yet")
    os.rmdir("tests/doesnt/exist/yet")

    # Test no default raises error
    with pytest.raises(FileNotFoundError) as exc_info:
        path.get_existing_file(["doesntexist"])
    exception = exc_info.value
    assert str(exception) == "[Errno 2] None of these exists: 'doesntexist'"

    # Test incompatible args raises error
    with pytest.raises(ValueError) as exc_info:
        path.get_existing_file(["doesntexist"], create=True)
    exception = exc_info.value
    assert str(exception) == "Can't create because no default specified!"
    
    # cleanup
    os.rmdir("tests/exists")


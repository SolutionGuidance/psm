#!/usr/bin/env python3

from contextlib import contextmanager
import os

@contextmanager
def cd(path):
    """Temporarily change directory"""
    old = os.getcwd()
    os.chdir(path)
    try:
        yield
    finally:
        os.chdir(old)

def get_existing_file(files, default=None, create=False):
    """FILES is a list of files or directories.  We cycle through and return a
    string containing the first one that exists.

    If none of them exist, and DEFAULT is set, return the DEFAULT

    If none of them exists and there is a DEFAULT and CREATE is True,
    we mkdir the path in DEFAULT and return the DEFAULT value.  Don't
    use this if you're dealing with files, not dirs.

    If none of them exist and DEFAULT is not set, we raise a
    FileNotFound error.

    If CREATE is True and default is not set, we raise a ValueError if
    none of the files exists.

    """
    for d in files:
        if os.path.exists(d):
            return d

    if default:
        if create:
            os.makedirs(default, exist_ok=True)
            return default
        else:
            return default
    else:
        if create:
            raise ValueError("Can't create because no default specified!")
        else:
            raise FileNotFoundError(2, "None of these exists", ",".join(files))

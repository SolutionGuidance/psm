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
        

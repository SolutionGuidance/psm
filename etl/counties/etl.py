#!/usr/bin/env python3

"""This script grabs
[LFE01MOE.xls](http://www2.census.gov/prod2/statcomp/usac/moe/LFE01MOE.xls)
from [the census
site](https://www.census.gov/support/USACdataMOE.html), extracts state
info and then generates json listing all the counties the census
department knows about.

The json is a dict with two top-level dicts, one called 'abbr' that
hashes state abbreviations to statenames.  The other is called
'counties'.  It hashes full state names to lists of counties for that
state.

To get dependencies:
    pip install petl requests simplejson xlrd
"""

import os
import petl as etl
import requests
import simplejson as json
import subprocess

class DownloadError(Exception):
    pass

abbr = {'AL':"Alabama", 'AK':"Alaska", 'AZ':"Arizona", 'AR':"Arkansas", 'CA':"California",
'CO':"Colorado", 'CT':"Connecticut", 'DE':"Delaware", 'DC':"District of Columbia", 'FL':"Florida",
'GA':"Georgia", 'HI':"Hawaii", 'ID':"Idaho", 'IL':"Illinois", 'IN':"Indiana",
'IA':"Iowa", 'KS':"Kansas", 'KY':"Kentucky", 'LA':"Louisiana", 'ME':"Maine",
'MD':"Maryland", 'MA':"Massachusetts", 'MI':"Michigan", 'MN':"Minnesota", 'MS':"Mississippi",
'MO':"Missouri", 'MT':"Montana", 'NE':"Nebraska", 'NV':"Nevada", 'NH':"New Hampshire",
'NJ':"New Jersey", 'NM':"New Mexico", 'NY':"New York", 'NC':"North Carolina", 'ND':"North Dakota",
'OH':"Ohio", 'OK':"Oklahoma", 'OR':"Oregon", 'PA':"Pennsylvania", 'RI':"Rhode Island",
'SC':"South Carolina", 'SD':"South Dakota", 'TN':"Tennessee", 'TX':"Texas", 'UT':"Utah",
'VT':"Vermont", 'VA':"Virginia", 'WA':"Washington", 'WV':"West Virginia", 'WI':"Wisconsin",
'WY':"Wyoming"}

# Get the file from the census website
fname = "LFE01MOE.xls"
if not os.path.exists(fname):
    url = "http://www2.census.gov/prod2/statcomp/usac/moe/LFE01MOE.xls"
    r = requests.get(url)
    if r.status_code != 200:
        raise DownloadError("Status %s. Can't download %s" % (r.status_code, url))
    with open(fname, 'wb') as OUTF:
        OUTF.write(r.content)

# Trim it down to just county data, then transform to a more
# convenient shape
xls = etl.fromxls("LFE01MOE.xls")
counties = etl.select(xls, lambda f: ',' in f.Area_name)
not_counties = etl.select(xls, lambda f: ',' in f.Area_name, complement=True)
counties = etl.cut(counties, 'Area_name')
counties = etl.rename(counties, 'Area_name', 'County')
counties = etl.addfield(counties, 'State', lambda f: abbr[f['County'].split(',')[1].strip()])
counties = etl.convert(counties, 'County', lambda f: f.split(',')[0].strip())

# Assemble the data structure that we'll pass to json
states={'abbr':abbr,
        'counties':{}}
for county,state in etl.data(counties):
    if not state in states['counties']:
        states['counties'][state] = []
    states['counties'][state].append(county)

# Dump it out to json
print (json.dumps(states, sort_keys=True, indent=4 * ' '))

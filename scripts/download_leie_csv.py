#!/usr/bin/env python2.7

'''This script downloads several CSV files from the LEIE website. It
takes a single optional argument on the command line, the directory to
download them into. If the user doesn't provide a desired directory
then the script downloads them into the current directory.

You shouldn't need to use it, since etl/leie/leie/etl.py , part of the
LEIE extract-transform-load process, gets those files and puts them
into the data pipeline for loading into the database and thus being
available to the PSM. But if you'd like to download and inspect the
CSVs to spot-check them, you can use this script.

'''

from bs4 import BeautifulSoup
from urllib2 import urlopen
import urllib
import sys
import os


def get_csv_urls():

    baseurl = 'https://oig.hhs.gov/exclusions/exclusions_list.asp'
    html = urlopen(baseurl)
    soup = BeautifulSoup(html, 'lxml')

    # Find content div.
    content = soup.find(id="leftContentInterior")

    # Find all the unordered lists.
    uls = content.findAll('ul')

    csvs= {}

    # The start of the URL.
    url_header = 'https://oig.hhs.gov'

    # Find the hrefs that contain the 3 different CSV files.
    # These tags hold the download links. The filenames change eevery month
    # (e.g., https://oig.hhs.gov/exclusions/downloadables/2017/1706EXCL.csv)
    # so we automatically find them by looking for the substring that,
    # as far as we can tell, doesn't change.

    for ul in uls:
        lis = ul.findAll('li')
	for li in lis:
            if 'UPDATED.csv' in li.find('a')['href'] or 'EXCL.csv' in li.find('a')['href'] or 'REIN.csv' in li.find('a')['href']:
                url = li.find('a')['href']
                url = url_header + url
                csvs[(li.find('a').getText())] = url

    if len(list(csvs.keys())) == 3:
        return csvs
    else:
        raise ValueError("https://oig.hhs.gov/exclusions/exclusions_list.asp doesn't link to three CSVs; check it.")


def save_csvs(directory, dict_of_urls):
    """ Save the CSV files to a directory when given the dictionary. """
    for key in dict_of_urls.keys():
        location = os.path.join(directory, ('-'.join(key.split(' ')) + '.csv'))
        save_file(dict_of_urls[key], location)


# Open a URL and save the file to the path.
def save_file(url, location):
    file_saver = urllib.URLopener()
    file_saver.retrieve(url, location)

if __name__=='__main__':
    d = get_csv_urls()
    if len(sys.argv) >= 2:
        save_csvs(sys.argv[1], d)
    else:
        save_csvs(os.curdir, d)

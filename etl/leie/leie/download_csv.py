#!/usr/bin/env python2.7

'''This script downloads the csv files off of the LEIE website'''

from bs4 import BeautifulSoup
from urllib2 import urlopen
import urllib


#Enter in the directory to save the files to. Enter in order: Updated, Excluded, Reinstated
def download_csv(directory):
	url = 'https://oig.hhs.gov/exclusions/exclusions_list.asp'
	html = urlopen(url)
	soup = BeautifulSoup(html, 'lxml')

	#find content div
	content = soup.find(id="leftContentInterior")

	#find all the unordered lists
	uls = content.findAll('ul')

	csv_urls = []
	csv_names = []

	#the start of the csv url link
	url_header = 'https://oig.hhs.gov'

	#find the hrefs that contain the 3 different csv files
	'''these tags hold the download links, which change every month. It's easier just to find 
	automatically find them each time rather than alter the script each month'''
	for ul in uls:
		lis = ul.findAll('li')
		for li in lis:
			if 'UPDATED.csv' in li.find('a')['href'] or 'EXCL.csv' in li.find('a')['href'] or 'REIN.csv' in li.find('a')['href']:
				url = li.find('a')['href']
				url = url_header + url
				csv_names.append(li.find('a').getText())
				csv_urls.append(url)

	#add the proper directory and .csv to the file names
	if len(csv_names) == len(csv_urls):	
		for i in range(len(csv_names)):
			csv_names[i] = directory + '-'.join(csv_names[i].split(' ')) + '.csv'
			save_file(csv_urls[i], csv_names[i])
	else:
		raise ValueError("Number of CSVs found was incorrect")



#will open a URL and save the file to the path
def save_file(url, location):
	file_saver = urllib.URLopener()
	file_saver.retrieve(url, location)


# if __name__=='__main__':
	# download_csv('/Users/Kevin/Documents/')


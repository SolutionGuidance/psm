from bs4 import BeautifulSoup
from urllib2 import urlopen
import urllib

#Enter in the paths to save the files to. Enter in order: Updated, Excluded, Reinstated
def download_csv(list_of_paths):
	url = 'https://oig.hhs.gov/exclusions/exclusions_list.asp'
	html = urlopen(url)
	soup = BeautifulSoup(html, 'lxml')

	#find content div
	content = soup.find(id="leftContentInterior")

	#find all the unordered lists
	uls = content.findAll('ul')

	csv_urls = []

	#the start of the csv url link
	url_header = 'https://oig.hhs.gov'

	#find the hrefs that contain the 3 different csv files
	for ul in uls:
		lis = ul.findAll('li')
		for li in lis:
			if 'UPDATED.csv' in li.find('a')['href'] or 'EXCL.csv' in li.find('a')['href'] or 'REIN.csv' in li.find('a')['href']:
				url = li.find('a')['href']
				url = url_header + url
				csv_urls.append(url)

	#save the files to their respective paths
	if len(list_of_paths) == len(csv_urls):
		for i in range(len(csv_urls)):
			save_file(csv_urls[i], list_of_paths[i])
	else:
		raise ValueError('Number of paths and number of files are not equal')


#will open a URL and save the file to the path
def save_file(url, path):
	file_saver = urllib.URLopener()
	file_saver.retrieve(url, path)



if __name__=='__main__':
	urls = ['test1.csv','test2.csv','test3.csv']
	download_csv(urls)
	# save_file()


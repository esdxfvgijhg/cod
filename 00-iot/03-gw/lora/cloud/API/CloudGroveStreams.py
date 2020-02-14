
import time
import datetime
import httplib
import random
import urllib
import urllib2
import ssl
import socket
import sys
import re
import key_GroveStreams
try:
	key_GroveStreams.source_list
except AttributeError:
	key_GroveStreams.source_list=[]
base_url = '/api/feed?'
connection_failure=False
def test_network_available():
	connection = False
	iteration = 0
	response = None
	while(not connection and iteration < 4) :
	    	try:
				response=urllib2.urlopen('https://www.grovestreams.com/', timeout=3)
				connection = True
	    	except urllib2.URLError, e: pass
			except socket.timeout: pass
			except ssl.SSLError: pass
	    	if(connection_failure and response is None) :
	    		print('GroveStreams: the server is still unavailable')
	    		iteration = 4
	    	elif(response is None) :
	    		print('GroveStreams: server unavailable, retrying to connect soon...')
	    		time.sleep(1)
	    		iteration += 1
	return connection
def send_data(data, src, nomenclatures):
	conn = httplib.HTTPConnection('www.grovestreams.com', timeout=10)
	try:
		url = base_url + "compId="+src
		i = 0
		while i < len(data) :
			url += "&"+nomenclatures[i]+"="+data[i]
			i += 1
		headers = {"Connection" : "close", "Content-type": "application/json", "Cookie" : "api_key="+key_GroveStreams.api_key}
		print('Grovestreams: Uploading feed to: ' + url)
		conn.request("PUT", url, "", headers)
		response = conn.getresponse()
		status = response.status
		if status != 200 and status != 201:
			try:
				if (response.reason != None):
					print('Grovestreams: HTTP Failure Reason: ' + response.reason + ' body: ' + response.read())
				else:
					print('Grovestreams: HTTP Failure Body: ' + response.read())
			except Exception:
				print('Grovestreams: HTTP Failure Status: %d' % (status) )
	except Exception as e:
		print('Grovestreams: HTTP Failure: ' + str(e))
	finally:
		if conn != None:
			conn.close()	
def grovestreams_uploadData(nomenclatures, data, src):
	connected = test_network_available()
	if(connected):
		print("GroveStreams: uploading")
		send_data(data, src, nomenclatures)
	else:
		print("Grovestreams: not uploading")
	global connection_failure
	connection_failure = not connected
def main(ldata, pdata, rdata, tdata, gwid):
	arr = map(int,pdata.split(','))
	dst=arr[0]
	ptype=arr[1]				
	src=arr[2]
	seq=arr[3]
	datalen=arr[4]
	SNR=arr[5]
	RSSI=arr[6]
	if dst==256:
		src_str="%0.8X" % src
	else:
		src_str=str(src)	
	if (src_str in key_GroveStreams.source_list) or (len(key_GroveStreams.source_list)==0):
		ldata=ldata.replace(' ', '')
		# get number of ' # but we accept also a_str#b_str
		nsharp = ldata.count('
		nslash=0
		data=['',''] #will field delimited by '
		if nsharp==0:
			nslash = ldata.count('/')
			data_array = data + re.split("/", ldata)		
		else:				
			data_array = re.split("#", ldata)
			if nsharp==1:
				nslash = data_array[1].count('/')
				data_array=data + re.split("/", data_array[1])	
			if nsharp==2:
				nslash = data_array[2].count('/')
				data_array=data + re.split("/", data_array[2])
		data_array[len(data_array)-1] = data_array[len(data_array)-1].replace('\n', '')
		data_array[len(data_array)-1] = data_array[len(data_array)-1].replace('\0', '')	
		i = 3
		while i < len(data_array) :
			while not data_array[i][len(data_array[i])-1].isdigit() :
				data_array[i] = data_array[i][:-1]
			i += 2
		nomenclatures = []
		data = []
		if nslash==0:
			nomenclatures.append("DEF")
			data.append(data_array[2])
		else:
			i=2
			while i < len(data_array)-1 :
				nomenclatures.append(data_array[i])
				data.append(data_array[i+1])
				i += 2
		grovestreams_uploadData(nomenclatures, data, "node_"+src_str)		
	else:
		print "Source is not is source list, not sending with CloudGroveStreams.py"			
if __name__ == "__main__":
	main(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])

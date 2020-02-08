import urllib2
import subprocess
import time
import ssl
import socket
import datetime
import sys
import re
import key_ThingSpeak

try:
    key_ThingSpeak.source_list
except AttributeError:
    key_ThingSpeak.source_list = []
try:
    key_ThingSpeak.field_association
except AttributeError:
    key_ThingSpeak.field_association = []
connection_failure = False
retry = False
_thingspeaksnr = False


def test_network_available():
    connection = False
    iteration = 0
    response = None
    while not connection and iteration < 4:
        try:
            response = urllib2.urlopen("https://api.thingspeak.com/", timeout=3)
            connection = True
        except urllib2.URLError, e:
            pass
        except socket.timeout:
            pass
        except ssl.SSLError:
            pass
        if connection_failure and response is None:
            print ("Thingspeak: the server is still unavailable")
            iteration = 4
        elif response is None:
            print ("Thingspeak: server unavailable, retrying to connect soon...")
            time.sleep(1)
            iteration += 1
    return connection


def send_data(data, second_data):
    global connection_failure
    print "rcv msg to log (\!) on ThingSpeak (",
    if data[0] == "":
        data[0] = key_ThingSpeak._def_thingspeak_channel_key
        print "default",
    else:
        print data[0],
    print ",",
    if data[1] == "":
        data[1] = "1"
        print "default",
    else:
        print data[1],
    print "): " + data[2]
    cmd = "curl -s -k -X POST --data " + "field" + data[1] + "=" + data[2] + "&field" + str(int(data[1]) + 4) + "=" + second_data + " https://api.thingspeak.com/update?key=" + data[0]
    print ("ThingSpeak: will issue curl cmd")
    print (cmd)
    args = cmd.split()
    if retry:
        out = "0"
        iteration = 0
        while out == "0" and iteration < 6 and not connection_failure:
            try:
                out = subprocess.check_output(args, shell=False)
                if out == "0":
                    print ("ThingSpeak: less than 15sec between posts, retrying in 3sec")
                    iteration += 1
                    time.sleep(3)
                else:
                    print ("ThingSpeak: returned code from server is %s" % out)
            except subprocess.CalledProcessError:
                print ("ThingSpeak: curl command failed (maybe a disconnection)")
                connection_failure = True
    else:
        try:
            out = subprocess.check_output(args, shell=False)
            if out == "0":
                print ("ThingSpeak: returned code from server is %s, do not retry" % out)
            else:
                print ("ThingSpeak: returned code from server is %s" % out)
        except subprocess.CalledProcessError:
            print ("ThingSpeak: curl command failed (maybe a disconnection)")
            connection_failure = True


def thingspeak_uploadSingleData(data, second_data):
    global connection_failure
    connected = test_network_available()
    if connected:
        connection_failure = False
        print ("ThingSpeak: uploading (single)")
        send_data(data, second_data)
    else:
        connection_failure = True
    if connection_failure:
        print ("ThingSpeak: not uploading")


def thingspeak_uploadMultipleData(src, data_array):
    global connection_failure
    connected = test_network_available()
    if connected:
        connection_failure = False
        print ("ThingSpeak: uploading (multiple)")
        print "rcv msg to log (\!) on ThingSpeak (",
        if data_array[0] == "":
            data_array[0] = key_ThingSpeak._def_thingspeak_channel_key
            print "default",
        else:
            print data_array[0],
        print ",",
        if len(key_ThingSpeak.field_association) == 0:
            defined_field_association = False
        else:
            defined_field_association = True
        found_field_association = False
        if defined_field_association == True:
            i = 0
            while i < len(key_ThingSpeak.field_association):
                if key_ThingSpeak.field_association[i][0] == src:
                    found_field_association = True
                    fieldNumber = key_ThingSpeak.field_association[i][1]
                    print fieldNumber,
                i = i + 1
        if (defined_field_association == False) or (found_field_association == False):
            if data_array[1] == "":
                fieldNumber = 1
                print "default",
            else:
                fieldNumber = int(data_array[1])
                print data_array[1],
        print "): "
        if found_field_association == True:
            print "field index set by field association"
        if len(data_array) == 3:
            iteration = 2
        else:
            iteration = 3
        cmd = "curl -s -k -X POST --data "
        while iteration < len(data_array):
            if iteration == 3:
                cmd += "field" + str(fieldNumber) + "=" + data_array[iteration]
            else:
                cmd += "&field" + str(fieldNumber) + "=" + data_array[iteration]
            iteration += 2
            fieldNumber += 1
        cmd += " https://api.thingspeak.com/update?key=" + data_array[0]
        print ("ThingSpeak: will issue curl cmd")
        print (cmd)
        args = cmd.split()
        if retry:
            out = "0"
            iteration = 0
            while out == "0" and iteration < 6 and not connection_failure:
                try:
                    out = subprocess.check_output(args, shell=False)
                    if out == "0":
                        print ("ThingSpeak: less than 15sec between posts, retrying in 3sec")
                        iteration += 1
                        time.sleep(3)
                    else:
                        print ("ThingSpeak: returned code from server is %s" % out)
                except subprocess.CalledProcessError:
                    print ("ThingSpeak: curl command failed (maybe a disconnection)")
                    connection_failure = True
        else:
            try:
                out = subprocess.check_output(args, shell=False)
                if out == "0":
                    print ("ThingSpeak: returned code from server is %s, do not retry" % out)
                else:
                    print ("ThingSpeak: returned code from server is %s" % out)
            except subprocess.CalledProcessError:
                print ("ThingSpeak: curl command failed (maybe a disconnection)")
                connection_failure = True
    else:
        connection_failure = True
    if connection_failure:
        print ("ThingSpeak: not uploading")


def thingspeak_setRetry(retry_bool):
    global retry
    retry = retry_bool


def main(ldata, pdata, rdata, tdata, gwid):
    arr = map(int, pdata.split(","))
    dst = arr[0]
    ptype = arr[1]
    src = arr[2]
    seq = arr[3]
    datalen = arr[4]
    SNR = arr[5]
    RSSI = arr[6]
    if dst == 256:
        src_str = "%0.8X" % src
    else:
        src_str = str(src)
    if (src_str in key_ThingSpeak.source_list) or (len(key_ThingSpeak.source_list) == 0):
        ldata = ldata.replace(" ", "")
        # ex: ##TC/22.4/HU/85... or TC/22.4/HU/85... or thingspeak_channel# # we use: thingspeak_channel#thingspeak_field
        # get number of ' # or #thingspeak_field
        nsharp = ldata.count("#")
        if nsharp == 0:
            data = ["", ""]
            data_array = data + re.split("/", ldata)
        elif nsharp == 1:
            data_array = re.split("#|/", ldata)
            if len(data_array[0]) > 1:
                data_array.insert(1, "")
            else:
                data_array.insert(0, "")
        else:
            data_array = re.split("#|/", ldata)
        data_array[len(data_array) - 1] = data_array[len(data_array) - 1].replace("\n", "")
        data_array[len(data_array) - 1] = data_array[len(data_array) - 1].replace("\0", "")
        i = 3
        while i < len(data_array):
            while not data_array[i][len(data_array[i]) - 1].isdigit():
                data_array[i] = data_array[i][:-1]
            i += 2
        nslash = ldata.count("/")
        index_first_data = 2
        if nslash == 0:
            index_first_data = 2
        else:
            index_first_data = 3
        second_data = str(seq)
        if _thingspeaksnr:
            second_data = str(SNR)
        data = []
        data.append(data_array[0])
        data.append(data_array[1])
        data.append(data_array[index_first_data])
        thingspeak_uploadMultipleData(src, data_array)
    else:
        print "Source is not is source list, not sending with CloudThingSpeak.py"


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])

import urllib2
import subprocess
import time
import ssl
import socket
import datetime
import sys
import os
import json
import re
import shlex
import key_Orion

try:
    key_Orion.source_list
except AttributeError:
    key_Orion.source_list = []
################################################### ###################################################
Orion_entity_not_created = "The requested entity has not been found"
connection_failure = False
retry = False
global CloudNoInternet_enabled
num_format = re.compile("^[\-]?[1-9][0-9]*\.?[0-9]+$")
cloud_filename = "clouds.json"
f = open(os.path.expanduser(cloud_filename), "r")
string = f.read()
f.close()
json_array = json.loads(string)
clouds = json_array["clouds"]
for cloud in clouds:
    if "CloudNoInternet.py" in cloud["script"]:
        try:
            CloudNoInternet_enabled = cloud["enabled"]
        except KeyError:
            print "enabled undefined"
            CloudNoInternet_enabled = False


def test_network_available():
    connection = False
    iteration = 0
    response = None
    while not connection and iteration < 4:
        try:
            response = urllib2.urlopen(key_Orion.orion_server, timeout=3)
            connection = True
        except urllib2.URLError, e:
            pass
        except socket.timeout:
            pass
        except ssl.SSLError:
            pass
        if connection_failure and response is None:
            print ("Orion: the server is still unavailable")
            iteration = 4
        elif response is None:
            print ("Orion: server unavailable, retrying to connect soon...")
            time.sleep(1)
            iteration += 1
    return connection


def create_new_entity(data, src, nomenclatures, tdata):
    global connection_failure
    print "Orion: create new entity"
    cmd = "curl " + key_Orion.orion_server + "/entities -s -S --header Content-Type:application/json --header Fiware-Service:" + data[0] + " --header Fiware-ServicePath:" + data[1] + ' -X POST -d \'{"id":"' + key_Orion.organization_name + "_" + src + '","type":"SensingDevice",'
    i = 0
    while i < len(data) - 2:
        cmd = cmd + '"' + nomenclatures[i] + '":{"value":'
        isnumber = re.match(num_format, data[i + 2])
        if isnumber:
            cmd = cmd + data[i + 2] + ',"type":"Number"'
        else:
            cmd = cmd + '"' + data[i + 2] + '","type":"String"'
        cmd = cmd + ',"metadata":{"timestamp":{"type":"DateTime","value":"' + tdata + '"}}}'
        i += 1
        if i < len(data) - 2:
            cmd = cmd + ","
    cmd = cmd + "}'"
    print "CloudOldOrion: will issue curl cmd"
    print (cmd)
    args = shlex.split(cmd)
    print args
    try:
        out = subprocess.check_output(args, shell=False)
        if out != "":
            print "Orion: returned msg from server is"
            print out
        else:
            print "Orion: entity creation success"
    except subprocess.CalledProcessError:
        print "Orion: curl command failed (maybe a disconnection)"
        connection_failure = True


def send_data(data, src, nomenclatures, tdata):
    global connection_failure
    entity_need_to_be_created = False
    i = 0
    if data[0] == "":
        data[0] = key_Orion.project_name
    if data[1] == "":
        data[1] = key_Orion.service_path
    while i < len(data) - 2 and not entity_need_to_be_created:
        cmd = "curl " + key_Orion.orion_server + "/entities/" + key_Orion.organization_name + "_" + src + "/attrs/ -s -S --header Content-Type:application/json --header Fiware-Service:" + data[0] + " --header Fiware-ServicePath:" + data[1] + " -X POST -d '{\"" + nomenclatures[i] + '":{"value":'
        isnumber = re.match(num_format, data[i + 2])
        if isnumber:
            cmd = cmd + data[i + 2] + ',"type":"Number"'
        else:
            cmd = cmd + '"' + data[i + 2] + '","type":"String"'
        cmd = cmd + ',"metadata":{"timestamp":{"type":"DateTime","value":"' + tdata + "\"}}}}'"
        i += 1
        print "CloudOldOrion: will issue curl cmd"
        print (cmd)
        args = shlex.split(cmd)
        print args
        if retry:
            out = "something"
            iteration = 0
            while out != "" and iteration < 6 and not connection_failure:
                try:
                    out = subprocess.check_output(args, shell=False)
                    if out != "":
                        print "Orion: returned msg from server is"
                        print out
                        print ("Orion: retrying in 3sec")
                        iteration += 1
                        time.sleep(3)
                    else:
                        "Orion: upload success"
                except subprocess.CalledProcessError:
                    print "Orion: curl command failed (maybe a disconnection)"
                    connection_failure = True
        else:
            try:
                out = subprocess.check_output(args, shell=False)
                if out != "":
                    print "Orion: returned msg from server is"
                    print out
                    if Orion_entity_not_created in out:
                        entity_need_to_be_created = True
                        create_new_entity(data, src, nomenclatures, tdata)
                else:
                    print "Orion: upload success"
            except subprocess.CalledProcessError:
                print "Orion: curl command failed (maybe a disconnection)"
                connection_failure = True


def Orion_uploadData(nomenclatures, data, src, tdata):
    connected = test_network_available()
    if connected:
        print ("Orion: uploading")
        send_data(data, src, nomenclatures, tdata)
    else:
        print ("Orion: not uploading")
    global connection_failure
    connection_failure = not connected


# 	mywaziup#/UPPA/test # 	/UPPA/test
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
    if (src_str in key_Orion.source_list) or (len(key_Orion.source_list) == 0):
        # get number of ' # but we accept also a_str#b_str
        nsharp = ldata.count("#")
        nslash = 0
        if nsharp == 0:
            data = ["", ""]
            nslash = ldata.count("/")
            data_array = data + re.split("/", ldata)
        else:
            data_array = re.split("#", ldata)
            if nsharp == 1:
                data_array.insert(0, "")
                if len(data_array[1]) < 3:
                    data_array[1] = ""
            if nsharp == 2:
                if len(data_array[0]) < 3:
                    data_array[0] = ""
                if len(data_array[1]) < 3:
                    data_array[1] = ""
            nslash = data_array[2].count("/")
            data_array = [data_array[0], data_array[1]] + re.split("/", data_array[2])
        data_array[len(data_array) - 1] = data_array[len(data_array) - 1].replace("\n", "")
        data_array[len(data_array) - 1] = data_array[len(data_array) - 1].replace("\0", "")
        nomenclatures = []
        data = []
        data.append(data_array[0])
        data.append(data_array[1])
        if nslash == 0:
            nomenclatures.append("DEF")
            data.append(data_array[2])
        else:
            i = 2
            while i < len(data_array) - 1:
                nomenclatures.append(data_array[i])
                data.append(data_array[i + 1])
                i += 2
        connected = test_network_available()
        if connected:
            print ("Orion: uploading")
            send_data(data, key_Orion.sensor_name + src_str, nomenclatures, tdata)
        else:
            print ("Orion: not uploading")
            if CloudNoInternet_enabled:
                print ("Using CloudNoInternet")
                from CloudNoInternet import store_internet_pending

                store_internet_pending(ldata, pdata, rdata, tdata, gwid)
        global connection_failure
        connection_failure = not connected
    else:
        print "Source is not is source list, not sending with CloudOrion.py"


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])

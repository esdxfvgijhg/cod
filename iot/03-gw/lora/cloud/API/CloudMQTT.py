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
import key_MQTT

try:
    key_MQTT.source_list
except AttributeError:
    key_MQTT.source_list = []
connection_failure = False


def test_network_available():
    connection = False
    iteration = 0
    response = None
    while not connection and iteration < 4:
        try:
            response = urllib2.urlopen("http://" + key_MQTT.MQTT_server, timeout=3)
            connection = True
        except urllib2.URLError, e:
            pass
        except socket.timeout:
            pass
        except ssl.SSLError:
            pass
        if connection_failure and response is None:
            print ("MQTT: the server is still unavailable")
            iteration = 4
        elif response is None:
            print ("MQTT: server unavailable, retrying to connect soon...")
            time.sleep(1)
            iteration += 1
    return connection


def send_data(data, src, nomenclatures, tdata):
    global connection_failure
    i = 0
    if data[0] == "":
        data[0] = key_MQTT.project_name
    if data[1] == "":
        data[1] = key_MQTT.organization_name
    while i < len(data) - 2:
        if nomenclatures == "":
            cmd = "mosquitto_pub -h " + key_MQTT.MQTT_server + " -t " + data[0] + "/" + data[1] + "/" + src + ' -m "' + data[i + 2] + '"'
        else:
            cmd = "mosquitto_pub -h " + key_MQTT.MQTT_server + " -t " + data[0] + "/" + data[1] + "/" + src + "/" + nomenclatures[i] + ' -m "' + data[i + 2] + '"'
        i += 1
        print "CloudMQTT: will issue cmd"
        print (cmd)
        args = shlex.split(cmd)
        print args
        try:
            out = subprocess.check_output(args, shell=False)
            if out != "":
                print "MQTT: returned msg from server is"
                print out
            else:
                print "MQTT: publish success"
        except subprocess.CalledProcessError:
            print "MQTT: publish command failed (maybe a disconnection)"
            connection_failure = True


def MQTT_uploadData(nomenclatures, data, src, tdata):
    connected = test_network_available()
    if connected:
        print ("MQTT: publishing")
        send_data(data, src, nomenclatures, tdata)
    else:
        print ("MQTT: not publishing")
    global connection_failure
    connection_failure = not connected


# 	waziup#UPPA # 	UPPA
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
    if (src_str in key_MQTT.source_list) or (len(key_MQTT.source_list) == 0):
        if ptype & 0x40 == 0x40 or ptype & 0x80 == 0x80 or ptype & 0x04 == 0x04:
            nomenclatures = ""
            data = ["", ""]
            data.append(ldata)
            MQTT_uploadData(nomenclatures, data, key_MQTT.sensor_name + src_str, tdata)
        else:
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
            MQTT_uploadData(nomenclatures, data, key_MQTT.sensor_name + src_str, tdata)
    else:
        print "Source is not is source list, not sending with CloudMQTT.py"


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])

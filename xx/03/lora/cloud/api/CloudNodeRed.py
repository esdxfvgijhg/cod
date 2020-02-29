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
import key_NodeRed

try:
    key_NodeRed.source_list
except AttributeError:
    key_NodeRed.source_list = []
_nodered_output_file = "nodered/nodered.txt"


def NodeRed_generateData(data, src, nomenclatures, tdata):
    i = 0
    if data[0] == "":
        data[0] = key_NodeRed.project_name
    if data[1] == "":
        data[1] = key_NodeRed.organization_name
    f = open(os.path.expanduser(_nodered_output_file), "a")
    while i < len(data) - 2:
        if nomenclatures == "":
            entry = '{"source":"' + data[0] + "/" + data[1] + "/" + src + '","measure":"","value":"' + data[i + 2] + '"}'
        else:
            entry = '{"source":"' + data[0] + "/" + data[1] + "/" + src + '","measure":"' + nomenclatures[i] + '","value":"' + data[i + 2] + '"}'
        print "CloudNodeRed: will generate json entry"
        print entry
        f.write(entry + "\n")
        i += 1
    f.close()


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
    if (src_str in key_NodeRed.source_list) or (len(key_NodeRed.source_list) == 0):
        if ptype & 0x40 == 0x40 or ptype & 0x80 == 0x80 or ptype & 0x04 == 0x04:
            nomenclatures = ""
            data = ["", ""]
            data.append(ldata)
            NodeRed_generateData(data, key_NodeRed.sensor_name + src_str, nomenclatures, tdata)
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
            NodeRed_generateData(data, key_NodeRed.sensor_name + src_str, nomenclatures, tdata)
    else:
        print "Source is not is source list, not generating with CloudNodeRed.py"


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])

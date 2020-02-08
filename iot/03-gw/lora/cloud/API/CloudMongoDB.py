import os
import json
import time
import datetime
import sys
import re

num_format = re.compile("^[\-]?[1-9][0-9]*\.?[0-9]+$")
global add_document, remove_if_new_month, mongodb_set_max_months
from MongoDB import add_document, remove_if_new_month, mongodb_set_max_months

cloud_filename = "clouds.json"
_enabled_clouds = []
f = open(os.path.expanduser(cloud_filename), "r")
string = f.read()
f.close()
json_array = json.loads(string)
clouds = json_array["clouds"]
for cloud in clouds:
    if "CloudMongoDB.py" in cloud["script"]:
        mongodb_set_max_months(cloud["max_months_to_store"])
        print "MongoDB with max months to store is %d" % cloud["max_months_to_store"]


def main(ldata, pdata, rdata, tdata, gwid):
    now = datetime.datetime.utcnow()
    arr = map(int, pdata.split(","))
    dst = arr[0]
    ptype = arr[1]
    src = arr[2]
    seq = arr[3]
    datalen = arr[4]
    SNR = arr[5]
    RSSI = arr[6]
    if dst == 256:
        src = src & 0x000000FF
    arr = map(int, rdata.split(","))
    bw = arr[0]
    cr = arr[1]
    sf = arr[2]
    # get number of ' # but we accept also a_str#b_str
    nsharp = ldata.count("#")
    nslash = 0
    data = ["", ""]  # will field delimited by '
    if nsharp == 0:
        nslash = ldata.count("/")
        data_array = data + re.split("/", ldata)
    else:
        data_array = re.split("#", ldata)
        if nsharp == 1:
            nslash = data_array[1].count("/")
            data_array = data + re.split("/", data_array[1])
        if nsharp == 2:
            nslash = data_array[2].count("/")
            data_array = data + re.split("/", data_array[2])
    data_array[len(data_array) - 1] = data_array[len(data_array) - 1].replace("\n", "")
    data_array[len(data_array) - 1] = data_array[len(data_array) - 1].replace("\0", "")
    print ("MongoDB: removing obsolete entries")
    remove_if_new_month(now)
    print ("MongoDB: saving the document in the collection...")
    str_json_data = "{"
    str_json_data += '"SNR":' + str(SNR) + ","
    str_json_data += '"RSSI":' + str(RSSI) + ","
    iteration = 2
    if nslash == 0:
        isnumber = re.match(num_format, data_array[iteration])
        if isnumber:
            str_json_data += '"DEF":' + data_array[iteration]
        else:
            str_json_data += '"DEF":"' + data_array[iteration] + '"'
    else:
        while iteration < len(data_array) - 1:
            isnumber = re.match(num_format, data_array[iteration + 1])
            if isnumber:
                str_json_data += '"' + data_array[iteration] + '":' + data_array[iteration + 1]
            else:
                str_json_data += '"' + data_array[iteration] + '":"' + data_array[iteration + 1] + '"'
            if iteration != len(data_array) - 2:
                str_json_data += ","
            iteration += 2
    str_json_data += "}"
    print str_json_data
    doc = {"type": ptype, "gateway_eui": gwid, "node_eui": src, "snr": SNR, "rssi": RSSI, "cr": cr, "datarate": "SF" + str(sf) + "BW" + str(bw), "time": now, "data": json.dumps(json.loads(str_json_data))}
    add_document(doc)
    print ("MongoDB: saving done")


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])

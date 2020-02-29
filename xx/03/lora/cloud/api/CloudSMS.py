import os
import re
import sys
import json
import libSMS
import key_SMS

global sm, always_enabled, gammurc_file
try:
    key_SMS.source_list
except AttributeError:
    key_SMS.source_list = []
cloud_filename = "clouds.json"
f = open(os.path.expanduser(cloud_filename), "r")
string = f.read()
f.close()
json_array = json.loads(string)
clouds = json_array["clouds"]
for cloud in clouds:
    if "CloudSMS.py" in cloud["script"]:
        try:
            always_enabled = cloud["always_enabled"]
        except KeyError:
            print "always_enabled undefined"
            always_enabled = False
        try:
            gammurc_file = cloud["gammurc_file"]
        except KeyError:
            gammurc_file = "/home/pi/.gammurc"
if not always_enabled:
    if libSMS.internet_ON():
        print ("Internet is available, no need to use the SMS Service")
        sys.exit()
try:
    gammurc_file = key_SMS.gammurc_file
except AttributeError:
    gammurc_file = "/home/pi/.gammurc"
if not libSMS.gammuCheck():
    print "CloudSMS: Gammu is not available"
    sys.exit()
else:
    if not libSMS.gammurcCheck(gammurc_file):
        print "CloudSMS: gammurc file is not available"
        sys.exit()
if libSMS.phoneConnection(gammurc_file, key_SMS.PIN) == None:
    print "CloudSMS: Can not connect to cellular network"
    sys.exit()
else:
    sm = libSMS.phoneConnection(gammurc_file, key_SMS.PIN)


def main(ldata, pdata, rdata, tdata, gwid):
    arr = map(int, pdata.split(","))
    dst = arr[0]
    ptype = arr[1]
    src = arr[2]
    seq = arr[3]
    datalen = arr[4]
    SNR = arr[5]
    RSSI = arr[6]
    arr = map(int, rdata.split(","))
    bw = arr[0]
    cr = arr[1]
    sf = arr[2]
    if dst == 256:
        src_str = "%0.8X" % src
    else:
        src_str = str(src)
    if (src_str in key_SMS.source_list) or (len(key_SMS.source_list) == 0):
        # ex: ##TC/22.4/HU/85... or TC/22.4/HU/85... or thingspeak_channel# # we use: thingspeak_channel#thingspeak_field
        # get number of ' # or #thingspeak_field
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
        sms_data = "SensorData Sensor" + src_str + " SNR " + str(SNR) + " RSSI " + str(RSSI) + " SN " + str(seq) + " BW " + str(bw) + " CR " + str(cr) + " SF " + str(sf) + " GWID " + gwid
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
        i = 0
        while i < len(data) - 2:
            sms_data += " " + nomenclatures[i] + " " + data[i + 2]
            i += 1
        success = False
        print ("rcv msg to send via the SMS Service: " + sms_data)
        success = libSMS.send_sms(sm, sms_data, key_SMS.contacts)
        if success:
            print "Sending SMS done"
    else:
        print "Source is not is source list, not sending with CloudSMS.py"


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])

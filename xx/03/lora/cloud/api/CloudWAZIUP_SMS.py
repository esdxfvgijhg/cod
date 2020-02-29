import os
import re
import sys
import json
import libSMS
import key_WAZIUP
import key_WAZIUP_SMS

try:
    key_WAZIUP.source_list
except AttributeError:
    key_WAZIUP.source_list = []
global sm, always_enabled, gammurc_file
cloud_filename = "clouds.json"
f = open(os.path.expanduser(cloud_filename), "r")
string = f.read()
f.close()
json_array = json.loads(string)
clouds = json_array["clouds"]
for cloud in clouds:
    if "CloudWAZIUP_SMS.py" in cloud["script"]:
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
    gammurc_file = key_WAZIUP_SMS.gammurc_file
except AttributeError:
    gammurc_file = "/home/pi/.gammurc"
if not libSMS.gammuCheck():
    print "CloudWAZIUP_SMS: Gammu is not available"
    sys.exit()
else:
    if not libSMS.gammurcCheck(gammurc_file):
        print "CloudWAZIUP_SMS: gammurc file is not available"
        sys.exit()
if libSMS.phoneConnection(gammurc_file, key_WAZIUP_SMS.PIN) == None:
    print "CloudWAZIUP_SMS: Can not connect to cellular network"
    sys.exit()
else:
    sm = libSMS.phoneConnection(gammurc_file, key_WAZIUP_SMS.PIN)


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
    if (src_str in key_WAZIUP.source_list) or (len(key_WAZIUP.source_list) == 0):
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
                if len(data_array[0]) < 3 or len(data_array[1]) < 3:
                    data_array[0] = ""
                    data_array[1] = ""
            nslash = data_array[2].count("/")
            data_array = [data_array[0], data_array[1]] + re.split("/", data_array[2])
        data_array[len(data_array) - 1] = data_array[len(data_array) - 1].replace("\n", "")
        data_array[len(data_array) - 1] = data_array[len(data_array) - 1].replace("\0", "")
        sms_data = "SensorData " + key_WAZIUP.sensor_name + src_str
        i = 2
        while i < len(data_array) - 1:
            sms_data += " " + data_array[i] + " " + data_array[i + 1]
            i += 2
        if data_array[0] == "":
            data_array[0] = key_WAZIUP.project_name
        if data_array[1] == "":
            data_array[1] = key_WAZIUP.service_path
        sms_data += " " + data_array[0] + " " + data_array[1]
        success = False
        print ("rcv msg to send via the WAZIUP SMS Service: " + sms_data)
        success = libSMS.send_sms(sm, sms_data, key_WAZIUP_SMS.contacts)
        if success:
            print "Sending SMS done"
    else:
        print "Source is not is source list, not sending with CloudWAZIUP_SMS.py"


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])

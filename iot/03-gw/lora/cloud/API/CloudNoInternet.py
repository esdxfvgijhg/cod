import os
import sys
import os.path
import json
import requests
import key_NoInternet

try:
    key_NoInternet.source_list
except AttributeError:
    key_NoInternet.source_list = []
_internet_pending_file = "delayed_uploading/internet_pending.txt"


def checkNet():
    print "CloudNoInternet checks Internet connectivity with www.google.com"
    try:
        response = requests.get("http://www.google.com")
        print "response code: " + str(response.status_code)
        return True
    except requests.ConnectionError:
        print "No Internet"
        return False


def is_internet_pending():
    try:
        if os.path.isfile(os.path.expanduser(_internet_pending_file)):
            return True
        else:
            return False
    except FileNotFoundError:
        print "File not found"


def store_internet_pending(ldata, pdata, rdata, tdata, gwid):
    try:
        data = '{"ldata":"' + ldata.replace("\n", "") + '","pdata":"' + pdata.replace("\n", "") + '","rdata":"' + rdata.replace("\n", "") + '","tdata":"' + tdata.replace("\n", "") + '","gwid":"' + gwid.replace("\n", "") + '"}'
        print data
        if is_internet_pending():
            f = open(os.path.expanduser(_internet_pending_file), "a")
        else:
            f = open(os.path.expanduser(_internet_pending_file), "w")
        f.write(data + "\n")
        f.close()
    except IOError:
        print "Unable to open file"


def upload_internet_pending():
    print "delayed uploading: checking for " + _internet_pending_file
    if is_internet_pending():
        try:
            if os.path.getsize(os.path.expanduser(_internet_pending_file)) > 0:
                lines = []
                print "delayed uploading: reading " + _internet_pending_file
                f = open(os.path.expanduser(_internet_pending_file), "r")
                lines = f.readlines()
                f.close()
                for line in lines:
                    line = line.replace("\r", "")
                    if len(line) > 1 or line != "\n":
                        line_json = json.loads(line)
                        try:
                            cloud_script = key_NoInternet.execute
                            print "uploading with " + cloud_script
                            sys.stdout.flush()
                            cmd_arg = cloud_script + ' "' + line_json["ldata"].replace("\n", "") + '"' + ' "' + line_json["pdata"].replace("\n", "") + '"' + ' "' + line_json["rdata"].replace("\n", "") + '"' + ' "' + line_json["tdata"].replace("\n", "") + '"' + ' "' + line_json["gwid"].replace("\n", "") + '"'
                        except UnicodeDecodeError, ude:
                            print ude
                        else:
                            print cmd_arg
                            sys.stdout.flush()
                            try:
                                os.system(cmd_arg)
                            except:
                                print "Error when uploading data to the cloud"
                print "delayed uploading: all internet pending data uploaded"
                os.remove(os.path.expanduser(_internet_pending_file))
            else:
                print "delayed uploading: no internet pending data"
        except IOError:
            print "Unable to open file"
    else:
        print "delayed uploading: none existing internet_pending.txt"


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
    if (src_str in key_NoInternet.source_list) or (len(key_NoInternet.source_list) == 0):
        if checkNet():
            print "Detected Internet connectivity"
            upload_internet_pending()
        else:
            print "delayed uploading: storing in " + _internet_pending_file
            store_internet_pending(ldata, pdata, rdata, tdata, gwid)
    else:
        print "Source is not is source list, no processing with CloudNoInternet.py"


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])

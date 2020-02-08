import os
import sys
import os.path
import re
import libSMS
from math import radians, cos, sin, asin, sqrt, atan2, degrees
import json
import codecs
import datetime
from dateutil import parser

_gps_jsonfile = "gps/gps.json"
_active_gps_jsonfile = "gps/active_gps.json"
_gps_file = "gps/gps.txt"
import key_GpsFile

try:
    key_GpsFile.source_list
except AttributeError:
    key_GpsFile.source_list = []


def haversine(pointA, pointB):
    if (type(pointA) != tuple) or (type(pointB) != tuple):
        raise TypeError("GPS file: Only tuples are supported as arguments")
    lat1 = pointA[0]
    lon1 = pointA[1]
    lat2 = pointB[0]
    lon2 = pointB[1]
    lat1, lon1, lat2, lon2 = map(radians, [lat1, lon1, lat2, lon2])
    dlon = lon2 - lon1
    dlat = lat2 - lat1
    a = sin(dlat / 2) ** 2 + cos(lat1) * cos(lat2) * sin(dlon / 2) ** 2
    c = 2 * asin(sqrt(a))
    r = 6371
    return c * r


def initial_bearing(pointA, pointB):
    if (type(pointA) != tuple) or (type(pointB) != tuple):
        raise TypeError("GPS file: Only tuples are supported as arguments")
    lat1 = radians(pointA[0])
    lat2 = radians(pointB[0])
    diffLong = radians(pointB[1] - pointA[1])
    x = sin(diffLong) * cos(lat2)
    y = cos(lat1) * sin(lat2) - (sin(lat1) * cos(lat2) * cos(diffLong))
    initial_bearing = atan2(x, y)
    initial_bearing = degrees(initial_bearing)
    compass_bearing = (initial_bearing + 360) % 360
    return compass_bearing


def update_gps_device(src, SNR, RSSI, seq, bc, lat, lgt, fxt, distance, tdata, gwid):
    try:
        f = open(os.path.expanduser(_gps_jsonfile), "r")
        string = f.read()
        f.close()
        gps_json_array = json.loads(string)
        gps_devices = gps_json_array["devices"]
    except IOError:
        gps_json_array = json.loads('{ "devices":[]}')
        gps_devices = gps_json_array["devices"]
    found_device = False
    for device in gps_devices:
        if src == device["src"]:
            found_device = True
            device["snr"] = SNR
            device["rssi"] = RSSI
            device["seq"] = seq
            device["bc"] = bc
            device["time"] = tdata
            device["gw"] = gwid
            device["fxt"] = int(fxt)
            device["lat"] = float(lat)
            device["lgt"] = float(lgt)
            device["distance"] = float(distance)
            device["active"] = "yes"
    if found_device == False:
        new_device = {}
        new_device["src"] = src
        new_device["snr"] = SNR
        new_device["rssi"] = RSSI
        new_device["seq"] = seq
        new_device["bc"] = bc
        new_device["time"] = tdata
        new_device["gw"] = gwid
        new_device["fxt"] = int(fxt)
        new_device["lat"] = float(lat)
        new_device["lgt"] = float(lgt)
        new_device["distance"] = float(distance)
        new_device["active"] = "yes"
        new_device["name"] = key_GpsFile.project_name + "_" + key_GpsFile.organization_name + "_" + key_GpsFile.sensor_name + src
        gps_devices.append(new_device)
    active_gps_json_array = json.loads('{ "devices":[]}')
    active_gps_devices = active_gps_json_array["devices"]
    localdt = datetime.datetime.now()
    tnow = localdt.replace(microsecond=0).isoformat()
    now = parser.parse(tnow)
    for device in gps_devices:
        t1 = parser.parse(device["time"])
        diff = now - t1
        if diff.total_seconds() < key_GpsFile.active_interval_minutes * 60:
            device["active"] = u"yes"
            active_gps_devices.append(device)
        else:
            device["active"] = u"no"
    with open(os.path.expanduser(_gps_jsonfile), "w") as f:
        json.dump(gps_json_array, codecs.getwriter("utf-8")(f), ensure_ascii=False, indent=4)
    with open(os.path.expanduser(_active_gps_jsonfile), "w") as f:
        json.dump(active_gps_json_array, codecs.getwriter("utf-8")(f), ensure_ascii=False, indent=4)


def store_gps_coordinate(src, SNR, RSSI, seq, bc, lat, lgt, fxt, tdata, gwid):
    gwconf_filename = "gateway_conf.json"
    f = open(os.path.expanduser(gwconf_filename), "r")
    lines = f.readlines()
    f.close()
    array = ""
    for line in lines:
        array += line
    gw_json_array = json.loads(array)
    try:
        _gw_lat = gw_json_array["gateway_conf"]["ref_latitude"]
    except KeyError:
        _gw_lat = "undef"
    try:
        _gw_long = gw_json_array["gateway_conf"]["ref_longitude"]
    except KeyError:
        _gw_long = "undef"
    try:
        gw_lat = float(_gw_lat)
    except ValueError:
        _gw_lat = "undef"
    try:
        gw_long = float(_gw_long)
    except ValueError:
        _gw_long = "undef"
    if (_gw_lat == "undef") or (_gw_long == "undef"):
        print "GPS file: gw has no valid GPS coordinate"
        distance = -1
    else:
        pA = (gw_lat, gw_long)
        pB = (float(lat), float(lgt))
        distance = haversine(pA, pB)
    f = open(os.path.expanduser(_gps_file), "a")
    data = "src " + src + " seq " + str(seq) + " bc " + str(bc) + " snr " + str(SNR) + " rssi " + str(RSSI) + " time " + tdata + " gw " + gwid + " fxt " + fxt + " lat " + lat + " lgt " + lgt + " distance " + str("%.4f" % distance)
    f.write(data + "\n")
    f.close()
    print "GPS file: lat=" + lat
    print "GPS file: lgt=" + lgt
    print "GPS file: d=" + "%.4f" % distance
    update_gps_device(src, SNR, RSSI, seq, bc, lat, lgt, fxt, str("%.4f" % distance), tdata, gwid)
    if key_GpsFile.SMS == True:
        try:
            gammurc_file = key_GpsFile.gammurc_file
        except AttributeError:
            gammurc_file = "/home/pi/.gammurc"
        print "GPS file: SMS is requested"
        if not libSMS.gammuCheck():
            print "GPS file: Gammu is not available"
            sys.exit()
        else:
            if not libSMS.gammurcCheck(gammurc_file):
                print "GPS file: gammurc file is not available"
                sys.exit()
        if libSMS.phoneConnection(gammurc_file, key_GpsFile.PIN) == None:
            print "GPS file: Can not connect to cellular network"
            sys.exit()
        else:
            sm = libSMS.phoneConnection(gammurc_file, key_GpsFile.PIN)
        print "GPS file: Sending SMS"
        success = libSMS.send_sms(sm, data, key_GpsFile.contacts)
        if success:
            print "GPS file: Sending SMS done"


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
    if (src_str in key_GpsFile.source_list) or (len(key_GpsFile.source_list) == 0):
        ldata = ldata.replace(" ", "")
        ldata_array = re.split("/", ldata)
        try:
            lat_index = ldata_array.index("LAT")
        except ValueError:
            lat_index = -1
        try:
            lgt_index = ldata_array.index("LGT")
        except ValueError:
            lgt_index = -1
        try:
            fxt_index = ldata_array.index("FXT")
        except ValueError:
            fxt_index = -1
        try:
            bc_index = ldata_array.index("BC")
        except ValueError:
            bc_index = -1
        if bc_index == -1:
            bc = -1
        else:
            bc = int(ldata_array[bc_index + 1])
        if (lat_index == -1) or (lgt_index == -1) or (fxt_index == -1):
            print "GPS file: No GPS fields"
        else:
            if ldata_array[fxt_index + 1] == "-1":
                print "GPS file: No GPS fix"
            else:
                lat = ldata_array[lat_index + 1]
                lgt = ldata_array[lgt_index + 1]
                fxt = ldata_array[fxt_index + 1]
                the_time = parser.parse(tdata)
                tdata = the_time.replace(microsecond=0, tzinfo=None).isoformat()
                store_gps_coordinate(src_str, SNR, RSSI, seq, bc, lat, lgt, fxt, tdata, gwid)


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])

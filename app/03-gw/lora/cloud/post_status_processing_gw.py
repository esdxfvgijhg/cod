dateutil_tz = True
import sys
import subprocess
import select
import threading
from threading import Timer
import time
import datetime

try:
    import dateutil.tz
except ImportError:
    print "no timezone support, time will be expressed only in local time"
    dateutil_tz = False
import getopt
import os
import os.path
import json

cloud_filename = "clouds.json"
f = open(os.path.expanduser(cloud_filename), "r")
string = f.read()
f.close()
json_array = json.loads(string)
clouds = json_array["clouds"]
gwconf_filename = "gateway_conf.json"
f = open(os.path.expanduser(gwconf_filename), "r")
lines = f.readlines()
f.close()
array = ""
for line in lines:
    array += line
gw_json_array = json.loads(array)
_gwid = gw_json_array["gateway_conf"]["gateway_ID"]
try:
    _gw_lat = gw_json_array["gateway_conf"]["ref_latitude"]
except KeyError:
    _gw_lat = "undef"
try:
    _gw_long = gw_json_array["gateway_conf"]["ref_longitude"]
except KeyError:
    _gw_long = "undef"


def show_gps():
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
    print "post status show GPS: current GPS coordinate: gw lat " + _gw_lat + " long " + _gw_long


def get_gps():
    try:
        gps_port = gw_json_array["status_conf"]["gps_port"]
    except KeyError:
        print "post status get GPS: no GPS port in gateway_conf.json, use default"
        gps_port = ""
    gw_gps_file = "/home/pi/lora_gateway/gateway_gps.txt"
    print "post status get GPS: use sensors_in_raspi/get_gps.py to get GPS position"
    try:
        os.system("python sensors_in_raspi/get_gps.py " + gps_port)
    except:
        print "post status get GPS: Error when executing sensors_in_raspi/get_gps.py"
    if os.path.isfile(os.path.expanduser(gw_gps_file)):
        with open(os.path.expanduser(gw_gps_file), "r") as gps_file:
            gps_data = gps_file.read().replace("\n", "")
            gps_data = gps_data.split(",")
        lat_str = gps_data[0]
        lgt_str = gps_data[1]
        cmd = """sed -i -- 's/"ref_latitude.*,/"ref_latitude" : """ + '"' + lat_str + '"' + """,/g' /home/pi/lora_gateway/gateway_conf.json"""
        try:
            print "post status get GPS: replacing GPS latitude in gateway_conf.json"
            os.system(cmd)
        except:
            print "post status get GPS: Error when replacing GPS latitude in gateway_conf.json"
            return
        cmd = """sed -i -- 's/"ref_longitude.*,/"ref_longitude" : """ + '"' + lgt_str + '"' + """,/g' /home/pi/lora_gateway/gateway_conf.json"""
        try:
            print "post status get GPS: replacing GPS longitude in gateway_conf.json"
            os.system(cmd)
        except:
            print "post status get GPS: Error when replacing GPS longitude in gateway_conf.json"
            return
    else:
        print "post status get GPS: no GPS coordinates"


def get_dht22():
    try:
        _dht22_mongo = gw_json_array["status_conf"]["dht22_mongo"]
    except KeyError:
        _dht22_mongo = False
    if _dht22_mongo:
        global add_document
        from MongoDB import add_document
    print "post status get DHT22: get gateway temperature and humidity level"
    sys.path.insert(0, os.path.expanduser("./sensors_in_raspi/dht22"))
    from read_dht22 import get_dht22_values

    _humidity, _temperature = get_dht22_values()
    _date_save_dht22 = datetime.datetime.now()
    print "post status get DHT22: Gateway TC : " + _temperature + " C | HU : " + _humidity + " % at " + str(_date_save_dht22)
    if _dht22_mongo:
        str_json_data = '{"th":' + _temperature + ', "hu":' + _humidity + "}"
        doc = {"type": "DATA_GW_DHT22", "gateway_eui": _gwid, "node_eui": "gw", "snr": "", "rssi": "", "cr": "", "datarate": "", "time": _date_save_dht22, "data": json.dumps(json.loads(str_json_data))}
        add_document(doc)


def copy_log():
    print "post status copy log: extract last 500 lines of post-processing.log into /var/www/html/admin/log/post-processing-500L.log"
    cmd = "sudo tail -n 500 log/post-processing.log > /var/www/html/admin/log/post-processing-500L.log"
    try:
        os.system(cmd)
    except:
        print "post status copy log: Error when extracting lines from post-processing_" + _gwid + ".log"
    cmd = "sudo chown -R pi:www-data /var/www/html/admin/log"
    try:
        os.system(cmd)
    except:
        print "post status copy log: Error when setting file ownership to pi:www-data"


def main(stats_str):
    print "post status: start running"
    sys.stdout.flush()
    arr = map(int, stats_str.split(","))
    rxnb = arr[0]
    rxok = arr[1]
    rxfw = arr[2]
    ackr = arr[3]
    dwnb = arr[4]
    txnb = arr[5]
    try:
        dynamic_gps = gw_json_array["status_conf"]["dynamic_gps"]
    except KeyError:
        dynamic_gps = False
    if dynamic_gps:
        print "post status: dynamic GPS is requested"
        get_gps()
    try:
        get_dht22 = gw_json_array["status_conf"]["dht22"]
    except KeyError:
        get_dht22 = False
    if get_dht22:
        print "post status: DHT22 temperature/humidity is requested"
        get_dht22()
    try:
        copy_log = gw_json_array["status_conf"]["copy_post_processing_log"]
    except KeyError:
        copy_log = False
    if copy_log:
        print "post status: copy log file is requested"
        copy_log()
    try:
        ttn_status = gw_json_array["status_conf"]["ttn_status"]
    except KeyError:
        ttn_status = False
    lora_mode = gw_json_array["radio_conf"]["mode"]
    if lora_mode != 11:
        ttn_status = False
    if ttn_status:
        ttn_gwid = _gwid[4:10] + "FFFF" + _gwid[10:]
        gps_str = _gw_lat + "," + _gw_long
        try:
            cmd_arg = "python scripts/ttn/ttn_stats.py" + ' "' + stats_str + '"' + ' "' + gps_str + '"' + ' "' + ttn_gwid + '"'
            os.system(cmd_arg)
        except:
            print "post status: error when executing %s" % cmd_arg
    print "post status: exiting"
    sys.stdout.flush()


if __name__ == "__main__":
    main(sys.argv[1])

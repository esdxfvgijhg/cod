import urllib2
import requests
import time
import datetime
from dateutil import parser
import sys
import os
import json
import re
import md5
import key_WAZIUP

try:
    key_WAZIUP.source_list
except AttributeError:
    key_WAZIUP.source_list = []
connection_failure = False
current_token = "notoken"
last_token_time = "notime"
token_valid_time_in_seconds = 2 * 60
WAZIUP_headers = {"accept": "application/json", "content-type": "application/json"}
gw_id_md5 = ""
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
            response = urllib2.urlopen(key_WAZIUP.waziup_server + "/sensors", timeout=3)
            connection = True
        except urllib2.URLError, e:
            pass
        except socket.timeout:
            pass
        except ssl.SSLError:
            pass
        if connection_failure and response is None:
            print ("WAZIUP: the server is still unavailable")
            iteration = 4
        elif response is None:
            print ("WAZIUP: server unavailable, retrying to connect soon...")
            time.sleep(1)
            iteration += 1
    return connection


def get_token():
    global connection_failure
    global current_token
    global last_token_time
    global token_valid_time_in_seconds
    global WAZIUP_headers
    if key_WAZIUP.username == "guest":
        if current_token != "guest":
            print "CloudWAZIUP: run under guest identity, all data is public"
            current_token = "guest"
        WAZIUP_headers = {"accept": "application/json", "content-type": "application/json"}
        key_WAZIUP.visibility = "public"
        return current_token
    ask_new_token = False
    if current_token == "notoken":
        ask_new_token = True
    else:
        token_elapsed_time = datetime.datetime.now() - last_token_time
        if token_elapsed_time.total_seconds() > token_valid_time_in_seconds:
            ask_new_token = True
    if ask_new_token:
        WAZIUP_url = key_WAZIUP.waziup_server + "/auth/token"
        my_WAZIUP_headers = {"accept": "application/json", "content-type": "application/json"}
        WAZIUP_data = '{"username":"' + key_WAZIUP.username + '","password":"' + key_WAZIUP.password + '"}'
        print "CloudWAZIUP: get token for " + key_WAZIUP.username
        print "CloudWAZIUP: will issue requests with"
        print "url: " + WAZIUP_url
        current_token = "notoken"
        try:
            response = requests.post(WAZIUP_url, headers=my_WAZIUP_headers, data=WAZIUP_data, timeout=30)
            print "CloudWAZIUP: returned msg from server is ",
            print response.status_code
            print response.reason
            if 200 <= response.status_code < 300:
                print "CloudWAZIUP: got token"
                current_token = response.text
                WAZIUP_headers = {"accept": "application/json", "content-type": "application/json", "Authorization": "Bearer " + current_token}
                last_token_time = datetime.datetime.now()
            else:
                print "CloudWAZIUP: authorization failed"
                print response.text
        except requests.exceptions.RequestException as e:
            print e
            print "CloudWAZIUP: requests command failed (maybe a disconnection)"
            connection_failure = True
    return current_token


def create_new_measurement(entity, nomenclature):
    global connection_failure
    global gw_id_md5
    my_token = get_token()
    if my_token == "notoken":
        return False
    WAZIUP_url = key_WAZIUP.waziup_server + "/sensors" + "/" + entity + "/measurements"
    WAZIUP_data = '{"id":"' + nomenclature + '"}'
    print "CloudWAZIUP: create new measurement"
    print "CloudWAZIUP: will issue requests with"
    print "url: " + WAZIUP_url
    print "data: " + WAZIUP_data
    try:
        response = requests.post(WAZIUP_url, headers=WAZIUP_headers, data=WAZIUP_data, timeout=30)
        print "CloudWAZIUP: returned msg from server is ",
        print response.status_code
        print response.reason
        if 200 <= response.status_code < 300:
            print "CloudWAZIUP: measurement creation success"
            return True
        else:
            print "CloudWAZIUP: error in creating measurement"
            print response.text
            return False
    except requests.exceptions.RequestException as e:
        print e
        print "CloudWAZIUP: requests command failed (maybe a disconnection)"
        connection_failure = True
    return False


def does_measurement_exist(entity, nomenclature):
    global connection_failure
    my_token = get_token()
    if my_token == "notoken":
        return False
    WAZIUP_url = key_WAZIUP.waziup_server + "/sensors"
    WAZIUP_url = WAZIUP_url + "/" + entity
    WAZIUP_url = WAZIUP_url + "/measurements/" + nomenclature
    print "CloudWAZIUP: check if measurement exists"
    print "CloudWAZIUP: will issue requests with"
    print "url: " + WAZIUP_url
    try:
        response = requests.get(WAZIUP_url, headers=WAZIUP_headers, data="", timeout=30)
        print "CloudWAZIUP: returned msg from server is ",
        print response.status_code
        print response.reason
        if response.status_code == 404:
            print "CloudWAZIUP: measurement does not exist"
            return False
        elif 200 <= response.status_code < 300:
            print "CloudWAZIUP: measurement exists"
            return True
        else:
            print "CloudWAZIUP: error in checking measurement"
            print response.text
            return False
    except requests.exceptions.RequestException as e:
        print e
        print "CloudWAZIUP: requests command failed (maybe a disconnection)"
        connection_failure = True
    if connection_failure:
        return False


def does_entity_exist(entity):
    global connection_failure
    my_token = get_token()
    if my_token == "notoken":
        return False
    WAZIUP_url = key_WAZIUP.waziup_server + "/sensors"
    WAZIUP_url = WAZIUP_url + "/" + entity
    print "CloudWAZIUP: check if entity exists"
    print "CloudWAZIUP: will issue requests with"
    print "url: " + WAZIUP_url
    try:
        response = requests.get(WAZIUP_url, headers=WAZIUP_headers, data="", timeout=30)
        print "CloudWAZIUP: returned msg from server is ",
        print response.status_code
        print response.reason
        if response.status_code == 404:
            print "CloudWAZIUP: entity does not exist"
            return False
        elif 200 <= response.status_code < 300:
            print "CloudWAZIUP: entity exists"
            return True
        else:
            print "CloudWAZIUP: error in checking entity"
            print response.text
            return False
    except requests.exceptions.RequestException as e:
        print e
        print "CloudWAZIUP: requests command failed (maybe a disconnection)"
        connection_failure = True
    if connection_failure:
        return False


def create_new_entity(data, entity, nomenclatures, tdata):
    global connection_failure
    global gw_id_md5
    my_token = get_token()
    if my_token == "notoken":
        return False
    WAZIUP_url = key_WAZIUP.waziup_server + "/sensors"
    WAZIUP_data = '{"id":"' + entity + '","gateway_id":"' + gw_id_md5 + '","domain":"' + key_WAZIUP.project_name + "-" + key_WAZIUP.organization_name + key_WAZIUP.service_tree + '"'
    if key_WAZIUP.visibility == "private":
        WAZIUP_data = WAZIUP_data + ',"visibility":"private"'
    else:
        WAZIUP_data = WAZIUP_data + ',"visibility":"public"'
    WAZIUP_data = WAZIUP_data + "}"
    print "CloudWAZIUP: create new entity"
    print "CloudWAZIUP: will issue requests with"
    print "url: " + WAZIUP_url
    print "data: " + WAZIUP_data
    try:
        response = requests.post(WAZIUP_url, headers=WAZIUP_headers, data=WAZIUP_data, timeout=30)
        print "CloudWAZIUP: returned msg from server is ",
        print response.status_code
        print response.reason
        if 200 <= response.status_code < 300:
            print "CloudWAZIUP: entity creation success"
            print "CloudWAZIUP: create measurements for new entity"
            i = 0
            while i < len(nomenclatures):
                create_new_measurement(entity, nomenclatures[i])
                i += 1
        else:
            print "CloudWAZIUP: error in creating entity"
            print response.text
            return False
    except requests.exceptions.RequestException as e:
        print e
        print "CloudWAZIUP: requests command failed (maybe a disconnection)"
        connection_failure = True
    if connection_failure:
        return False
    else:
        return True


def send_data(data, entity, nomenclatures, tdata):
    global connection_failure
    if data[0] == "":
        data[0] = key_WAZIUP.project_name
    if data[1] == "":
        data[1] = key_WAZIUP.service_path
    my_token = get_token()
    if my_token == "notoken":
        return False
    if does_entity_exist(entity) == False:
        if create_new_entity(data, entity, nomenclatures, tdata) == False:
            return False
    i = 0
    while i < len(data) - 2:
        if does_measurement_exist(entity, nomenclatures[i]) == False:
            if create_new_measurement(entity, nomenclatures[i]) == False:
                return False
        WAZIUP_url = key_WAZIUP.waziup_server + "/sensors/" + entity + "/measurements/" + nomenclatures[i] + "/values"
        WAZIUP_data = '{"value":'
        isnumber = re.match(num_format, data[i + 2])
        if isnumber:
            WAZIUP_data = WAZIUP_data + data[i + 2] + ',"timestamp":"' + tdata + '"}'
        else:
            WAZIUP_data = WAZIUP_data + '"' + data[i + 2] + '","timestamp":"' + tdata + '"}'
        print "CloudWAZIUP: will issue requests with"
        print "url: " + WAZIUP_url
        print "data: " + WAZIUP_data
        try:
            response = requests.post(WAZIUP_url, headers=WAZIUP_headers, data=WAZIUP_data, timeout=30)
            print "CloudWAZIUP: returned msg from server is ",
            print response.status_code
            print response.reason
            if 200 <= response.status_code < 300:
                print "CloudWAZIUP: upload success"
                i += 1
            else:
                print "CloudWAZIUP: bad request"
                print response.text
                i += 1
        except requests.exceptions.RequestException as e:
            print e
            print "CloudWAZIUP: requests command failed (maybe a disconnection)"
            connection_failure = True
        if connection_failure:
            return False


# 	waziup#-TEST # 	-TESTS
def main(ldata, pdata, rdata, tdata, gwid):
    arr = map(int, pdata.split(","))
    dst = arr[0]
    ptype = arr[1]
    src = arr[2]
    seq = arr[3]
    datalen = arr[4]
    SNR = arr[5]
    RSSI = arr[6]
    dt = parser.parse(tdata)
    tdata = dt.replace(microsecond=0, tzinfo=None).isoformat() + "Z"
    global gw_id_md5
    gw_id_md5 = md5.new(gwid).hexdigest()
    if dst == 256:
        src_str = "%0.8X" % src
    else:
        src_str = str(src)
    if (src_str in key_WAZIUP.source_list) or (len(key_WAZIUP.source_list) == 0):
        ldata = ldata.replace(" ", "")
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
            print ("CloudWAZIUP: uploading")
            append_gw_str = ""
            if key_WAZIUP.organization_name == "":
                key_WAZIUP.organization_name = "ORG"
            if key_WAZIUP.organization_name == "ORG" or key_WAZIUP.username == "guest":
                append_gw_str = "_" + gw_id_md5
            send_data(data, key_WAZIUP.service_path + "_" + key_WAZIUP.sensor_name + src_str + append_gw_str, nomenclatures, tdata)
        else:
            print ("CloudWAZIUP: not uploading")
            if CloudNoInternet_enabled:
                print ("Using CloudNoInternet")
                from CloudNoInternet import store_internet_pending

                store_internet_pending(ldata, pdata, rdata, tdata, gwid)
        global connection_failure
        connection_failure = not connected
    else:
        print "Source is not is source list, not sending with CloudWAZIUP.py"


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])

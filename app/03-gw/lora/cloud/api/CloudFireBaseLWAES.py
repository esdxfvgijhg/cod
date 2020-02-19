import urllib2
import socket
import time
import datetime
import ssl
import sys
import base64
import key_FireBase

try:
    key_FireBase.source_list
except AttributeError:
    key_FireBase.source_list = []
connection_failure = False


def test_network_available():
    connection = False
    iteration = 0
    response = None
    while not connection and iteration < 4:
        try:
            response = urllib2.urlopen("https://www.firebase.com/", timeout=3)
            connection = True
        except urllib2.URLError, e:
            pass
        except socket.timeout:
            pass
        except ssl.SSLError:
            pass
        if connection_failure and response is None:
            print ("FireBase: the server is still unavailable")
            iteration = 4
        elif response is None:
            print ("FireBase: server unavailable, retrying to connect soon...")
            time.sleep(1)
            iteration += 1
    return connection


def send_data(msg, path, msg_entry):
    from firebase import firebase

    global _db_firebase
    _db_firebase = firebase.FirebaseApplication(key_FireBase.firebase_database, None)
    try:
        result = _db_firebase.put(path, msg_entry, msg)
    except Exception as e:
        print ("FireBase: can not send the data to the server:" + str(e))
        print ("FireBase: not uploading")
        return "exception"


def firebase_uploadSingleData(msg, sensor, msg_entry, date):
    global connection_failure
    connected = test_network_available()
    if connected:
        print ("FireBase: uploading")
        send_to = date.date().isoformat() + "/" + sensor
        str_result = send_data(msg, send_to, msg_entry)
        if str_result == "exception":
            connection_failure = True
        else:
            connection_failure = False
            print "Firebase: upload success"
    else:
        print ("FireBase: not uploading")
        connection_failure = True


def main(ldata_b64, pdata, rdata, tdata, gwid):
    now = datetime.datetime.utcnow()
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
    if (src_str in key_FireBase.source_list) or (len(key_FireBase.source_list) == 0):
        ldata = base64.b64decode(ldata_b64)
        dst = 1
        ptype = ord(ldata[0])
        if ptype == 0x40:
            ptypestr = "unconfirmed data up"
        elif ptype == 0x80:
            ptypestr = "confirmed data up"
        else:
            ptypestr = "not supported"
        ptype = str(hex(ptype))
        devaddr = "0x"
        for i in range(1, 5):
            devaddr += ldata[5 - i].encode("hex")
        FCnt = "0x"
        for i in range(1, 3):
            FCnt += ldata[8 - i].encode("hex")
        MIC = "0x"
        for i in range(len(ldata) - 4, len(ldata)):
            MIC += ldata[i].encode("hex")
        data_b64 = ldata[9 : len(ldata) - 4]
        data_b64 = base64.b64encode(data_b64)
        firebase_msg = {"pdata": pdata.replace("\n", ""), "rdata": rdata.replace("\n", ""), "time": now.isoformat(), "ptype": ptype, "ptypestr": ptypestr, "gateway_eui": gwid, "devAddr": devaddr, "FCnt": FCnt, "FPort": "0x" + ldata[8].encode("hex"), "MIC": MIC, "len": datalen, "snr": SNR, "rssi": RSSI, "cr": cr, "datarate": "SF" + str(sf) + "BW" + str(bw), "frame_b64": ldata_b64, "data_b64": data_b64}
        sensor_entry = "sensor" + devaddr
        msg_entry = "msg" + FCnt
        firebase_uploadSingleData(firebase_msg, sensor_entry, msg_entry, now)
    else:
        print "Source is not is source list, not sending with CloudFireBaseLWAES.py"


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])

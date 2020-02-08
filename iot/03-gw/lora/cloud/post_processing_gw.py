dateutil_tz = True
import sys
import subprocess
import select
import threading
from threading import Timer
import time
from collections import deque
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
import re
import string
import base64
import requests
import libSMS

LL_PREFIX_1 = "\xFF"
LL_PREFIX_LORA = "\xFE"
LORA_RADIO = 1
radio_type = LORA_RADIO
HEADER_SIZE = 4
APPKEY_SIZE = 4
PKT_TYPE_DATA = 0x10
PKT_TYPE_ACK = 0x20
PKT_FLAG_ACK_REQ = 0x08
PKT_FLAG_DATA_ENCRYPTED = 0x04
PKT_FLAG_DATA_WAPPKEY = 0x02
PKT_FLAG_DATA_DOWNLINK = 0x01
LORAWAN_HEADER_SIZE = 13
pdata = "0,0,0,0,0,0,0,0"
rdata = "0,0,0,0"
tdata = "N/A"
short_info_1 = "N/A"
short_info_2 = "N/A"
short_info_3 = "N/A"
rxnb = 0
rxok = 0
rxfw = 0
ackr = 0
dwnb = 0
txnb = 0
dst = 0
ptype = 0
ptypestr = "N/A"
src = 0
seq = 0
datalen = 0
SNR = 0
RSSI = 0
bw = 0
cr = 0
sf = 0
_hasRadioData = False
replchars = re.compile(r"[\x00-\x1f]")


def replchars_to_hex(match):
    return r"\x{0:02x}".format(ord(match.group()))


_ignoreComment = 1
the_app_key = "\x00\x00\x00\x00"
_validappkey = 1
_hasClearData = 0
f = open(os.path.expanduser("gateway_conf.json"), "r")
lines = f.readlines()
f.close()
array = ""
for line in lines:
    array += line
json_array = json.loads(array)
_gwid = json_array["gateway_conf"]["gateway_ID"]
try:
    _rawFormat = json_array["gateway_conf"]["raw"]
except KeyError:
    _rawFormat = 0
if _rawFormat:
    print "raw output from low-level gateway. post_processing_gw will handle packet format"
try:
    _local_aes = json_array["gateway_conf"]["aes"]
except KeyError:
    _local_aes = 0
if _local_aes:
    print "enable local AES decryption"
try:
    _local_lsc = json_array["gateway_conf"]["lsc"]
except KeyError:
    _local_lsc = 0
if _local_lsc:
    print "enable local LSC decryption"
_local_decrypt = _local_aes | _local_lsc
try:
    _wappkey = json_array["gateway_conf"]["wappkey"]
except KeyError:
    _wappkey = 0
if _wappkey:
    print "will enforce app key"
    print "importing list of app key"
    try:
        import key_AppKey
    except ImportError:
        print "no key_AppKey.py file"
        _wappkey = 0
try:
    _gw_downlink = json_array["gateway_conf"]["downlink"]
except KeyError:
    _gw_downlink = 0
if _gw_downlink < 0:
    _gw_downlink = 0
_post_downlink_file = "downlink/downlink-post.txt"
_post_downlink_queued_file = "downlink/downlink-post-queued.txt"
_gw_downlink_file = "downlink/downlink.txt"
pending_downlink_requests = []
_verbose_downlink = False
if _gw_downlink > 3600:
    _verbose_downlink = True


def check_downlink():
    if _verbose_downlink:
        print datetime.datetime.now()
        print "post downlink: checking for " + _post_downlink_file
    if os.path.isfile(os.path.expanduser(_post_downlink_file)):
        lines = []
        print "post downlink: reading " + _post_downlink_file
        f = open(os.path.expanduser(_post_downlink_file), "r")
        lines = f.readlines()
        f.close()
        for line in lines:
            line = line.replace("\r", "")
            if len(line) > 1 or line != "\n":
                line_json = json.loads(line)
                print line_json
                if line_json["status"] == "send_request":
                    pending_downlink_requests.append(line)
        print "post downlink: writing to " + _post_downlink_queued_file
        f = open(os.path.expanduser(_post_downlink_queued_file), "w")
        for downlink_request in pending_downlink_requests:
            f.write("%s" % downlink_request)
        os.remove(os.path.expanduser(_post_downlink_file))
    else:
        if _verbose_downlink:
            print "post downlink: no downlink requests"
    if _verbose_downlink:
        print "post downlink: list of pending downlink requests"
        if len(pending_downlink_requests) == 0:
            print "None"
        else:
            for downlink_request in pending_downlink_requests:
                print downlink_request.replace("\n", "")


def downlink_target():
    while True:
        check_downlink()
        sys.stdout.flush()
        global _gw_downlink
        time.sleep(_gw_downlink)


try:
    _gw_status = json_array["gateway_conf"]["status"]
except KeyError:
    _gw_status = 0
if _gw_status < 0:
    _gw_status = 0


def status_target():
    while True:
        print datetime.datetime.now()
        print "post status: gw ON"
        if _gw_downlink:
            print "post status: will check for downlink requests every %d seconds" % _gw_downlink
        print "post status: executing periodic tasks"
        sys.stdout.flush()
        stats_str = ""
        stats_str += str(rxnb) + ","
        stats_str += str(rxok) + ","
        stats_str += str(rxfw) + ","
        stats_str += str(ackr) + ","
        stats_str += str(dwnb) + ","
        stats_str += str(txnb)
        try:
            cmd_arg = "python post_status_processing_gw.py" + ' "' + stats_str + '"' + " 2> /dev/null"
            os.system(cmd_arg)
        except:
            print "Error when executing post_status_processing_gw.py"
        global _gw_status
        time.sleep(_gw_status)


try:
    _fast_stats = json_array["status_conf"]["fast_stats"]
except KeyError:
    _fast_stats = 0
if _fast_stats < 0:
    _fast_stats = 0


def statistics_target():
    while True:
        try:
            cmd_arg = "python sensors_in_raspi/stats.py" + ' "' + short_info_1 + '"' + ' "' + short_info_2 + '"' + ' "' + short_info_3 + '"' + " 2> /dev/null"
            os.system(cmd_arg)
        except:
            print "Error when executing sensors_in_raspi/stats.py"
        global _fast_stats
        time.sleep(_fast_stats)


def checkNet():
    print "post_processing_gw.py checks Internet connecitivity with www.google.com"
    try:
        response = requests.get("http://www.google.com")
        print "response code: " + str(response.status_code)
        return True
    except requests.ConnectionError:
        print "No Internet"
        return False


try:
    alert_conf = json_array["alert_conf"]
    _has_alert_conf = True
    print "post_processing_gw.py found an alert_conf section"
except KeyError:
    _has_alert_conf = False
_use_mail_alert = False
if _has_alert_conf:
    _use_mail_alert = json_array["alert_conf"]["use_mail"]
if _use_mail_alert:
    import smtplib
    from email.mime.multipart import MIMEMultipart
    from email.mime.text import MIMEText

    print "Alert by mail is ON. Contact mail is " + json_array["alert_conf"]["contact_mail"]


def send_alert_mail(m):
    fromaddr = json_array["alert_conf"]["mail_from"]
    toaddr = json_array["alert_conf"]["contact_mail"]
    alladdr = toaddr.split(",")
    msg = MIMEMultipart()
    msg["From"] = fromaddr
    msg["To"] = toaddr
    msg["Subject"] = m
    body = m
    msg.attach(MIMEText(body, "plain"))
    server = smtplib.SMTP(json_array["alert_conf"]["mail_server"], 587)
    server.starttls()
    server.login(fromaddr, json_array["alert_conf"]["mail_passwd"])
    text = msg.as_string()
    server.sendmail(fromaddr, alladdr, text)
    server.quit()


if _use_mail_alert:
    print "post_processing_gw.py sends mail indicating that gateway has started post-processing stage..."
    if checkNet():
        try:
            send_alert_mail("Gateway " + _gwid + " has started post-processing stage")
            print "Sending mail done"
        except:
            print "Unexpected error when sending mail"
    sys.stdout.flush()
_use_sms_alert = False
if _has_alert_conf:
    _use_sms_alert = json_array["alert_conf"]["use_sms"]
global PIN, contact_sms, gammurc_file, sm
if _use_sms_alert:
    if not libSMS.gammuCheck():
        print "overriding use_sms to false"
        _use_sms_alert = False
if _use_sms_alert:
    PIN = json_array["alert_conf"]["pin"]
    contact_sms = json_array["alert_conf"]["contact_sms"]
    gammurc_file = json_array["alert_conf"]["gammurc_file"]
    if libSMS.gammurcCheck(gammurc_file):
        print "Alert by SMS is ON. Contact SMS is ",
        print contact_sms
        print "Initializing gammu for SMS"
    else:
        print "overriding use_sms to false"
        _use_sms_alert = False
if _use_sms_alert:
    if libSMS.phoneConnection(gammurc_file, PIN) == None:
        print "overriding use_sms to false"
        print "Sending SMS failed"
        _use_sms_alert = False
    else:
        sm = libSMS.phoneConnection(gammurc_file, PIN)
if _use_sms_alert:
    print "post_processing_gw.py sends SMS indicating that gateway has started post-processing stage..."
    success = libSMS.send_sms(sm, "Gateway " + _gwid + " has started post-processing stage", contact_sms)
    if success:
        print "Sending SMS done"
    sys.stdout.flush()
nodeL = deque([])
fileH = {}
imageFilenameA = {}
imgsnA = {}
qualityA = {}
camidA = {}
imgSN = 0


def image_timeout():
    node_id = nodeL.popleft()
    print "close image file for node %d" % node_id
    f = fileH[node_id]
    f.close()
    del fileH[node_id]
    print "decoding image " + os.path.expanduser(imageFilenameA[node_id])
    sys.stdout.flush()
    cmd = "/home/pi/lora_gateway/ucam-images/decode_to_bmp -received " + os.path.expanduser(imageFilenameA[node_id]) + " -SN " + str(imgsnA[node_id]) + " -src " + str(node_id) + " -camid " + str(camidA[node_id]) + " -Q " + str(qualityA[node_id]) + " -vflip" + " /home/pi/lora_gateway/ucam-images/128x128-test.bmp"
    print "decoding with command"
    print cmd
    args = cmd.split()
    out = "error"
    try:
        out = subprocess.check_output(args, stderr=None, shell=False)
        if out == "error":
            print "decoding error"
        else:
            time.sleep(3)
            out = out.replace("\r", "")
            out = out.replace("\n", "")
            print "producing file " + out
            print "creating if needed the uploads/node_" + str(node_id) + " folder"
            try:
                os.mkdir(os.path.expanduser(_web_folder_path + "images/uploads/node_" + str(node_id)))
            except OSError:
                print "folder already exist"
            print "moving decoded image file into " + os.path.expanduser(_web_folder_path + "images/uploads/node_" + str(node_id))
            os.rename(os.path.expanduser("./" + out), os.path.expanduser(_web_folder_path + "images/uploads/node_" + str(node_id) + "/" + out))
            print "done"
    except subprocess.CalledProcessError:
        print "launching image decoding failed!"
    sys.stdout.flush()


_linebuf = "the line buffer"
_linebuf_idx = 0
_has_linebuf = 0


def getSingleChar():
    global _has_linebuf
    if _has_linebuf == 1:
        global _linebuf_idx
        global _linebuf
        if _linebuf_idx < len(_linebuf):
            _linebuf_idx = _linebuf_idx + 1
            return _linebuf[_linebuf_idx - 1]
        else:
            _has_linebuf = 0
            return sys.stdin.read(1)
    else:
        return sys.stdin.read(1)


def getAllLine():
    global _linebuf_idx
    p = _linebuf_idx
    _linebuf_idx = 0
    global _has_linebuf
    _has_linebuf = 0
    global _linebuf
    return _linebuf[p:]


def fillLinebuf(n):
    global _linebuf_idx
    _linebuf_idx = 0
    global _has_linebuf
    _has_linebuf = 1
    global _linebuf
    _linebuf = sys.stdin.read(n)


_folder_path = "/home/pi/Dropbox/LoRa-test/"
_web_folder_path = "/var/www/html/"
_telemetrylog_filename = _folder_path + "telemetry_" + str(_gwid) + ".log"
_imagelog_filename = _folder_path + "image_" + str(_gwid) + ".log"
from clouds_parser import retrieve_enabled_clouds

_enabled_clouds = retrieve_enabled_clouds()
print "post_processing_gw.py got cloud list: "
print _enabled_clouds
_cloud_for_encrypted_data = retrieve_enabled_clouds("encrypted_clouds")
print "post_processing_gw.py got encrypted cloud list: "
print _cloud_for_encrypted_data
_cloud_for_lorawan_encrypted_data = retrieve_enabled_clouds("lorawan_encrypted_clouds")
print "post_processing_gw.py got LoRaWAN encrypted cloud list: "
print _cloud_for_lorawan_encrypted_data
if _gw_status:
    print "Starting thread to perform periodic gw status/tasks"
    sys.stdout.flush()
    t_status = threading.Thread(target=status_target)
    t_status.daemon = True
    t_status.start()
    time.sleep(1)
if _gw_downlink:
    print datetime.datetime.now()
    print "post downlink: checking for existing " + _post_downlink_queued_file
    if os.path.isfile(os.path.expanduser(_post_downlink_queued_file)):
        lines = []
        print "post downlink: reading existing " + _post_downlink_queued_file
        f = open(os.path.expanduser(_post_downlink_queued_file), "r")
        lines = f.readlines()
        f.close()
        for line in lines:
            if len(line) > 1 or line != "\n":
                line_json = json.loads(line)
                if line_json["status"] == "send_request":
                    pending_downlink_requests.append(line)
        print "post downlink: start with current list of pending downlink requests"
        for downlink_request in pending_downlink_requests:
            print downlink_request.replace("\n", "")
    else:
        print "post downlink: none existing downlink-post-queued.txt"
    print "Loading lib to compute downlink MIC"
    from loraWAN import loraWAN_get_MIC

    print "Starting thread to check for downlink requests every %d seconds" % _gw_downlink
    sys.stdout.flush()
    t_downlink = threading.Thread(target=downlink_target)
    t_downlink.daemon = True
    t_downlink.start()
    time.sleep(1)
if _fast_stats:
    print "Starting thread to perform fast statistics tasks"
    sys.stdout.flush()
    t_status = threading.Thread(target=statistics_target)
    t_status.daemon = True
    t_status.start()
    time.sleep(1)
print ""
print "Current working directory: " + os.getcwd()
while True:
    sys.stdout.flush()
    ch = getSingleChar()
    if ch == "^":
        now = datetime.datetime.now()
        ch = sys.stdin.read(1)
        if ch == "p":
            pdata = sys.stdin.readline()
            print now.isoformat()
            print "rcv ctrl pkt info (^p): " + pdata,
            arr = map(int, pdata.split(","))
            print "splitted in: ",
            print arr
            dst = arr[0]
            ptype = arr[1]
            ptypestr = "N/A"
            if (ptype & 0xF0) == PKT_TYPE_DATA:
                ptypestr = "DATA"
                if (ptype & PKT_FLAG_DATA_DOWNLINK) == PKT_FLAG_DATA_DOWNLINK:
                    ptypestr = ptypestr + " DOWNLINK"
                if (ptype & PKT_FLAG_DATA_WAPPKEY) == PKT_FLAG_DATA_WAPPKEY:
                    ptypestr = ptypestr + " WAPPKEY"
                if (ptype & PKT_FLAG_DATA_ENCRYPTED) == PKT_FLAG_DATA_ENCRYPTED:
                    ptypestr = ptypestr + " ENCRYPTED"
                if (ptype & PKT_FLAG_ACK_REQ) == PKT_FLAG_ACK_REQ:
                    ptypestr = ptypestr + " ACK_REQ"
            if (ptype & 0xF0) == PKT_TYPE_ACK:
                ptypestr = "ACK"
            src = arr[2]
            seq = arr[3]
            datalen = arr[4]
            SNR = arr[5]
            RSSI = arr[6]
            if _rawFormat == 0:
                info_str = "(dst=%d type=0x%.2X(%s) src=%d seq=%d len=%d SNR=%d RSSI=%d)" % (dst, ptype, ptypestr, src, seq, datalen, SNR, RSSI)
            else:
                info_str = "rawFormat(len=%d SNR=%d RSSI=%d)" % (datalen, SNR, RSSI)
            print info_str
            rxnb = rxnb + 1
            rxok = rxnb
            short_info_1 = "src=%d seq=%d #pk=%d" % (src, seq, rxnb)
            short_info_2 = "SNR=%d RSSI=%d" % (SNR, RSSI)
            for downlink_request in pending_downlink_requests:
                request_json = json.loads(downlink_request)
                if (request_json["dst"] == 0) or (src == request_json["dst"]):
                    print "post downlink: receive from %d with pending request" % src
                    if request_json["dst"] == 0:
                        print "in broadcast mode"
                    else:
                        print "in unicast mode"
                    print 'post downlink: downlink data is "%s"' % request_json["data"]
                    print "post downlink: generate " + _gw_downlink_file + " from entry"
                    print downlink_request.replace("\n", "")
                    MIC = loraWAN_get_MIC(src, request_json["data"])
                    request_json["MIC0"] = hex(MIC[0])
                    request_json["MIC1"] = hex(MIC[1])
                    request_json["MIC2"] = hex(MIC[2])
                    request_json["MIC3"] = hex(MIC[3])
                    downlink_json = []
                    downlink_json.append(request_json)
                    f = open(os.path.expanduser(_gw_downlink_file), "a")
                    print "post downlink: write"
                    for downlink_json_line in downlink_json:
                        print json.dumps(downlink_json_line)
                        f.write(json.dumps(downlink_json_line) + "\n")
                    f.close()
                    pending_downlink_requests.remove(downlink_request)
                    f = open(os.path.expanduser(_post_downlink_queued_file), "w")
                    for downlink_request in pending_downlink_requests:
                        f.write("%s" % downlink_request)
                    break
        if ch == "r":
            rdata = sys.stdin.readline()
            print "rcv ctrl radio info (^r): " + rdata,
            arr = map(int, rdata.split(","))
            print "splitted in: ",
            print arr
            bw = arr[0]
            cr = arr[1]
            sf = arr[2]
            info_str = "(BW=%d CR=%d SF=%d)" % (bw, cr, sf)
            print info_str
        if ch == "t":
            tdata = sys.stdin.readline()
            print "rcv timestamp (^t): " + tdata
            tdata = tdata.replace("\n", "")
            short_info_3 = tdata.split("+")[0]
            if dateutil_tz == True:
                print "adding time zone info"
                localdt = datetime.datetime.now(dateutil.tz.tzlocal())
                i = localdt.isoformat().find("+")
                tdata = tdata + localdt.isoformat()[i:]
                print "new rcv timestamp (^t): %s" % tdata
            else:
                tdata = tdata + "+00:00"
        if ch == "l":
            print "not implemented yet"
        if ch == "$":
            data = sys.stdin.readline()
            print data,
            if "Resetting" in data:
                if _use_mail_alert:
                    print "post_processing_gw.py sends mail indicating that gateway has reset radio module..."
                    if checkNet():
                        send_alert_mail("Gateway " + _gwid + " has reset its radio module")
                        print "Sending mail done"
                if _use_sms_alert:
                    print "post_processing_gw.py sends SMS indicating that gateway has reset radio module..."
                    success = libSMS.send_sms(sm, "Gateway " + _gwid + " has reset its radio module", contact_sms)
                    if success:
                        print "Sending SMS done"
        continue
    if ch == "\\" and _hasRadioData == True:
        _hasRadioData = False
        now = datetime.datetime.now()
        if _validappkey == 1:
            print "valid app key: accept data"
            ch = getSingleChar()
            if ch == "$":  # log in a file
                data = getAllLine()
                print "rcv msg to log (\$) in log file: " + data,
                f = open(os.path.expanduser(_telemetrylog_filename), "a")
                f.write(info_str + " ")
                f.write(now.isoformat() + "> ")
                f.write(data)
                f.close()
            elif ch == "!":
                ldata = getAllLine()
                print "number of enabled clouds is %d" % len(_enabled_clouds)
                for cloud_index in range(0, len(_enabled_clouds)):
                    try:
                        print "--> cloud[%d]" % cloud_index
                        cloud_script = _enabled_clouds[cloud_index]
                        print "uploading with " + cloud_script
                        sys.stdout.flush()
                        cmd_arg = cloud_script + ' "' + ldata.replace("\n", "").replace("\0", "") + '"' + ' "' + pdata.replace("\n", "") + '"' + ' "' + rdata.replace("\n", "") + '"' + ' "' + tdata.replace("\n", "") + '"' + ' "' + _gwid.replace("\n", "") + '"'
                    except UnicodeDecodeError, ude:
                        print ude
                    else:
                        print cmd_arg
                        sys.stdout.flush()
                        try:
                            os.system(cmd_arg)
                        except:
                            print "Error when uploading data to the cloud"
                print "--> cloud end"
            else:
                print "unrecognized data logging prefix: discard data"
                getAllLine()
        else:
            print "invalid app key: discard data"
            getAllLine()
        continue
    if ch == LL_PREFIX_1:
        print "got first framing byte"
        ch = getSingleChar()
        if ch == LL_PREFIX_LORA:
            print "--> got LoRa data prefix"
            radio_type = LORA_RADIO
            _hasRadioData = True
            if _wappkey == 1:
                _validappkey = 0
            else:
                _validappkey = 1
            if _rawFormat == 1:
                print "raw format from LoRa gateway"
                ch = getSingleChar()
                if ord(ch) == 1:
                    dst = ord(ch)
                    ptype = ord(getSingleChar())
                    src = ord(getSingleChar())
                    seq = ord(getSingleChar())
                    print "Header[dst=%d ptype=0x%.2X src=%d seq=%d]" % (dst, ptype, src, seq)
                    fillLinebuf(datalen - HEADER_SIZE)
                    datalen = datalen - HEADER_SIZE
                    pdata = "%d,%d,%d,%d,%d,%d,%d" % (dst, ptype, src, seq, datalen, SNR, RSSI)
                    print "update ctrl pkt info (^p): " + pdata
                if ord(ch) & 0x40 == 0x40 or ord(ch) & 0x80 == 0x80:
                    print "LoRaWAN?"
                    fillLinebuf(datalen - 1)
                    lorapktstr = ch + getAllLine()
                    lorapkt = []
                    for i in range(0, len(lorapktstr)):
                        lorapkt.append(ord(lorapktstr[i]))
                    print [hex(x) for x in lorapkt]
                    datalen = datalen - LORAWAN_HEADER_SIZE
                    src = lorapkt[4] * 256 * 256 * 256
                    src += lorapkt[3] * 256 * 256
                    src += lorapkt[2] * 256
                    src += lorapkt[1]
                    seq = lorapkt[7] * 256 + lorapkt[6]
                    pdata = "%d,%d,%s,%d,%d,%d,%d" % (256, ord(ch), "0x%0.8X" % src, seq, datalen, SNR, RSSI)
                    print "update ctrl pkt info (^p): " + pdata
                    pdata = "%d,%d,%d,%d,%d,%d,%d" % (256, ord(ch), src, seq, datalen, SNR, RSSI)
                    if _local_aes == 1:
                        from loraWAN import loraWAN_process_pkt

                        try:
                            plain_payload = loraWAN_process_pkt(lorapkt)
                        except:
                            print "### unexpected decryption error ###"
                            plain_payload = "###BADMIC###"
                        if plain_payload == "###BADMIC###":
                            print plain_payload
                        else:
                            print "plain payload is : ",
                            print (replchars.sub(replchars_to_hex, plain_payload))
                            _linebuf = plain_payload
                            _has_linebuf = 1
                            _hasClearData = 1
                    else:
                        print "--> DATA encrypted: local AES not activated"
                        lorapktstr_b64 = base64.b64encode(lorapktstr)
                        print "--> FYI base64 of LoRaWAN frame w/MIC: " + lorapktstr_b64
                        print "--> number of enabled clouds is %d" % len(_cloud_for_lorawan_encrypted_data)
                        if len(_cloud_for_lorawan_encrypted_data) == 0:
                            print "--> discard encrypted data"
                        else:
                            for cloud_index in range(0, len(_cloud_for_lorawan_encrypted_data)):
                                try:
                                    print "--> LoRaWAN encrypted cloud[%d]" % cloud_index
                                    cloud_script = _cloud_for_lorawan_encrypted_data[cloud_index]
                                    print "uploading with " + cloud_script
                                    sys.stdout.flush()
                                    cmd_arg = cloud_script + ' "' + lorapktstr_b64.replace("\n", "") + '"' + ' "' + pdata.replace("\n", "") + '"' + ' "' + rdata.replace("\n", "") + '"' + ' "' + tdata.replace("\n", "") + '"' + ' "' + _gwid.replace("\n", "") + '"'
                                except UnicodeDecodeError, ude:
                                    print ude
                                else:
                                    print cmd_arg
                                    sys.stdout.flush()
                                    try:
                                        os.system(cmd_arg)
                                    except:
                                        print "Error when uploading data to LoRaWAN encrypted cloud"
                            print "--> LoRaWAN encrypted cloud end"
                    continue
            else:
                fillLinebuf(datalen)
            if (ptype & PKT_FLAG_DATA_ENCRYPTED) == PKT_FLAG_DATA_ENCRYPTED:
                print "--> DATA encrypted: encrypted payload size is %d" % datalen
                _hasClearData = 0
                lorapktstr = getAllLine()
                if _local_decrypt == 1:
                    if _local_aes == 1 and _hasClearData == 0:
                        print "--> decrypting in AES-CTR mode (LoRaWAN version)"
                        lorapkt = []
                        for i in range(0, len(lorapktstr)):
                            lorapkt.append(ord(lorapktstr[i]))
                        from loraWAN import loraWAN_process_pkt

                        try:
                            plain_payload = loraWAN_process_pkt(lorapkt)
                        except:
                            print "### unexpected decryption error ###"
                            plain_payload = "###BADMIC###"
                        if plain_payload == "###BADMIC###":
                            print plain_payload
                        else:
                            _hasClearData = 1
                    if _local_lsc == 1 and _hasClearData == 0:
                        print "--> decrypting in LSC mode"
                        lorapkt = []
                        for i in range(0, len(lorapktstr)):
                            lorapkt.append(ord(lorapktstr[i]))
                        from LSC_decrypt import LSC_process_pkt

                        try:
                            plain_payload = LSC_process_pkt(lorapkt, dst, ptype, src, seq)
                        except:
                            print "### unexpected decryption error ###"
                            plain_payload = "###BADMIC###"
                        if plain_payload == "###BADMIC###":
                            print plain_payload
                        else:
                            _hasClearData = 1
                    if plain_payload == "###BADMIC###":
                        print "--> Can not decrypt data"
                    else:
                        print "--> plain payload is : ",
                        print (replchars.sub(replchars_to_hex, plain_payload))
                        _linebuf = plain_payload
                        _has_linebuf = 1
                        datalen = len(plain_payload)
                        ptype = ptype & (~PKT_FLAG_DATA_ENCRYPTED)
                        pdata = "%d,%d,%d,%d,%d,%d,%d" % (dst, ptype, src, seq, len(plain_payload), SNR, RSSI)
                        print "--> changed packet type to clear data"
                else:
                    print "--> DATA encrypted: local decryption not activated"
                    lorapktstr_b64 = base64.b64encode(lorapktstr)
                    print "--> FYI base64 of encrypted frame w/MIC: " + lorapktstr_b64
                    print "--> number of enabled clouds is %d" % len(_cloud_for_encrypted_data)
                    if len(_cloud_for_encrypted_data) == 0:
                        print "--> discard encrypted data"
                    else:
                        pdata = "%d,%d,%d,%d,%d,%d,%d" % (dst, ptype, src, seq, datalen, SNR, RSSI)
                        for cloud_index in range(0, len(_cloud_for_encrypted_data)):
                            try:
                                print "--> encrypted cloud[%d]" % cloud_index
                                cloud_script = _cloud_for_encrypted_data[cloud_index]
                                print "uploading with " + cloud_script
                                sys.stdout.flush()
                                cmd_arg = cloud_script + ' "' + lorapktstr_b64.replace("\n", "") + '"' + ' "' + pdata.replace("\n", "") + '"' + ' "' + rdata.replace("\n", "") + '"' + ' "' + tdata.replace("\n", "") + '"' + ' "' + _gwid.replace("\n", "") + '"'
                            except UnicodeDecodeError, ude:
                                print ude
                            else:
                                print cmd_arg
                                sys.stdout.flush()
                                try:
                                    os.system(cmd_arg)
                                except:
                                    print "Error when uploading data to encrypted cloud"
                        print "--> encrypted cloud end"
            else:
                _hasClearData = 1
            if (ptype & PKT_FLAG_DATA_WAPPKEY) == PKT_FLAG_DATA_WAPPKEY and _hasClearData == 1:
                print "--> DATA with_appkey: read app key sequence"
                the_app_key = getSingleChar()
                the_app_key = the_app_key + getSingleChar()
                the_app_key = the_app_key + getSingleChar()
                the_app_key = the_app_key + getSingleChar()
                print "app key is ",
                print " ".join("0x{:02x}".format(ord(c)) for c in the_app_key)
                pdata = "%d,%d,%d,%d,%d,%d,%d" % (dst, ptype, src, seq, datalen - APPKEY_SIZE, SNR, RSSI)
                if _wappkey == 1:
                    if the_app_key in key_AppKey.app_key_list:
                        print "in app key list"
                        _validappkey = 1
                    else:
                        print "not in app key list"
                        _validappkey = 0
                else:
                    print "app key disabled"
                    _validappkey = 1
            continue
        if ch >= "\x50" and ch <= "\x54":
            print "--> got image packet"
            cam_id = ord(ch) - 0x50
            src_addr_msb = ord(getSingleChar())
            src_addr_lsb = ord(getSingleChar())
            src_addr = src_addr_msb * 256 + src_addr_lsb
            seq_num = ord(getSingleChar())
            Q = ord(getSingleChar())
            data_len = ord(getSingleChar())
            if src_addr in nodeL:
                theFile = fileH[src_addr]
            else:
                nodeL.append(src_addr)
                filename = _folder_path + "images/ucam_%d-node_%.4d-cam_%d-Q%d.dat" % (imgSN, src_addr, cam_id, Q)
                print "first pkt from node %d" % src_addr
                print "creating file %s" % filename
                theFile = open(os.path.expanduser(filename), "w")
                fileH.update({src_addr: theFile})
                imageFilenameA.update({src_addr: filename})
                imgsnA.update({src_addr: imgSN})
                qualityA.update({src_addr: Q})
                camidA.update({src_addr: cam_id})
                imgSN = imgSN + 1
                t = Timer(90, image_timeout)
                t.start()
                f = open(os.path.expanduser(_imagelog_filename), "a")
                f.write(info_str + " ")
                now = datetime.datetime.now()
                f.write(now.isoformat() + "> ")
                f.write(filename + "\n")
                f.close()
            print "pkt %d from node %d data size is %d" % (seq_num, src_addr, data_len)
            print "write to file"
            theFile.write(format(data_len, "04X") + " ")
            for i in range(1, data_len):
                ch = getSingleChar()
                print (hex(ord(ch))),
                theFile.write(format(ord(ch), "02X") + " ")
            print "End"
            sys.stdout.flush()
            theFile.flush()
            continue
    if ch == "?" and _ignoreComment == 1:
        sys.stdin.readline()
        continue
    sys.stdout.write(ch)

PORT = 60002

#### DATABASE
DBHOST="mysql"
DBNAME="sensors"
DBUSER="root"
DBPASS="sensors/root"

import traceback
import socket
import time
import struct
import SocketServer
import MySQLdb
import MySQLdb.cursors
from common import *

def dbConnect():
    dbconn = MySQLdb.connect( \
            host = DBHOST, db = DBNAME, \
            user = DBUSER, passwd = DBPASS, \
            cursorclass = MySQLdb.cursors.DictCursor, \
            autocommit = True)
    return dbconn

def processDataPkt(pkt):
    print "Processing Data Packet"
    print ""
    print "#"*40

    # Parsing headers
    data = {}
    data["sensor_id"], sidLen = decodeVarSize(pkt)
    print "Sensor ID:", data["sensor_id"]
    start = sidLen
    end = start+8
    data["timestamp"] = struct.unpack("<Q",pkt[start:end])[0]
    print "Sample timestamp:", data["timestamp"] \
            , time.ctime(data["timestamp"])

    start = end
    end = start+2
    pktLen = struct.unpack("<H",pkt[start:end])[0]
    print "Packet length:", pktLen
    if pktLen != len(pkt):
        print "Error: Invalid packet length"
        return False

    # Collect all TLVs
    tlv = {}
    start = end
    while (start < len(pkt)-1):
        typeId,valLen,tlvLen = checkTLV(pkt[start:])
        tlv[typeId] = pkt[start : start+tlvLen] 
        start += tlvLen

    if len(tlv) > 0:
        # Connect to database
        dbConn = dbConnect()
        try:
            # Query expected typeId from database
            datatype = {}
            sql = "SELECT * FROM `field-data` WHERE `id` IN (%s)" \
                    %(",".join(map(str,tlv.keys())))
            print ">", sql
            dbCursor = dbConn.cursor()
            count = dbCursor.execute(sql)
            for row in dbCursor:
                datatype[row["id"]] = row
            dbCursor.close()

            # Convert TLV to data
            for t in tlv:
                if t not in datatype:
                    print "Warn: Undefined datatype", t
                    continue
                field = datatype[t]["field"]
                dtype = datatype[t]["datatype"]
                mult = datatype[t]["multiplier"]
                bias = datatype[t]["bias"]
                tid, value = parseTLV(tlv[t], dtype)
                data[field] = value * mult + bias
                print "%s:"%(field), value
            
            # Put the data into the database
            fields = []
            values = []
            upds = []
            for key in data:
                f = "`%s`"%(key)
                v = "'%s'"%(str(data[key]))
                fields.append(f)
                values.append(v)
                if key=="timestamp" or key=="sensor_id":
                    continue
                upds.append("%s=COALESCE(%s,%s)"%(f,f,v))
            fieldStr = ",".join(fields)
            valueStr = ",".join(values)
            updStr = ",".join(upds)
            #sql = "INSERT IGNORE INTO `data` (%s) VALUES (%s)"%(fieldStr,valueStr)
            sql = "INSERT INTO `data` (`server_timestamp`,%s)"%(fieldStr)
            sql += " VALUES ('%d',%s)"%(time.time(),valueStr)
            sql += " ON DUPLICATE KEY UPDATE"
            sql += " `server_timestamp`='%d',%s"%(time.time(),updStr)
            print ">", sql
            dbCursor = dbConn.cursor()
            count = dbCursor.execute(sql)
            dbCursor.close()
        finally:
            dbConn.close()

        if count == 0:
            print "Warn: Duplicated packet"
            return True
    else:
        print "No data, this is a time sync request."

    print "#"*40
    print ""
    return True

def createConfPkt(rpkt):
    print "Creating Configuration Packet"
    print ""
    print "#"*40

    sid, sidLen = decodeVarSize(rpkt)
    print "To Sensor:", sid

    conf = {}
    datatype = {}
    # Conncet to database
    dbConn = dbConnect()
    try:
        # Query sensor configuration from database
        sql = "SELECT * FROM `sensor` WHERE `id`='%d'"%(sid)
        print ">", sql
        dbCursor = dbConn.cursor()
        count = dbCursor.execute(sql)
        colNames = [ desc[0] for desc in dbCursor.description ]
        row = dbCursor.fetchone()
        if row is not None:
            conf = row
        dbCursor.close()

        # Query id and datatype of the configuration
        fields = []
        for key in conf:
            fields.append("'%s'"%(key))
        if len(conf)>0:
            sql = "SELECT * FROM `field-conf` WHERE `field` IN (%s)" \
                    %(",".join(fields))
            print ">", sql
            dbCursor = dbConn.cursor()
            count = dbCursor.execute(sql)
            for row in dbCursor:
                datatype[row["field"]] = row
            dbCursor.close()
    finally:
        dbConn.close()

    # Building packet
    pktHead = "\0" # server is 0x00
    pktHead += encodeVarSize(sid) # To sensor ID
    pktHead += struct.pack("<Q",int(time.time())) # Timestamp

    # Convert configuration to TLV
    pktData = ""
    for field in datatype:
        value = conf[field]
        if value is None:
            continue
        typeId = datatype[field]["id"]
        dtype = datatype[field]["datatype"]
        pktData += createTLV(typeId, value, dtype)
        print "%s:"%(field), value

    pktHead += struct.pack("<H",len(pktHead)+2+len(pktData)+1) # Pkt length

    pkt = pktHead + pktData
    pkt += getCRC(pkt)
    print "#"*40
    print ""
    return pkt

class PktHandler(SocketServer.BaseRequestHandler):
    def handle(self):
        addr = self.client_address
        rpkt = self.request[0]
        sock = self.request[1]
        try:
            print time.time(), "Received", len(rpkt), "bytes from", addr
            printHex(rpkt)
            if not checkCRC(rpkt):
                print time.time(), "Wrong CRC"
                return
            if not processDataPkt(rpkt):
                print time.time(), "Invalid packet"
                return
            spkt = createConfPkt(rpkt)
            if spkt is not None:
                print time.time(), "Sending", len(spkt), "bytes to", addr
                printHex(spkt)
                sock.sendto(spkt, addr)
        except Exception:
            print time.time(), "Got an error:"
            traceback.print_exc()

if __name__=="__main__":
    server = SocketServer.UDPServer(("", PORT), PktHandler)
    print time.time(), "Server - start"
    server.serve_forever()

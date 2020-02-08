PORT = 60001

DBHOST="mysql"
DBNAME="sensors"
DBUSER="root"
DBPASS="sensors/root"

#### Packet structure
#  uint16_t sensor;
#  time_t   t;      // 32bits
#  int16_t  temp;
#  uint16_t humi;
#  uint16_t vbat_raw;
#  uint16_t vbat_k;
#  int16_t  bmptemp;
#  uint16_t bmppressure;
#  uint16_t pm25;
#  uint16_t pm1;
#  uint16_t pm10;
#  int8_t   ds3231temp;
#  uint8_t  state;
#  uint16_t vML8511;
#  float    glat;
#  float    glng;
#  int16_t  alt;
#  uint16   crc;    // CRC8 only first byte is sent, so treat as a `uint8_t`
fmt = "=HlhHHHhHHHHbBHffhb"
key = ["sensor_id","timestamp","temperature","humidity",".vbat-raw", \
        "batt_v",".bmp-temp","pressure","pm2.5","pm1.0","pm10", \
        ".ds3231-temp",".state",".vML8511","gps_lat","gps_lng","gps_alt", \
        ".crc"]
mod = { "temperature":0.1,
        "humidity":0.1,
        "pressure":0.1,
        "batt_v":0.001 }
saveKey = []
for k in key:
    if k[0]==".":
        continue
    saveKey.append(k)
import time
import struct
import socket
import SocketServer
import datetime
import MySQLdb
import MySQLdb.cursors
from crc8 import crc8
check = crc8()

def sendTime(sock, addr):
    utc_datetime = datetime.datetime.utcnow()
    y = utc_datetime.year
    y0=y/256
    y1=y%256
    m = utc_datetime.month
    d = utc_datetime.day
    hr= utc_datetime.hour
    mn= utc_datetime.minute
    sc= utc_datetime.second
    sdata = struct.pack("BBBBBBBBB",0xFC,y0,y1,m,d,hr,mn,sc,0xFD)
    sock.sendto(sdata, addr)
    print "Send UTC time", utc_datetime.isoformat()
    print " ".join(["%02x"%(ord(c)) for c in sdata])

def sendInterval(sock, addr, interval):
    sdata = struct.pack("BBB",0xFC,interval,0xFD)
    sock.sendto(sdata, addr)
    print "Send sensor interval %d mins"%(interval)
    print " ".join(["%02x"%(ord(c)) for c in sdata])

def processData(sock, data, addr):
    print "Checking data..."
    crc = check.crcMaxim(data)
    if crc!= 0:
        print "Wrong CRC, discarded"
        return False

    print "Parsing sensor data..."
    try:
        d = dict(zip(key,struct.unpack(fmt, data)))
    except struct.error as error:
        print error
        return False

    print "Convert data unit"
    for k in key:
        if k in mod:
            d[k] *= mod[k]
        print k,":",d[k]

    print "Connecting to database..."
    try:
        dbconn = MySQLdb.connect( \
                host = DBHOST, db = DBNAME, \
                user = DBUSER, passwd = DBPASS, \
                cursorclass=MySQLdb.cursors.DictCursor, \
                autocommit = True)
    except MySQLdb.Error as e:
        print e
        return False

    try:
        cursor = dbconn.cursor()
        print "Getting sensor record..."
        sql = "SELECT * FROM `sensor` WHERE `id`='%d' LIMIT 1" \
                %(d["sensor_id"])
        print sql
        count = cursor.execute(sql)
        if count == 0:
            print "Sensor not registered"
            dbconn.close()
            return False
        sensorRecord = cursor.fetchone()
        cursor.close()

        cursor = dbconn.cursor()
        print "Saving to database..."
        sql = "INSERT IGNORE INTO `data` (`server_timestamp`,"
        sql+= ",".join(["`%s`"%(k) for k in saveKey])
        sql+= ") VALUES ('%d',"%(time.time())
        sql+= ",".join(["'%s'"%(str(d[k])) for k in saveKey])
        sql+= ")"
        print sql
        count = cursor.execute(sql)
        cursor.close()
        print "%d row inserted"%(count)

        interval = int(sensorRecord["interval"])
        sendInterval(sock,addr,interval)
    except MySQLdb.Error as e:
        print e
        dbconn.close()
        return False

    dbconn.close()
    return True

class PktHandler(SocketServer.BaseRequestHandler):
    def handle(self):
        addr = self.client_address
        data = self.request[0]
        sock = self.request[1]
        print datetime.datetime.now().isoformat()
        print "Received %d bytes"%(len(data)), "from", addr
        for i in range(0,len(data),8):
            # print byte number
            print "%04d:\t"%i,
            # print hex values
            print " ".join(["%02x"%(ord(c)) for c in data[i:i+8]]),
            # print corresponding string
            print "\t%s"%(data[i:i+8])

        # Check if it is a time sync request
        if data=="\1\2T":
            print "It's a time sync request."
            sendTime(sock, addr)
        else:
            processData(sock, data, addr)

def main():
    server = SocketServer.UDPServer(("", PORT), PktHandler)
    print "Start server"
    server.serve_forever()

if __name__=="__main__":
    main()

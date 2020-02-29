import struct
from crc8 import crc8

crc = crc8()

def printHex(pkt):
    for i in range(0,len(pkt),8):
        # print byte number
        print "%04d:\t"%i,
        # print hex values
        print " ".join(["%02x"%(ord(c)) for c in pkt[i:i+8]]),
        # print corresponding string
        #print "\t%s"%(pkt[i:i+8]),
        print ""

'''
Datatype format characters on Python struct
  https://docs.python.org/2/library/struct.html#format-characters
'''
def createTLV(typeId, value, datatype):
    t = encodeVarSize(typeId)
    v = struct.pack("<"+datatype, value)
    l = encodeVarSize(len(v))
    return t+l+v

def parseTLV(tlv, datatype):
    typeId, tLen = decodeVarSize(tlv)
    length, lLen = decodeVarSize(tlv[tLen:])
    value = struct.unpack("<"+datatype,\
            tlv[tLen+lLen:tLen+lLen+length])[0]
    return typeId, value

def checkTLV(tlv):
    typeId, tLen = decodeVarSize(tlv)
    valLen, lLen = decodeVarSize(tlv[tLen:])
    tlvLen = tLen+lLen+valLen
    return typeId,valLen,tlvLen

'''
Variable size T,L for TLV
  http://named-data.net/doc/ndn-tlv/tlv.html
'''
def encodeVarSize(value):
    if value < 0:
        # Value must be unsigned
        return None
    if value < 253:
        return struct.pack("<B",value)
    if value < 2**16:
        return struct.pack("<BH",253,value)
    if value < 2**32:
        return struct.pack("<BI",254,value)
    if value < 2**64:
        return struct.pack("<BQ",255,value)
    # Value is too big
    return None

def decodeVarSize(code):
    first = ord(code[0])
    if first < 253:
        return first, 1
    if first == 253:
        return struct.unpack("<H",code[1:3])[0], 3
    if first == 254:
        return struct.unpack("<I",code[1:5])[0], 5
    if first == 255:
        return struct.unpack("<Q",code[1:9])[0], 9
    return None

def checkCRC(pkt):
    return crc.crcMaxim(pkt) == 0

def getCRC(data):
    return chr(crc.crcMaxim(data))


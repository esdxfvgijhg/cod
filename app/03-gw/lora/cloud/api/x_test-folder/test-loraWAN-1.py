from loraWAN import loraWAN_process_pkt

pkt = "\x40\x04\x05\x01\x02\x00\x00\x00\x01\xE4\x85\xFD\x1F\x77\x91\xB9\xD9\x34\xFF\x1F\xF9\xA8\xBC\x3D\x7E"
lorapkt = []
for i in range(0, len(pkt)):
    lorapkt.append(ord(pkt[i]))
plain_payload = loraWAN_process_pkt(lorapkt)
print "plain payload is : " + plain_payload

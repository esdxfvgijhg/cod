import sys
import re
import string
import base64
import os
import os.path

try:
    import LoRaWAN
    from LoRaWAN.MHDR import MHDR
except ImportError:
    print "LoRaWAN python lib must be installed"
import loraWAN_config


def import_LoRaWAN_lib():
    try:
        import LoRaWAN
        from LoRaWAN.MHDR import MHDR
    except ImportError:
        print "LoRaWAN python lib must be installed"
        print "loraWAN.py: checking for LoRaWAN lib"
        if os.path.isfile(os.path.expanduser("aes-python-lib/LoRaWAN/MHDR.py")):
            cmd_arg = "sudo cp -r aes-python-lib/LoRaWAN /usr/lib/python2.7/dist-packages"
            print "copying LoRaWAN lib in python distribution"
            try:
                os.system(cmd_arg)
            except:
                print "Error when copying LoRaWAN lib"
                return False
            print "try importing LoRaWAN lib again"
            try:
                import LoRaWAN
                from LoRaWAN.MHDR import MHDR

                print "import now ok"
                return True
            except ImportError:
                print "sorry, error."
                return False
        else:
            return False
    print "import ok"
    return True


PKT_TYPE_DATA = 0x10
replchars = re.compile(r"[\x00-\x1f]")


def replchars_to_hex(match):
    return r"\x{0:02x}".format(ord(match.group()))


def loraWAN_process_pkt(lorapkt):
    if (lorapkt[0] == 0x40) or (lorapkt[0] == 0x80):
        appskey = bytearray.fromhex(loraWAN_config.AppSKey)
        appskeylist = []
        for i in range(0, len(appskey)):
            appskeylist.append(appskey[i])
        nwkskey = bytearray.fromhex(loraWAN_config.NwkSKey)
        nwkskeylist = []
        for i in range(0, len(nwkskey)):
            nwkskeylist.append(nwkskey[i])
        lorawan = LoRaWAN.new(nwkskeylist)
        lorawan.read(lorapkt)
        lorawan.compute_mic()
        if lorawan.valid_mic():
            print "?loraWAN: valid MIC"
            lorawan = LoRaWAN.new(appskeylist)
            lorawan.read(lorapkt)
            plain_payload = "".join(chr(x) for x in lorawan.get_payload())
            print "?loraWAN: plain payload is " + replchars.sub(replchars_to_hex, plain_payload)
            return plain_payload
        else:
            return "###BADMIC###"
    else:
        return "###BADMIC###"


def loraWAN_get_MIC(device, lorapktstr):
    appskey = bytearray.fromhex(loraWAN_config.AppSKey)
    appskeylist = []
    for i in range(0, len(appskey)):
        appskeylist.append(appskey[i])
    nwkskey = bytearray.fromhex(loraWAN_config.NwkSKey)
    nwkskeylist = []
    for i in range(0, len(nwkskey)):
        nwkskeylist.append(nwkskey[i])
    deviceHex = "%0.8X" % device
    deviceArray = bytearray.fromhex(deviceHex)
    devaddr = []
    for i in range(0, len(deviceArray)):
        devaddr.append(deviceArray[len(deviceArray) - 1 - i])
    lorawan = LoRaWAN.new(appskey)
    lorawan.create(MHDR.UNCONF_DATA_UP, {"devaddr": devaddr, "data": list(map(ord, lorapktstr))})
    lorawan.__init__(nwkskey)
    MIC = lorawan.compute_mic()
    return MIC


if __name__ == "__main__":
    argc = len(sys.argv)
    if argc > 1:
        lorapktstr_b64 = sys.argv[1]
    else:
        sys.exit("loraWAN.py needs at least a base64 encoded string argument")
    if argc > 2:
        pdata = sys.argv[2]
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
    if argc > 3:
        rdata = sys.argv[3]
    plain_payload = "###BADMIC###"
    try:
        lorapktstr = base64.b64decode(lorapktstr_b64)
        lorapkt = []
        for i in range(0, len(lorapktstr)):
            lorapkt.append(ord(lorapktstr[i]))
        plain_payload = loraWAN_process_pkt(lorapkt)
    except TypeError:
        plain_payload = "###BADMIC###"
    if plain_payload == "###BADMIC###":
        print "?" + plain_payload
    else:
        ptype = ptype & (~PKT_FLAG_DATA_ENCRYPTED)
        print "?plain payload is: " + plain_payload
        if argc > 2:
            print "^p%d,%d,%d,%d,%d,%d,%d" % (dst, ptype, src, seq, len(plain_payload), SNR, RSSI)
        if argc > 3:
            print "^r" + rdata
        print "\xFF\xFE" + plain_payload

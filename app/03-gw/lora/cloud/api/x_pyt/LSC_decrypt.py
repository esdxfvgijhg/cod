import numpy as np
import time
import base64
import sys
import re
import LSC_config

np.seterr(over="ignore")
LSC_DETERMINISTIC = True
LSC_SKEY = 16
LSC_STATIC_KEY = True
LSC_WMIC = True
LSC_MICv = 2
LSC_SMIC = 4
HEADER_SIZE = 4
APPKEY_SIZE = 4
PKT_TYPE_DATA = 0x10
PKT_TYPE_ACK = 0x20
PKT_FLAG_ACK_REQ = 0x08
PKT_FLAG_DATA_ENCRYPTED = 0x04
PKT_FLAG_DATA_WAPPKEY = 0x02
PKT_FLAG_DATA_DOWNLINK = 0x01


def xorshift32(t):
    x = t
    x = x ^ (x << np.uint32(13))
    x = x ^ (x >> np.uint32(17))
    x = x ^ (x << np.uint32(5))
    return np.uint32(x)


def rc4key(key, sc, size_DK):
    for i in range(256):
        sc[i] = i
    j0 = 0
    for i0 in range(256):
        j0 = j0 + sc[i0] + key[i0 & (size_DK - 1)]
        tmp = sc[i0]
        sc[np.uint8(i0)] = sc[np.uint8(j0)]
        sc[np.uint8(j0)] = tmp


def rc4keyperm(key, lenH, rp, sc, size_DK):
    for i in range(lenH):
        sc[i] = i
    for it in range(rp):
        j0 = 1
        for i0 in range(lenH):
            j0 = (j0 + sc[i0] + sc[j0] + key[i0 % size_DK]) % lenH
            tmp = sc[i0]
            sc[i0] = sc[j0]
            sc[j0] = tmp


def prga(sc, ldata, r):
    i0 = 0
    j0 = 0
    for it in range(ldata):
        i0 = (i0 + 1) % 255
        j0 = (j0 + sc[i0]) & 0xFF
        tmp = sc[i0]
        sc[i0] = sc[j0]
        sc[j0] = tmp
        r[it] = sc[(sc[i0] + sc[j0]) & 0xFF]


def encrypt_ctr(seq_in, seq_out, lenH, RM1, PboxRM, Sbox1, Sbox2, myrand):
    X = np.empty([h2], dtype=np.uint8)
    fX = np.empty([h2], dtype=np.uint8)
    ind = 0
    for a in range(0, h2, 4):
        mm = myrand
        X[a] = Sbox1[RM1[a] ^ (mm & 255)]
        mm >>= 8
        X[a + 1] = Sbox2[RM1[a + 1] ^ (mm & 255)]
        mm >>= 8
        X[a + 2] = Sbox1[RM1[a + 2] ^ (mm & 255)]
        mm >>= 8
        X[a + 3] = Sbox2[RM1[a + 3] ^ (mm & 255)]
    for it in range(lenH):
        for a in range(0, h2, 4):
            myrand = xorshift32(myrand)
            mm = myrand
            X[a] = Sbox2[X[a] ^ RM1[a] ^ (mm & 255)]
            mm >>= 8
            X[a + 1] = Sbox1[X[a + 1] ^ RM1[a + 1] ^ (mm & 255)]
            mm >>= 8
            X[a + 2] = Sbox2[X[a + 2] ^ RM1[a + 2] ^ (mm & 255)]
            mm >>= 8
            X[a + 3] = Sbox1[X[a + 3] ^ RM1[a + 3] ^ (mm & 255)]
        for a in range(h2):
            fX[a] = X[a] ^ seq_in[ind + a]
        for a in range(h2):
            seq_out[ind + a] = fX[a]
        for a in range(0, h2, 4):
            RM1[a] = Sbox2[RM1[PboxRM[a]]]
            RM1[a + 1] = Sbox1[RM1[PboxRM[a + 1]]]
            RM1[a + 2] = Sbox2[RM1[PboxRM[a + 2]]]
            RM1[a + 3] = Sbox1[RM1[PboxRM[a + 3]]]
        ind = ind + h2


def LSC_process_pkt(lorapkt, dst, ptype, src, seq):
    if LSC_DETERMINISTIC == True:
        RM1 = np.copy(RMorig)
        RM2 = np.copy(RM1)
    size_mesg = len(lorapkt)
    if LSC_WMIC:
        lenH = np.uint32((size_mesg + HEADER_SIZE + h2 - 1) / h2)
    else:
        lenH = np.uint32((size_mesg + h2 - 1) / h2)
    plain = np.empty([lenH * h2], dtype=np.uint8)
    cipher = np.empty([lenH * h2], dtype=np.uint8)
    check = np.empty([lenH * h2], dtype=np.uint8)
    for i in range(lenH * h2):
        cipher[i] = 0
    if LSC_WMIC:
        cipher[0] = dst
        cipher[1] = ptype
        cipher[2] = src
        cipher[3] = seq
        for i in range(size_mesg):
            cipher[HEADER_SIZE + i] = lorapkt[i]
        print "?LSC: received MIC: ",
        print (cipher[size_mesg + HEADER_SIZE - LSC_SMIC : size_mesg + HEADER_SIZE])
        encrypt_ctr(cipher, plain, lenH, RM1, PboxRM, Sbox1, Sbox2, (seq + 1) % 256)
        if LSC_MICv == 1:
            plain[0] = plain[LSC_SMIC]
            plain[1] = plain[LSC_SMIC + 1]
            plain[2] = plain[LSC_SMIC + 2]
            plain[3] = plain[LSC_SMIC + 3]
        elif LSC_MICv == 2:
            myMIC = np.sum(plain[: size_mesg + HEADER_SIZE - LSC_SMIC])
            plain[0] = xorshift32(np.uint32(myMIC % 7))
            plain[1] = xorshift32(np.uint32(myMIC % 13))
            plain[2] = xorshift32(np.uint32(myMIC % 29))
            plain[3] = xorshift32(np.uint32(myMIC % 57))
        elif LSC_MICv == 3:
            print "todo"
        print "?LSC: computed MIC: ",
        print (plain[:LSC_SMIC])
        if np.array_equal(plain[:LSC_SMIC], cipher[size_mesg + HEADER_SIZE - LSC_SMIC : size_mesg + HEADER_SIZE]):
            print "?LSC: valid MIC"
            size_mesg -= LSC_SMIC
            for i in range(size_mesg):
                cipher[i] = lorapkt[i]
        else:
            return "###BADMIC###"
    else:
        for i in range(size_mesg):
            cipher[i] = lorapkt[i]
    encrypt_ctr(cipher, check, lenH, RM2, PboxRM, Sbox1, Sbox2, seq)
    s_plain = check.tostring()
    print "?LSC: plain payload is " + replchars.sub(replchars_to_hex, s_plain[:size_mesg])
    return s_plain[:size_mesg]


h = 4  ###################
h2 = h * h
rp = 1
seed = 123
DK = np.empty([LSC_SKEY], dtype=np.uint8)
Nonce = np.empty([LSC_SKEY], dtype=np.uint8)
sc = np.empty([256], dtype=np.uint8)
PboxRM = np.empty([h2], dtype=np.uint8)
Sbox1 = np.empty([256], dtype=np.uint8)
Sbox2 = np.empty([256], dtype=np.uint8)
RM1 = np.empty([h2], dtype=np.uint8)
RM2 = np.empty([h2], dtype=np.uint8)
RMorig = np.empty([h2], dtype=np.uint8)
for i in range(0, LSC_SKEY, 4):
    seed = xorshift32(seed)
    val = seed
    DK[i] = val & 0xFF
    val >>= 8
    DK[i + 1] = val & 0xFF
    val >>= 8
    DK[i + 2] = val & 0xFF
    val >>= 8
    DK[i + 3] = val & 0xFF
PKT_TYPE_DATA = 0x10
replchars = re.compile(r"[\x00-\x1f]")


def replchars_to_hex(match):
    return r"\x{0:02x}".format(ord(match.group()))


if LSC_STATIC_KEY:
    Nonce = np.copy(LSC_config.Nonce)
else:
    for i in range(0, LSC_SKEY, 4):
        seed = xorshift32(seed)
        val = seed
        Nonce[i] = val & 0xFF
        val >>= 8
        Nonce[i + 1] = val & 0xFF
        val >>= 8
        Nonce[i + 2] = val & 0xFF
        val >>= 8
        Nonce[i + 3] = val & 0xFF
for i in range(LSC_SKEY):
    DK[i] = DK[i] ^ Nonce[i]
rc4key(DK[0 : LSC_SKEY / 4], sc, LSC_SKEY / 4)
prga(sc, h2, RM1)
rc4keyperm(DK[LSC_SKEY / 4 : 2 * LSC_SKEY / 4], h2, rp, PboxRM, LSC_SKEY / 4)
rc4key(DK[2 * LSC_SKEY / 4 : 3 * LSC_SKEY / 4], Sbox1, LSC_SKEY / 4)
rc4key(DK[3 * LSC_SKEY / 4 : LSC_SKEY], Sbox2, LSC_SKEY / 4)
RM2 = np.copy(RM1)
RMorig = np.copy(RM1)
myrand = np.uint32(0)
for i in range(min(LSC_SKEY, 32)):
    myrand = myrand | (DK[i] & 1)
    myrand = np.uint32(myrand << 1)
if __name__ == "__main__":
    argc = len(sys.argv)
    if argc > 1:
        lorapktstr_b64 = sys.argv[1]
    else:
        sys.exit("LSC-decrypt.py needs at least a base64 encoded string argument")
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
        plain_payload = LSC_process_pkt(lorapkt, dst, ptype, src, seq)
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

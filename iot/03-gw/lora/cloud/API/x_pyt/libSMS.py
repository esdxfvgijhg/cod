import os
import socket
import ssl
import time
import urllib2


def gammuCheck():
    try:
        import gammu

        return True
    except ImportError:
        print "gammu and python-gammu must be installed"
        return False


def gammurcCheck(gammurc_file):
    if os.path.isfile(os.path.expanduser(gammurc_file)):
        return True
    else:
        print "missing .gammurc file"
        return False


def phoneConnection(gammurc_file, pin):
    sm = None
    try:
        import gammu

        if gammurcCheck(gammurc_file):
            sm = gammu.StateMachine()
            sm.ReadConfig(Filename=gammurc_file)
            sm.Init()
            if sm.GetSecurityStatus() == "PIN":
                sm.EnterSecurityCode("PIN", pin)
            netInfo = sm.GetNetworkInfo()
            if netInfo["GPRS"] != "Attached":
                print "Operator issue"
                sm = None
    except ImportError:
        print "gammu and python-gammu must be installed"
    except gammu.ERR_DEVICENOTEXIST:
        print "3G dongle is not detected"
        sm = None
    except gammu.ERR_TIMEOUT:
        print "No response in specified timeout"
        sm = None
    except gammu.ERR_SECURITYERROR:
        print "Pin code issue: enter the correct pin code"
        print "You can also remove the pin code protection on the SIM card"
        sm = None
    except gammu.ERR_UNKNOWN:
        print "Pin code issue: enter the correct pin code"
        print "You can also remove the pin code protection on the SIM card"
        sm = None
    return sm


def internet_ON():
    try:
        response = urllib2.urlopen("http://google.com", timeout=3)
        return True
    except urllib2.URLError, e:
        pass
    except socket.timeout:
        pass
    except ssl.SSLError:
        pass
    return False


def send_sms(sm, data, numbers):
    message = {
        "Text": data,
        "SMSC": {"Location": 1},
    }
    for number in numbers:
        message["Number"] = number
        try:
            sm.SendSMS(message)
            print ("Sent to %s successfully!" % (number))
            success = True
        except Exception, exc:
            print ("Sending to %s failed: %s" % (number, exc))
            success = False
    return success

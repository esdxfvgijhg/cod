from bluetooth import *
from MongoDB import get_documents, get_nodes_names
import datetime
import signal
import sys

server_sock = BluetoothSocket(RFCOMM)
server_sock.bind(("", PORT_ANY))
server_sock.listen(1)
port = server_sock.getsockname()[1]
uuid = "94f39d29-7d6d-437d-973b-fba39e49d4ee"
advertise_service(
    server_sock, "SampleServer", service_id=uuid, service_classes=[uuid, SERIAL_PORT_CLASS], profiles=[SERIAL_PORT_PROFILE],
)


def signal_handler(signal, frame):
    print ("You pressed Ctrl+C or killed the process!")
    print ("disconnected")
    server_sock.close()
    print "Bye."
    sys.exit(0)


if len(sys.argv) == 2 and sys.argv[1] == "-bg":
    signal.signal(signal.SIGTERM, signal_handler)
else:
    signal.signal(signal.SIGINT, signal_handler)
while True:
    print "Waiting for connection on RFCOMM channel %d" % port
    sys.stdout.flush()
    client_sock, client_info = server_sock.accept()
    print "Accepted connection from ", client_info
    sys.stdout.flush()
    try:
        data = client_sock.recv(1024)
        if len(data) == 0:
            break
        print "received [%s]" % data
        if data.startswith("data"):
            preferences = data.split("$")
            nodeArray = None
            beginDate = None
            endDate = None
            if not preferences[1] == "":
                nodeArray = preferences[1].split(";")  # array of nodes names
            if not preferences[2] == "":
                dateArray = preferences[2].split("-")  # array of strings representing beginDate and endDate
                if dateArray[0].startswith("begin_"):
                    auxDate = dateArray[0].split("_")  # retrieving {'begin',day,month-1,year}
                    beginDate = datetime.datetime(int(auxDate[3]), int(auxDate[2]) + 1, int(auxDate[1]), 0, 0, 0, 0)
                    auxDate = dateArray[1].split("_")  # retrieving {'end',day,month-1,year}
                    endDate = datetime.datetime(int(auxDate[3]), int(auxDate[2]) + 1, int(auxDate[1]), 23, 59, 59, 999999)
                else:
                    auxDate = dateArray[1].split("_")  # retrieving {'begin',day,month-1,year}
                    beginDate = datetime.datetime(int(auxDate[3]), int(auxDate[2]) + 1, int(auxDate[1]), 0, 0, 0, 0)
                    auxDate = dateArray[0].split("_")  # retrieving {'end',day,month-1,year}
                    endDate = datetime.datetime(int(auxDate[3]), int(auxDate[2]) + 1, int(auxDate[1]), 23, 59, 59, 999999)
            data = ""
            if (nodeArray is None) and (not beginDate is None) and (not endDate is None):
                data = "ERROR : no node is selected, please select at least one node in the preferences page.!"
                print ("ERROR: no node is checked")
            elif (not beginDate is None) and (not endDate is None) and (beginDate > endDate):
                data = "ERROR : the begin date (" + beginDate.strftime("%d-%m-%Y") + ") you have selected in the preferences page has passed after the selected end date (" + endDate.strftime("%d-%m-%Y") + "). Please, you must change your choosen dates in the preferences page.!"
                print ("ERROR : beginDate > endDate")
            else:
                documents = get_documents(nodeArray, beginDate, endDate)
                for doc in documents:
                    data += "NODE: " + str(doc["node_eui"]) + " DATE: " + str(doc["time"]) + " DATA: " + str(doc["data"]) + "\n"
                data += "!"
                print ("sending data")
            sys.stdout.flush()
        elif data.startswith("file"):
            preferences = data.split("$")
            nodeArray = None
            beginDate = None
            endDate = None
            if not preferences[1] == "":
                nodeArray = preferences[1].split(";")  # array of nodes names
            if not preferences[2] == "":
                dateArray = preferences[2].split("-")  # array of strings representing beginDate and endDate
                if dateArray[0].startswith("begin_"):
                    auxDate = dateArray[0].split("_")  # retrieving {'begin',day,month-1,year}
                    beginDate = datetime.datetime(int(auxDate[3]), int(auxDate[2]) + 1, int(auxDate[1]), 0, 0, 0, 0)
                    auxDate = dateArray[1].split("_")  # retrieving {'end',day,month-1,year}
                    endDate = datetime.datetime(int(auxDate[3]), int(auxDate[2]) + 1, int(auxDate[1]), 23, 59, 59, 999999)
                else:
                    auxDate = dateArray[1].split("_")  # retrieving {'begin',day,month-1,year}
                    beginDate = datetime.datetime(int(auxDate[3]), int(auxDate[2]) + 1, int(auxDate[1]), 0, 0, 0, 0)
                    auxDate = dateArray[0].split("_")  # retrieving {'end',day,month-1,year}
                    endDate = datetime.datetime(int(auxDate[3]), int(auxDate[2]) + 1, int(auxDate[1]), 23, 59, 59, 999999)
            data = ""
            if (nodeArray is None) and (not beginDate is None) and (not endDate is None):
                data = "ERROR : no node is selected, please select at least one node in the preferences page.!"
                print ("ERROR: no node is checked")
            elif (not beginDate is None) and (not endDate is None) and (beginDate > endDate):
                data = "ERROR : the begin date (" + beginDate.strftime("%d-%m-%Y") + ") you have selected in the preferences page has passed after the selected end date (" + endDate.strftime("%d-%m-%Y") + "). Please, you must change your choosen dates in the preferences page.!"
                print ("ERROR : beginDate > endDate")
            else:
                data = "type;gateway_eui;node_eui;snr;rssi;cr;datarate;time;data\n"
                documents = get_documents(nodeArray, beginDate, endDate)
                for doc in documents:
                    data += str(doc["type"]) + ";"
                    data += str(doc["gateway_eui"]) + ";"
                    data += str(doc["node_eui"]) + ";"
                    data += str(doc["snr"]) + ";"
                    data += str(doc["rssi"]) + ";"
                    data += str(doc["cr"]) + ";"
                    data += str(doc["datarate"]) + ";"
                    data += str(doc["time"].isoformat()) + ";"
                    data += str(doc["data"])
                    data += "\n"
                data += "!"
            print ("sending data to be in the csv file")
        elif data == "nodes":
            data = get_nodes_names()
            data += "!"
            print ("sending nodes names")
        else:
            data = "ERROR : BAD_ENTRY, PLEASE USE THE APP!"
            print ("bad entry")
        sys.stdout.flush()
        client_sock.send(data)
    except IOError:
        pass
    except KeyboardInterrupt:
        print ("disconnected")
        client_sock.close()
        server_sock.close()
        print "all done"
        break
    sys.stdout.flush()

import pymongo
from pymongo import MongoClient
import datetime
from datetime import timedelta

_max_months_stored = 0


def mongodb_set_max_months(max_months):
    global _max_months_stored
    _max_months_stored = max_months


def monthdelta(date, delta):
    m, y = (date.month + delta) % 12, date.year + ((date.month) + delta - 1) // 12
    if not m:
        m = 12
    d = min(date.day, [31, 29 if y % 4 == 0 and not y % 400 == 0 else 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][m - 1])
    return date.replace(day=d, month=m, year=y)


def add_document(document):
    try:
        client = MongoClient()
        db = client.messages
        db.ReceivedData.insert_one(document)
    except Exception as e:
        print("MongoDB: can not add document in MongoDB: " + str(e))


def remove_if_new_month(now):
    try:
        client = MongoClient()
        db = client.messages
        if db.ReceivedData.count() > 0:
            print("MongoDB: deleting data older than " + str(_max_months_stored) + " month(s)...")
            deleted_docs = 0
            for msg in db.ReceivedData.find({"time": {"$lt": monthdelta(now, -_max_months_stored)}}):
                db.ReceivedData.remove(msg)
                deleted_docs += 1
            print("MongoDB: " + str(deleted_docs) + " documents deleted")
    except Exception as e:
        print("MongoDB: error while deleting documents: " + str(e))


def get_documents_since_date(date):
    client = MongoClient()
    db = client.messages
    return db.ReceivedData.find({"time": {"$gte": date}}).sort("time", pymongo.ASCENDING)


def get_documents(nodeArray, beginDate, endDate):
    client = MongoClient()
    db = client.messages
    if nodeArray is None and beginDate is None and endDate is None:
        date = datetime.datetime.utcnow() - timedelta(days=8)
        date = date.replace(hour=0, minute=0, second=0, microsecond=0)
        documents = db.ReceivedData.find({"time": {"$gte": date}}).sort("time", pymongo.ASCENDING)
        docArray = []
        for doc in documents:
            docArray.append(doc)
        return docArray
    elif beginDate is None and endDate is None:
        date = datetime.datetime.utcnow() - timedelta(days=8)
        date = date.replace(hour=0, minute=0, second=0, microsecond=0)
        arrayDocuments = []
        documents = db.ReceivedData.find({"time": {"$gte": date}}).sort("time", pymongo.ASCENDING)
        docArray = []
        for doc in documents:
            if str(doc["node_eui"]) in nodeArray:
                docArray.append(doc)
        return docArray
    else:
        documentsArray = []
        documents = db.ReceivedData.find({"time": {"$gte": beginDate, "$lte": endDate}}).sort("time", pymongo.ASCENDING)
        docArray = []
        for doc in documents:
            if str(doc["node_eui"]) in nodeArray:
                docArray.append(doc)
        return docArray


def get_nodes_names():
    client = MongoClient()
    db = client.messages
    documents = db.ReceivedData.find().sort("time", pymongo.ASCENDING).sort("node_eui", pymongo.ASCENDING)
    number_of_documents = documents.count()
    nodes_names = ""
    dates_current_node = ""
    last_date = ""
    last_node_name = ""
    iteration = 0
    for doc in documents:
        if last_node_name == "":
            last_node_name = str(doc["node_eui"])
            nodes_names = last_node_name
            dates_current_node = (doc["time"]).date().isoformat()
            last_date = dates_current_node
            iteration += 1
        elif last_node_name != str(doc["node_eui"]):
            last_node_name = str(doc["node_eui"])
            dates_current_node += "_" + last_date
            nodes_names += "#" + dates_current_node + ";" + last_node_name
            dates_current_node = (doc["time"]).date().isoformat()
            last_date = dates_current_node
            iteration += 1
        else:
            last_date = (doc["time"]).date().isoformat()
            iteration += 1
        if iteration == number_of_documents:
            dates_current_node += "_" + (doc["time"]).date().isoformat()
            nodes_names += "#" + dates_current_node
    return nodes_names


def represents_integer(str):
    try:
        int(str)
        return True
    except ValueError:
        return False

# -*- coding: utf-8 -*-
#! /usr/bin/env python
import sys
import paho.mqtt.client as mqtt
import json
import time
import socket
import datetime
from random import randint
import struct
from ctypes import *
#------------------------------------------------------------#
# Variables
#------------------------------------------------------------#
# 3 values can be sent to the broker for the traffic lights
# 
# 0 : Red light
# 1 : Yellow light
# 2 : Green light
#
# For topics we have zolertia with 2 variables roada et roadb.
# It matches the two roads (roada and RoadB) of a crossroad explained in the wiki page
#------------------------------------------------------------#
ID_STRING      = "V0.1"
#------------------------------------------------------------#
MQTT_URL          = "things.ubidots.com"		# Url for accesing the Broker MQTT
MQTT_PORT         = 1883						# MQTT port
MQTT_KEEPALIVE    = 50
MQTT_URL_PUB      = "/v1.6/devices/zolertia" 	# publishing TOPIC
MQTT_URL_TOPIC    = "/v1.6/devices/zolertia/+/lv"	# subscribing TOPIC
#------------------------------------------------------------#
# Variables used
#------------------------------------------------------------#
var1 = "ADC1"
var2 = "ADC2"
var3 = "ADC3"
var4 = "ADC4"
#------------------------------------------------------------#
HOST		= "aaaa::1"
CLIENT		= "aaaa::212:4b00:616:f5f" # Matching the border router address fe80::212:4b00:60d:b3ef
PORT		= 5678
CMD_PORT	= 8765
BUFSIZE		= 4096
#------------------------------------------------------------#
# If using a client based on the Z1 mote, then enable by equal to 1, else if
# using the RE-Mote equal to 0
EXAMPLE_WITH_Z1   = 0
#------------------------------------------------------------#
ENABLE_MQTT       = 1
ENABLE_LOG        = 1
#------------------------------------------------------------#
DEBUG_PRINT_JSON  = 1

RETAIN = (0, "", 0)

#------------------------------------------------------------#
# Socket used thoughout the process
#------------------------------------------------------------#
SOCK = None
#------------------------------------------------------------#
# Message structure
#------------------------------------------------------------#
class SENSOR(Structure):
	_pack_   = 1
		# Structure Key/Value
	_fields_ = 	[("id",c_uint8),
			("counter",c_uint16),
			(var1,c_uint16),
			(var2,c_uint16),
			(var3,c_uint16),
			(var4,c_uint16),
			("battery",c_uint16)]

	def __new__(self, socket_buffer):
        	return self.from_buffer_copy(socket_buffer)

	def __init__(self, socket_buffer):
        	pass

#routes_dict = {}
routes_dict = {'roada': {'aaaa::212:4b00:60d:b318': '0', 'aaaa::212:4b00:60d:b288': '0'}, 'roadb': {'aaaa::212:4b00:60d:b41c': '2', 'aaaa::212:4b00:60d:b374': '2'}, 'feu3': {}, 'sensorRoad1': {}, 'sensorRoad2': {}} #Just for testing, automatically add new addresses and topics
trafficlight_state = {"roada": 0, "roadb": 2}
trafficlight_state_conf = {"roada":  0, "roadb": 0}

#------------------------------------------------------------#
# Export expected values from messages
#------------------------------------------------------------#
def jsonify_recv_data(msg, no_str=None):		# Get traffic light state from message
	for f_name, f_type in msg._fields_:
		if f_name =="ADC2":	# Get expected value
			if getattr(msg, f_name) != "0":
				value=getattr(msg, f_name) 	
			sensordata=value
	if no_str:
		return sensordata
	return str(sensordata)
# -----------------------------------------------------------#
def jsonify_recv_QOS(msg):						# Get QoS from message
	for f_name, f_type in msg._fields_:
		if f_name =="ADC3":	# Get expected value
			QOS=getattr(msg, f_name)		
	return str(QOS)

def jsonify_recv_BATTERY(msg):						# Get battery status from message
	for f_name, f_type in msg._fields_:
		if f_name =="battery":	# Get expected value
			bat=getattr(msg, f_name)		
	return str(bat)

def jsonify_recv_conf(msg, no_str=None):		# Get traffic light state from message
	for f_name, f_type in msg._fields_:
		if f_name =="ADC4":	# Get expected value
			if getattr(msg, f_name) != "0":
				value=getattr(msg, f_name) 	
			CONFIRMATION=value
	if no_str:
		return int(CONFIRMATION)
	return str(CONFIRMATION)
# -----------------------------------------------------------#
# Sender fonction to test modules
# -----------------------------------------------------------#

def update_trafficlights_cmd(var, opt_value=None, urgent=None):	
	if var not in routes_dict:
		routes_dict[var] = {}
	print routes_dict[var].keys()
	if var == "all": # All clients from every traffic topics
		db = [routes_dict[c].keys() for c in routes_dict] # TO DO
		print db
	else: # clients from a specific topic
		db = routes_dict[var].keys()
	for client in db:
		# print "Sending reply to " + client
		try:
			if opt_value: # Specific value to send
				data = opt_value
			else:
				data = trafficlight_state[var]
			if urgent: # Reset traffic lights timer
				qos = 2
				my_msg = struct.pack("III", int(data), qos, 0)
			else: # confirmation process
				qos = 0
				my_msg = struct.pack("III", int(data), qos, 1)
			SOCK.sendto(my_msg, (client, CMD_PORT))

			#Put his confirmation on a queue + add in the message a specific id in order to retreive it 
			
		except Exception as error:
			print error
# -----------------------------------------------------------#
# Print publisher's message received
# -----------------------------------------------------------#
def print_recv_data(msg):		
	print "***"
	for f_name, f_type in msg._fields_:
		print "{0}:{1} ".format(f_name, getattr(msg, f_name)), 
	print
	print "***"
# -----------------------------------------------------------#
# Publish to MQTT Broker
# -----------------------------------------------------------#
def publish_recv_data(data, pubid, conn, addr,QOS):
	try:
		# Select which traffic light sent something
		if pubid == 1:
			TOPIC = "roada"
		if pubid == 2:
			TOPIC = "roadb"
		if pubid == 3:
			TOPIC = "roada"
		if pubid == 4:
			TOPIC = "roadb"
		if pubid == 5:
			TOPIC = "sensorRoad1"
		if pubid == 6:
			TOPIC = "sensorRoad2"
		if pubid <1 and pubid > 6 :
			print "ID no recognized"

		# print
		print "Data received : ", data, "by trafficlight : ", pubid, "addr : ",addr, "QoS : ",QOS
		# print

		if TOPIC not in routes_dict:
			# print "Creation of "+TOPIC
			routes_dict[TOPIC] = {}

		if addr not in routes_dict[TOPIC]:
			# print "Collecting client address"
			routes_dict[TOPIC][addr] = data
			# print str(routes_dict)

		if QOS == '2':
			print
			print "Important data received, waiting to publish"
			print
		if QOS=='1':
			print
			print "Data sent less once on Ubidots"
			print
		if QOS=='0':
			print
			print "Data directly sent to Ubidots without verification"
			print

		if QOS == '2': # Security => Ubidots education up to lvl 1 if lvl 2 is sent continuous confirmation fail and packet redistribution
			QOS = 1
		

		payload = json.dumps({"battery": 12, "uptime": 1033, "trafficlight": data, "id": pubid})
		conn.publish("/v1.6/devices/007d"+addr[-4:], payload, qos=int(QOS))

		if (pubid == 5) or ((pubid == 1) and data == "2" and trafficlight_state[TOPIC] != data): # trafficlight 1 goes to green

			payload = json.dumps({"roadb": 0, "roada": data})

			res, mid = conn.publish(MQTT_URL_PUB, payload, qos=int(QOS))

		if (pubid == 6) or ((pubid == 2) and data == "2" and trafficlight_state[TOPIC] != data): # trafficlight 2 goes to green

			payload = json.dumps({"roada": 0, "roadb": data})

			res, mid = conn.publish(MQTT_URL_PUB, payload, qos=int(QOS))

		if (pubid == 2) and data == "0" and trafficlight_state[TOPIC] != data: # trafficlight 2 goes to red
			
			payload = json.dumps({"roadb": data, "roada": 2})

			res, mid = conn.publish(MQTT_URL_PUB, payload, qos=int(QOS))

		if (pubid == 1) and data == "0" and trafficlight_state[TOPIC] != data: # trafficlight 1 goes to red

			payload = json.dumps({"roada": data, "roadb": 2})

			res, mid = conn.publish(MQTT_URL_PUB, payload, qos=int(QOS))
			
			
		if data == "1" and (pubid < 3):
			
			payload = json.dumps({"roada": data, "roadb": data})

			res, mid = conn.publish(MQTT_URL_PUB, payload, qos=int(QOS))

		# time.sleep(0.8)
		print("Data sent to server")
		if QOS in [1, 2]:
			print "sleep"
			time.sleep(0.8) # time to send the message without perturbation
		
	except Exception as error:
		print error
# -----------------------------------------------------------#
# MQTT Function
# -----------------------------------------------------------#
# The callback for when the client receives a CONNACK response from the server.
def on_connect(client, userdata, flags, rc):
	print("Connected with result code "+str(rc))
	print("Subscribed to " + MQTT_URL_TOPIC)
	client.subscribe(MQTT_URL_TOPIC, 2) # 2nd arg is the QoS level to use at maximum when it's needed
	#print("usrData: "+str(userdata))
	#print("client: " +str(client))
	#print("flags: " +str(flags))
#------------------------------------------------------------#
# The callback for when a PUBLISH message is received from the server.
def on_message(client, userdata, msg):
	global RETAIN
	print ("Published message from server ")
	now = datetime.datetime.now()
	print "End point : "+ str(now)
	print(msg.topic + " " + str(msg.payload) + ", QoS: " + str(msg.qos))
	if(msg.payload[0] != "{"):
		var = str(msg.topic.split('/',5)[4])
		if var == "feu2" or var == "feu1":
			return

		if(trafficlight_state[var] != msg.payload ): # Update valid and needed
			print trafficlight_state[var], trafficlight_state, msg.payload
			# Condition to retain information if the first message is a green state
			if( (var == "roada" and trafficlight_state["roadb"] == msg.payload and msg.payload == "2") or (var == "roadb" and trafficlight_state["roada"] == msg.payload and msg.payload == "2") ): 
				RETAIN = (1, var, msg.payload)
				print "RETAIN"
			elif (msg.payload == "0" and RETAIN[0] == 1): # Applying retain
				trafficlight_state_conf["roada"] = 0
				trafficlight_state_conf["roadb"] = 0
				update_trafficlights_cmd(var, opt_value=msg.payload)
				print "Update red with RETAIN"
			else: #Right order do nothing
				trafficlight_state_conf[var] = 0
				if(msg.payload == "2"):
					time.sleep(3)
				update_trafficlights_cmd(var, opt_value=msg.payload)
		else:
			print "Already set"
	print "-----------------------------------------------------------"

def on_log(client, userdata, msg, buffer):
	print buffer

def on_publish(client, userdata, result):
	print "Published!", result
	print

#------------------------------------------------------------#
# Main function
#------------------------------------------------------------#
def start_client():
	global SOCK, RETAIN
	now = datetime.datetime.now()
	print "UDP6-MQTT server side application "  + ID_STRING
	print "Started " + str(now)
	# Datagram (udp) socket
	try:
		SOCK = socket.socket(socket.AF_INET6, socket.SOCK_DGRAM)
		print 'Socket created'
		SOCK.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	except Exception :
		print 'Failed to create socket.'
		sys.exit()
	# Set socket address and port
	try:
		server_address = (HOST, PORT)
		print >>sys.stderr, 'starting up on %s port %s' % server_address
		SOCK.bind(server_address)
		print "socket : " + str(SOCK)
		print "setsockopt : " + str(SOCK.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1))
	except socket.error as msg:
		print('Bind failed. Error Code : ' + str(msg[0]) + ' Message ' + msg[1])
		sys.exit()
		return
	print 'UDP6-MQTT server ready: %s'% PORT
	print "msg structure size: ", sizeof(SENSOR)
	print

	if ENABLE_MQTT:
		# Initialize MQTT connexion
		try:
			client = mqtt.Client()
		except Exception as error:
			print error
			raise
		# Allow connexion to the broker
		client.on_connect = on_connect
		# Set your Ubidots default token
		client.username_pw_set("A1E-0F9BtXo4RJMvlscgvV0J1ZtMAmezsS", "A1E-0F9BtXo4RJMvlscgvV0J1ZtMAmezsS") #A1E-dEzBw6HHcOgRUz22KIwvuYkfvmfixy
		client.on_message = on_message
		client.on_log = on_log
		client.on_publish = on_publish

		try:
			client.connect(MQTT_URL, MQTT_PORT, MQTT_KEEPALIVE)
		except Exception as error:
			print error
			raise

	# Start the MQTT thread and handle reconnections, also ensures the callbacks
	# being triggered
	client.loop_start()
	
	while True:

		# Receiving client data (data, addr)
		print >>sys.stderr, '\nwaiting to receive message from sensor'
		data, addr = SOCK.recvfrom(BUFSIZE)
		now = datetime.datetime.now()
		# print str(now) + " -> " + str(addr[0]) + ":" + str(addr[1]) + " " + str(len(data))
		msg_recv = SENSOR(data)
		
		if ENABLE_LOG:
			print_recv_data(msg_recv)
		
		# Get publisher values from message
		sensordata = jsonify_recv_data(msg_recv)	
		QOS = jsonify_recv_QOS(msg_recv)
		CONFIRMATION = jsonify_recv_conf(msg_recv)

		if CONFIRMATION != '0':
			print "Confirmation"
			# Check with the conf queue if it's in there and if it is, drop it from the queue 
			# and add the value verified to trafficlight_state
			print msg_recv.id, trafficlight_state_conf["roada"], trafficlight_state_conf["roadb"]

			if (msg_recv.id == 1 or msg_recv.id == 3) and trafficlight_state_conf["roada"] < 2 and trafficlight_state_conf["roada"] >= 0:
				trafficlight_state_conf["roada"] = trafficlight_state_conf["roada"] + 1
				print " Conf roada + 1:" + str(trafficlight_state_conf["roada"])
			if (msg_recv.id == 2 or msg_recv.id == 4) and trafficlight_state_conf["roadb"] < 2 and trafficlight_state_conf["roadb"] >= 0:
				trafficlight_state_conf["roadb"] = trafficlight_state_conf["roadb"] + 1
				print " Conf roadb + 1:" + str(trafficlight_state_conf["roada"])

			if trafficlight_state_conf["roada"] == 2 and RETAIN[0] == 1: # Confirmation received for red state, now updating green state
				trafficlight_state["roada"] = sensordata 
				trafficlight_state_conf["roada"] = -1
				time.sleep(3)
				update_trafficlights_cmd(var="roadb", opt_value=RETAIN[2])
				RETAIN = (0, '', 0)
				print "Conf red 1 RETAIN ok => update green"

			elif trafficlight_state_conf["roadb"] == 2 and RETAIN[0] == 1:
				trafficlight_state["roadb"] = sensordata 
				trafficlight_state_conf["roadb"] = -1
				time.sleep(3)
				update_trafficlights_cmd(var="roada", opt_value=RETAIN[2])
				RETAIN = (0, '', 0)
				print "Conf red 2 RETAIN ok => update green"

			else: # Not retained

				if trafficlight_state_conf["roada"] == 2 and sensordata == "0": # Confirmation received for red state, now updating green state
					trafficlight_state["roada"] = sensordata 
					trafficlight_state_conf["roada"] = -1
					time.sleep(3)
					update_trafficlights_cmd(var="roada", opt_value=sensordata)
					print "Conf red 1 ok => update green"
				
				if trafficlight_state_conf["roadb"] == 2 and sensordata == "0":
					trafficlight_state["roadb"] = sensordata 
					trafficlight_state_conf["roadb"] = -1
					time.sleep(3)
					update_trafficlights_cmd(var="roadb", opt_value=sensordata)
					print "Conf red 2 ok => update green"	

				if trafficlight_state_conf["roada"] == 2 and sensordata == "2": # Confirmation received for green state
					trafficlight_state["roada"] = sensordata 
					trafficlight_state_conf["roada"] = -1
					print "Conf green 1 ok"
				
				if trafficlight_state_conf["roadb"] == 2 and sensordata == "2":
					trafficlight_state["roadb"] = sensordata 
					trafficlight_state_conf["roadb"] = -1
					print "Conf green 2 ok"


				if trafficlight_state_conf["roada"] == -1 and trafficlight_state_conf["roadb"] == -1: # Confirmation on the 2 road => end of cycle everything has been checked
					print "System OK ready for next cycle"
					trafficlight_state_conf["roada"] = 0
					trafficlight_state_conf["roadb"] = 0
					RETAIN = (0, '', 0) # security
		else:

			if ENABLE_MQTT:
				print "Input : "+ str(now)
				publish_recv_data(sensordata, msg_recv.id, client, addr[0],QOS)

			if QOS == "2": # If a touch sensor message has been received => Reset the timer for all the traffic lights
				print "QOS 2 --------"
				# TO DO send all
				update_trafficlights_cmd("roada", None, True)
				update_trafficlights_cmd("roadb", None, True)


#------------------------------------------------------------#
# MAIN APP
#------------------------------------------------------------#
if __name__ == "__main__":
 	start_client()
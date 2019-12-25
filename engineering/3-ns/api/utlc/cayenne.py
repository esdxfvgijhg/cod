#!/usr/bin/python

# -*- coding: utf-8 -*-
from coapthon.client.helperclient import HelperClient
import cayenne.client

#hackathon_silecs_final

# CoAP node to observe,
# based on 06-rpl-tsch-coap Contiki firmware
COAP_HOST = "2001:660:4701:f0a0::c0c0"
COAP_PORT = 5683
COAP_URL = "/test/push"

# Cayenne authentication info. This should be obtained from the Cayenne Dashboard.
MQTT_USERNAME = ""
MQTT_PASSWORD = ""
MQTT_CLIENT_ID = ""

class IotlabDemoDashboard(object):
    """
        Basic demo for sending FIT IoT-LAB data to the MyDevices cloud
    """

    def __init__(self):
        """
            Constructor
        """
        self.cayenne_client = cayenne.client.CayenneMQTTClient()
        self.cayenne_client.on_message = self.on_message_cayenne
        self.cayenne_client.begin(MQTT_USERNAME, MQTT_PASSWORD, MQTT_CLIENT_ID)

        self.coap_client = HelperClient(server=(COAP_HOST, COAP_PORT))
        self.coap_client.observe(COAP_URL, self.on_message_observe)

    def on_message_observe(self, response):
        """
            CoAP observe callback
        """
        print "Callback Observe"
        counter = response._payload.strip('VERY LONG EVENT ')
        print counter
        self.cayenne_client.loop()
        self.cayenne_client.hectoPascalWrite(4, counter)
        self.ask_stop_observe(True, response)

    def ask_stop_observe(self, check, response):
        """
            Ask after we should stop observing
        """
        while check:
            chosen = raw_input("Stop observing? [y/N]: ")
            if chosen != "" and not (chosen == "n" or chosen == "N" or
                                     chosen == "y" or chosen == "Y"):
                print "Unrecognized choose."
                continue
            elif chosen == "y" or chosen == "Y":
                while True:
                    rst = raw_input("Send RST message? [Y/n]: ")
                    if rst != "" and not (rst == "n" or rst == "N" or
                                          rst == "y" or rst == "Y"):
                        print "Unrecognized choose."
                        continue
                    elif rst == "" or rst == "y" or rst == "Y":
                        self.coap_client.cancel_observing(response, True)
                    else:
                        self.coap_client.cancel_observing(response, False)
                    check = False
                    break
            else:
                break

    # The callback for when a message is received from Cayenne.
    def on_message_cayenne(self, message):
        """
            Mydevices Cayenne callback
        """
        # If there is an error processing the message return an error string,
        # otherwise return nothing.
        print "message received: " + str(message)

if __name__ == '__main__':
    DEMO = IotlabDemoDashboard()

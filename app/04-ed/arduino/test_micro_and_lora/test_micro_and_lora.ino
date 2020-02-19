
#include "SX1272.h"
#include <LowPower.h>
#include <SPI.h>
#include <SoftwareSerial.h>
#include <Wire.h>

#define PRINTLN Serial.println("")
#define PRINT_CSTSTR(fmt, param) Serial.print(F(param))
#define PRINT_STR(fmt, param) Serial.print(param)
#define PRINT_VALUE(fmt, param) Serial.print(param)
#define FLUSHOUTPUT Serial.flush();

unsigned long nextTransmissionTime = 0L;
uint8_t message[200];

uint8_t loraAddr           = 1;
uint8_t node_addr          = 8;
uint8_t optSW              = 0x12;
uint8_t loraMode           = 1;
uint8_t optPower           = 14;
uint16_t optBW             = BW_125;
uint8_t optCR              = CR_5;
uint8_t optSF              = SF_7;
uint32_t optCH             = CH_10_868;
uint16_t optpreamble       = 8;

void setup() {
  Serial.begin(38400);
  int e=1;
  
  while(e) e = sx1272.ON               ()                 ;PRINT_CSTSTR("%s", "ON:      ");PRINT_VALUE("%d", e);PRINTLN;
  while(e) e = sx1272.setCR            (optCR)            ;PRINT_CSTSTR("%s", "CR:      ");PRINT_VALUE("%d", sx1272.getCR());PRINTLN;
  while(e) e = sx1272.setSF            (optSF)            ;PRINT_CSTSTR("%s", "SF:      ");PRINT_VALUE("%d", sx1272.getSF());PRINTLN;
  while(e) e = sx1272.setBW            (optBW)            ;PRINT_CSTSTR("%s", "BW:      ");PRINT_VALUE("%d", sx1272.getBW());PRINTLN;
//  while(e) e = sx1272.setMode          (loraMode)         ;PRINT_CSTSTR("%s", "Mode:    ");PRINT_VALUE("%d", e);PRINTLN;
  while(e) e = sx1272.setChannel       (optCH)            ;PRINT_CSTSTR("%s", "Channel: ");PRINT_VALUE("%d", sx1272.getChannel());PRINTLN;
//  while(e) e = sx1272.setHeaderON();
//  while(e) e = sx1272.setCRC_ON();
  while(e) e = sx1272.setPowerDBM      (optPower)         ;PRINT_CSTSTR("%s", "Power:   ");PRINT_VALUE("%d", sx1272.getPower());PRINTLN;
  while(e) e = sx1272.setPreambleLength(optpreamble)                ;PRINT_CSTSTR("%s", "Header:  ");PRINT_VALUE("%d", sx1272.getPreambleLength());PRINTLN;
  while(e) e = sx1272.setSyncWord      (optSW)            ;PRINT_CSTSTR("%s", "SW:      ");PRINT_VALUE("%d", sx1272.getSyncWord());PRINTLN;
  while(e) e = sx1272.setNodeAddress   (node_addr)        ;PRINT_CSTSTR("%s", "addr:    ");PRINT_VALUE("%d", sx1272.getNodeAddress());PRINTLN;

  sx1272._enableCarrierSense = true;
  sx1272._needPABOOST        = true;
  
  delay(1000);
}

void loop() {
  if (millis() > nextTransmissionTime) {
    long startSend;
    long endSend;
    float dbValue;
    char strpacket[201]  = "aghiles_lora";
    char resmicro[50]    = "";
    float tempfloat      = 0.0;
    int tempint          = 0;
    uint8_t r_size;
    int e;
    
    sx1272.CarrierSense();
    sx1272.setPacketType(PKT_TYPE_DATA);
    r_size = sprintf((char *)message, strpacket); PRINT_CSTSTR("%s", "Sending Packet"); PRINTLN;
    startSend = millis();
    while(e) e = sx1272.sendPacketTimeout(loraAddr, message, r_size); PRINT_CSTSTR("%s", "Sent:    ");PRINT_VALUE("%d", e);PRINTLN;
    endSend = millis();
    
    Serial.print(F("Seq:   "));
    Serial.println(sx1272.packet_sent.packnum);
    Serial.print(F("Time1: "));
    Serial.println(endSend - startSend);
    Serial.print(F("Time2: "));
    Serial.println(endSend - sx1272._startDoCad);
    nextTransmissionTime = millis() + 20000;
  }
}



/*    dbValue = 20 * log10(analogRead(sensorPin));*/
/*    Serial.print("Bruit : ");*/
/*    Serial.print(dbValue);*/
/*    Serial.println(" db");*/
/*    tempfloat = dbValue * 100;*/
/*    tempint = (int)tempfloat;*/
/*    sprintf(resmicro, "Son/%d", tempint);*/
/*    sprintf(strpacket, "\\!");*/
/*    strcat(strpacket, resmicro);*/
/*    strcat(strpacket, "\0");*/
/*    Serial.print("Packet final :");*/
/*    Serial.println(strpacket);*/


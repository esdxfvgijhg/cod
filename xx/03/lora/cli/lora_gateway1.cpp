
#include "lib/SX1272.h"
#include <getopt.h>
#include <iostream>
#include "lib/rapidjson/document.h"
#include "lib/rapidjson/reader.h"
#include "lib/rapidjson/stringbuffer.h"
#include "lib/rapidjson/writer.h"
#include <math.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <termios.h>
#include <time.h>
#include <unistd.h>

#define PRINT_CSTSTR(fmt, param) printf(fmt, param)
#define PRINT_HEX(fmt, param) PRINT_VALUE(fmt, param)
#define PRINTLN printf("\n")
#define PRINT_STR(fmt, param) PRINT_CSTSTR(fmt, param)
#define PRINT_VALUE(fmt, param) PRINT_CSTSTR(fmt, param)
#define FLUSHOUTPUT fflush(stdout);

bool receivedFromLoRa      = false;
bool receivedFromSerial    = false;
bool enableDownlinkCheck   = false;
bool optAESgw              = false;
bool optHEX                = false;
bool optNDL                = false;
bool optRAW                = false;
bool radioON               = false;
double optFQ               = -1.0;

uint8_t loraAddr           = 1;
uint8_t optSW              = 0x12;
uint8_t loraMode           = 1;
uint8_t optPower           = 14;
uint16_t optBW             = BW_125;
uint8_t optCR              = CR_5;
uint8_t optSF              = SF_7;
uint32_t optCH             = CH_10_868;
uint16_t optpreamble       = 8;


char cmd[100]   = "****************";
unsigned long lastDownTime = 0;

using namespace rapidjson;
using namespace std;

void setup() {
  int e = 1;
  
  while(e) e = sx1272.ON               ()                 ;PRINT_CSTSTR("%s", "ON:      ");PRINT_VALUE("%d", e);PRINTLN;radioON = true                                        ;
//  while(e) e = sx1272.setCR            (optCR - 4)        ;PRINT_CSTSTR("%s", "CR:      ");PRINT_VALUE("%d", sx1272.getCR());PRINTLN;                                                      
//  while(e) e = sx1272.setSF            (optSF)            ;PRINT_CSTSTR("%s", "SF:      ");PRINT_VALUE("%d", sx1272.getSF());PRINTLN;                                                      
//  while(e) e = sx1272.setBW            (optBW)            ;PRINT_CSTSTR("%s", "BW:      ");PRINT_VALUE("%d", sx1272.getBW());PRINTLN;                                                      
  while(e) e = sx1272.setMode          (loraMode)         ;PRINT_CSTSTR("%s", "Mode:    ");PRINT_VALUE("%d", e);PRINTLN;
  while(e) e = sx1272.setChannel       (optCH)            ;PRINT_CSTSTR("%s", "Channel: ");PRINT_VALUE("%d", sx1272.getChannel());PRINTLN;
//  while(e) e = sx1272.setHeaderON();
//  while(e) e = sx1272.setCRC_ON();
  while(e) e = sx1272.setPowerDBM      (optPower)         ;PRINT_CSTSTR("%s", "Power:   ");PRINT_VALUE("%d", sx1272.getPower());PRINTLN;                                                      
  while(e) e = sx1272.setPreambleLength(optpreamble)      ;PRINT_CSTSTR("%s", "Header:  ");PRINT_VALUE("%d", sx1272.getPreambleLength());PRINTLN;                                                      
  while(e) e = sx1272.setSyncWord      (optSW)            ;PRINT_CSTSTR("%s", "SW:      ");PRINT_VALUE("%d", sx1272.getSyncWord());PRINTLN;
  while(e) e = sx1272.setNodeAddress   (loraAddr)         ;PRINT_CSTSTR("%s", "addr:    ");PRINT_VALUE("%d", sx1272.getNodeAddress());PRINTLN;
  sx1272._nodeAddress = loraAddr;
//  FLUSHOUTPUT;
  delay(1000);
  lastDownTime = millis();
}

void loop(void) {
  int i = 0, e;
  int cmdValue;
  receivedFromSerial = false;
  receivedFromLoRa   = false;
  if (radioON && !receivedFromSerial) {
    e = 1;
    while(e) e = sx1272.receivePacketTimeout(MAX_TIMEOUT);PRINT_CSTSTR("%s", "Receive:    ") ;PRINT_VALUE("%d", e);PRINTLN;                                                      
    if (!e && sx1272._requestACK_indicator) {
      PRINT_CSTSTR("%s", "^$ACK requested by ");PRINT_VALUE("%d", sx1272.packet_received.src);PRINTLN;FLUSHOUTPUT;
    }
    
    if (!e) {
      int a = 0, b = 0;
      uint8_t tmp_length;
      receivedFromLoRa      = true;
      lastDownTime = millis();
      if (!optNDL)
        enableDownlinkCheck = true;
      char time_buffer[30];
      int millisec;
      struct tm *tm_info;
      struct timeval tv;
      gettimeofday(&tv, NULL);
      millisec = lrint(tv.tv_usec / 1000.0);
      if (millisec >= 1000) {
        millisec -= 1000;
        tv.tv_sec++;
      }
      tm_info = localtime(&tv.tv_sec);
      tmp_length = sx1272.getPayloadLength();
      sx1272.getSNR();
      sx1272.getRSSIpacket();
      sprintf(cmd, "--- rxlora. dst=%d type=0x%02X src=%d seq=%d", sx1272.packet_received.dst, sx1272.packet_received.type, sx1272.packet_received.src, sx1272.packet_received.packnum);
      PRINT_STR("%s", cmd);
      sprintf(cmd, " len=%d SNR=%d RSSIpkt=%d BW=%d CR=4/%d SF=%d\n", tmp_length, sx1272._SNR, sx1272._RSSIpacket, (sx1272._bandwidth == BW_125) ? 125 : ((sx1272._bandwidth == BW_250) ? 250 : 500), sx1272._codingRate + 4, sx1272._spreadingFactor);
      PRINT_STR("%s", cmd);
      sprintf(cmd, "^p%d,%d,%d,%d,", sx1272.packet_received.dst, sx1272.packet_received.type, sx1272.packet_received.src, sx1272.packet_received.packnum);
      PRINT_STR("%s", cmd);
      sprintf(cmd, "%d,%d,%d\n", tmp_length, sx1272._SNR, sx1272._RSSIpacket);
      PRINT_STR("%s", cmd);
      sprintf(cmd, "^r%d,%d,%d,%ld\n", (sx1272._bandwidth == BW_125) ? 125 : ((sx1272._bandwidth == BW_250) ? 250 : 500), sx1272._codingRate + 4, sx1272._spreadingFactor, (uint32_t)(optFQ * 1000.0));
      PRINT_STR("%s", cmd);
      strftime(time_buffer, 30, "%Y-%m-%dT%H:%M:%S", tm_info);
      sprintf(cmd, "^t%s.%03d\n", time_buffer, millisec);
      PRINT_STR("%s", cmd);
    }
  }
}
int main(int argc, char *argv[]) {
  int opt = 0;
  static struct option long_options[] = {
    {"mode",required_argument,0,'a'},
    {"aes" ,no_argument      ,0,'b'},
    {"bw"  ,required_argument,0,'c'},
    {"cr"  ,required_argument,0,'d'},
    {"sf"  ,required_argument,0,'e'},
    {"raw" ,no_argument      ,0,'f'},
    {"freq",required_argument,0,'g'},
    {"ch"  ,required_argument,0,'h'},
    {"sw"  ,required_argument,0,'i'},
    {"ndl" ,no_argument      ,0,'j'},
    {"hex" ,no_argument      ,0,'k'},
    {0     ,0                ,0, 0 }
  };
  int long_index = 0;
  while ((opt = getopt_long(argc, argv, "a:bc:d:e:fg:h:i:jk", long_options, &long_index)) != -1) {
    switch (opt) {
    case 'a':
      loraMode = atoi(optarg);
      break;
    case 'b':
      optAESgw = true;
      break;
    case 'c':
      optBW = atoi(optarg);
      break;
    case 'd':
      optCR = atoi(optarg);
      break;
    case 'e':
      optSF = atoi(optarg);
      break;
    case 'f':
      optRAW = true;
      break;
    case 'g':
      optFQ = atof(optarg);
      optCH = optFQ * 1000000.0 * RH_LORA_FCONVERT;
      break;
    case 'i': {
      uint8_t sw = atoi(optarg);
      optSW = (sw / 10) * 16 + (sw % 10);
    } break;
    case 'j':
      optNDL = true;
      break;
    case 'k':
      optHEX = true;
      break;
    }
  }
  setup();
  while (1) {
    loop();
  }
  return (0);
}

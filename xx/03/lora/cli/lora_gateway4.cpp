
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

#define ENDING_CHANNEL 18
#define GW_AUTO_ACK
#define LORA_ADDR 1
#define LORAMODE 1
#define MAX_CMD_LENGTH 100
#define MAX_DBM 14
#define MAX_NB_CHANNEL 15
#define STARTING_CHANNEL 4

#define PRINT_CSTSTR(fmt, param) printf(fmt, param)
#define PRINT_HEX(fmt, param) PRINT_VALUE(fmt, param)
#define PRINTLN printf("\n")
#define PRINT_STR(fmt, param) PRINT_CSTSTR(fmt, param)
#define PRINT_VALUE(fmt, param) PRINT_CSTSTR(fmt, param)
#define FLUSHOUTPUT fflush(stdout);
//#define DATA_PREFIX_0 0xFF
//#define DATA_PREFIX_1 0xFE
//#define MAX_DOWNLINK_ENTRY 100
//#define UNLOCK_PIN 1234

uint32_t loraChannelArray[MAX_NB_CHANNEL] = {CH_04_868, CH_05_868, CH_06_868, CH_07_868, CH_08_868, CH_09_868, CH_10_868, CH_11_868, CH_12_868, CH_13_868, CH_14_868, CH_15_868, CH_16_868, CH_17_868, CH_18_868};
bool receivedFromLoRa      = false;
bool receivedFromSerial    = false;
bool enableDownlinkCheck   = false;
bool optAESgw              = false;
bool optHEX                = false;
bool optNDL                = false;
bool optRAW                = false;
bool radioON               = false;
double optFQ               = -1.0;
int status_counter         = 0;
uint16_t optBW             = 250;
uint8_t loraAddr           = LORA_ADDR;
uint8_t loraChannelIndex   = 6;
uint8_t loraMode           = LORAMODE;
uint8_t optCH              = 0;
uint8_t optCR              = 5;
uint8_t optSF              = 7;
uint8_t optSW              = 0x12;
unsigned long lastDownTime = 0;
uint32_t loraChannel       = loraChannelArray[loraChannelIndex];
char cmd[MAX_CMD_LENGTH]   = "****************";

//bool unlocked              = false;
//bool withAck               = false;
//bool extendedIFS           = true;
//bool hasDownlinkEntry      = false;
//bool RSSIonSend            = true;
//char loraPower             = 'M';
//int msg_sn                 = 0;
//size_t json_entry_size     = 100;
//uint8_t CAD_value[11]      = {0, 62, 31, 16, 16, 8, 9, 5, 3, 1, 1};
//uint8_t keyIndex           = 0;
//uint8_t send_cad_number    = 3;
//uint8_t SIFS_value[11]     = {0, 183, 94, 44, 47, 23, 24, 12, 12, 7, 4};
//uint8_t unlocked_try       = 3;
//char *json_entry[MAX_DOWNLINK_ENTRY];
//ssize_t dl_line_size;
//unsigned long startDoCad,  endDoCad;
//uint8_t SIFS_cad_number;
//char keyPressBuff[30];
//FILE *fp;
//int ch;
//int dl_line_index;
//int dl_total_line;

using namespace rapidjson;
using namespace std;

void setup() {
  int e;
  e = sx1272.ON();
  radioON = true;
  e = sx1272.setCR(optCR - 4);
  e = sx1272.setSF(optSF);
  e = sx1272.setBW((optBW == 125) ? BW_125 : ((optBW == 250) ? BW_250 : BW_500));
  e = sx1272.setChannel(loraChannel); //optFQ = loraChannel / (1000000.0 * RH_LORA_FCONVERT);
  e = sx1272.setPowerDBM((uint8_t)MAX_DBM);
  e = sx1272.getPreambleLength();
  sx1272.setPreambleLength(8);
  e = sx1272.getPreambleLength();
  sx1272._nodeAddress = loraAddr;
  e = 0;
  e = sx1272.getSyncWord();
  e = sx1272.setSyncWord(optSW); //if (optSW != 0x12) 
  FLUSHOUTPUT;
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
    if (status_counter == 60 || status_counter == 0) {
      PRINT_CSTSTR("%s", "^$Low-level gw status ON");
      PRINTLN;
      FLUSHOUTPUT;
      status_counter = 0;
    }
    
    e = sx1272.receivePacketTimeout(MAX_TIMEOUT);
    status_counter++;
    if (e != 0 && e != 3) {
      PRINT_CSTSTR("%s", "^$Receive error ");
      PRINT_VALUE("%d", e);
      PRINTLN;
      FLUSHOUTPUT;
    }
    if (!e && sx1272._requestACK_indicator) {
      PRINT_CSTSTR("%s", "^$ACK requested by ");
      PRINT_VALUE("%d", sx1272.packet_received.src);
      PRINTLN;
      FLUSHOUTPUT;
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
      loraChannel = optFQ * 1000000.0 * RH_LORA_FCONVERT;
      break;
    case 'h':
      optCH = true;
      loraChannelIndex = atoi(optarg);
      if (loraChannelIndex < STARTING_CHANNEL || loraChannelIndex > ENDING_CHANNEL)
        loraChannelIndex = STARTING_CHANNEL;
      loraChannelIndex = loraChannelIndex - STARTING_CHANNEL;
      loraChannel = loraChannelArray[loraChannelIndex];
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

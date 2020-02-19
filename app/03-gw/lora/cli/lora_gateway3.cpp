
#include "lib/SX1272.h"

#define MAX_DBM 14
#include <getopt.h>
#include <math.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <termios.h>
#include <time.h>
#include <unistd.h>
#define PRINTLN printf("\n")
#define PRINT_CSTSTR(fmt, param) printf(fmt, param)
#define PRINT_STR(fmt, param) PRINT_CSTSTR(fmt, param)
#define PRINT_VALUE(fmt, param) PRINT_CSTSTR(fmt, param)
#define PRINT_HEX(fmt, param) PRINT_VALUE(fmt, param)
#define FLUSHOUTPUT fflush(stdout);

#ifdef DEBUG
#define DEBUGLN PRINTLN
#define DEBUG_CSTSTR(fmt, param) PRINT_CSTSTR(fmt, param)
#define DEBUG_STR(fmt, param) PRINT_CSTSTR(fmt, param)
#define DEBUG_VALUE(fmt, param) PRINT_VALUE(fmt, param)
#else
#define DEBUGLN
#define DEBUG_CSTSTR(fmt, param)
#define DEBUG_STR(fmt, param)
#define DEBUG_VALUE(fmt, param)
#endif

#define MAX_DOWNLINK_ENTRY 100
#include "lib/rapidjson/document.h"
#include "lib/rapidjson/reader.h"
#include "lib/rapidjson/stringbuffer.h"
#include "lib/rapidjson/writer.h"
#include <iostream>
using namespace rapidjson;
using namespace std;
char *json_entry[MAX_DOWNLINK_ENTRY];
size_t json_entry_size = 100;
FILE *fp;
int dl_line_index;
ssize_t dl_line_size;
int dl_total_line;
bool hasDownlinkEntry = false;
bool enableDownlinkCheck = false;
bool optNDL = false;
unsigned long lastDownlinkCheckTime = 0;
unsigned long interDownlinkCheckTime = 5000L;
unsigned long lastDownlinkSendTime = 0;
unsigned long interDownlinkSendTime = 20000L;

#define MAX_NB_CHANNEL 15
#define STARTING_CHANNEL 4
#define ENDING_CHANNEL 18

uint8_t loraChannelIndex = 6; //0
uint32_t loraChannelArray[MAX_NB_CHANNEL] = {CH_04_868, CH_05_868, CH_06_868, CH_07_868, CH_08_868, CH_09_868, CH_10_868, CH_11_868, CH_12_868, CH_13_868, CH_14_868, CH_15_868, CH_16_868, CH_17_868, CH_18_868};

#define GW_AUTO_ACK
#define LORAMODE 1
#define LORA_ADDR 1
#define UNLOCK_PIN 1234
#define DATA_PREFIX_0 0xFF
#define DATA_PREFIX_1 0xFE

char keyPressBuff[30];
uint8_t keyIndex = 0;
int ch;
#define MAX_CMD_LENGTH 100
char cmd[MAX_CMD_LENGTH]   = "****************";
int msg_sn                 = 0;
uint8_t unlocked_try       = 3;
boolean unlocked           = false;
boolean receivedFromSerial = false;
boolean receivedFromLoRa   = false;
boolean withAck            = false;
bool radioON               = false;
bool RSSIonSend            = true;
uint8_t loraMode           = LORAMODE;
uint32_t loraChannel       = loraChannelArray[loraChannelIndex];
char loraPower             = 'M';
uint8_t loraAddr           = LORA_ADDR;
int status_counter         = 0;
unsigned long startDoCad,  endDoCad;
bool extendedIFS           = true;
uint8_t SIFS_cad_number ;
uint8_t send_cad_number    = 3;
uint8_t SIFS_value[11]     = {0, 183, 94, 44, 47, 23, 24, 12, 12, 7, 4};
uint8_t CAD_value[11]      = {0, 62, 31, 16, 16, 8, 9, 5, 3, 1, 1};
bool optAESgw              = false;
uint16_t optBW             = 0;
uint8_t optSF              = 0;
uint8_t optCR              = 0;
uint8_t optCH              = 0;
bool optRAW                = false;
double optFQ               = -1.0;
uint8_t optSW              = 0x12;
bool optHEX                = false;


void startConfig() {
  int e;
  if (optBW != 0 || optCR != 0 || optSF != 0) {
    e = sx1272.setCR(optCR - 4);
    PRINT_CSTSTR("%s", "^$LoRa CR ");
    PRINT_VALUE("%d", optCR);
    PRINT_CSTSTR("%s", ": state ");
    PRINT_VALUE("%d", e);
    PRINTLN;
    e = sx1272.setSF(optSF);
    PRINT_CSTSTR("%s", "^$LoRa SF ");
    PRINT_VALUE("%d", optSF);
    PRINT_CSTSTR("%s", ": state ");
    PRINT_VALUE("%d", e);
    PRINTLN;
    e = sx1272.setBW((optBW == 125) ? BW_125 : ((optBW == 250) ? BW_250 : BW_500));
    PRINT_CSTSTR("%s", "^$LoRa BW ");
    PRINT_VALUE("%d", optBW);
    PRINT_CSTSTR("%s", ": state ");
    PRINT_VALUE("%d", e);
    PRINTLN;
    e = sx1272.setChannel(loraChannel);
    if (optFQ > 0.0) {
      PRINT_CSTSTR("%s", "^$Frequency ");
      PRINT_VALUE("%f", optFQ);
      PRINT_CSTSTR("%s", ": state ");
    } else {
      if (loraChannelIndex > 5) {
        PRINT_CSTSTR("%s", "^$Channel CH_1");
        PRINT_VALUE("%d", loraChannelIndex - 6);
      } else {
        PRINT_CSTSTR("%s", "^$Channel CH_0");
        PRINT_VALUE("%d", loraChannelIndex + STARTING_CHANNEL);
      }
      PRINT_CSTSTR("%s", "_868: state ");
      optFQ = loraChannel / (1000000.0 * RH_LORA_FCONVERT);
    }
  }
  PRINT_VALUE("%d", e);
  PRINTLN;
  e = sx1272.setPowerDBM((uint8_t)MAX_DBM);
  PRINT_CSTSTR("%s", "^$Set LoRa power dBm to ");
  PRINT_VALUE("%d", (uint8_t)MAX_DBM);
  PRINTLN;
  PRINT_CSTSTR("%s", "^$Power: state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
  e = sx1272.getPreambleLength();
  PRINT_CSTSTR("%s", "^$Get Preamble Length: state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
  PRINT_CSTSTR("%s", "^$Preamble Length: ");
  PRINT_VALUE("%d", sx1272._preamblelength);
  PRINTLN;
  if (sx1272._preamblelength != 8) {
    PRINT_CSTSTR("%s", "^$Bad Preamble Length: set back to 8");
    sx1272.setPreambleLength(8);
    e = sx1272.getPreambleLength();
    PRINT_CSTSTR("%s", "^$Get Preamble Length: state ");
    PRINT_VALUE("%d", e);
    PRINTLN;
    PRINT_CSTSTR("%s", "^$Preamble Length: ");
    PRINT_VALUE("%d", sx1272._preamblelength);
    PRINTLN;
  }
  sx1272._nodeAddress = loraAddr;
  e = 0;
  PRINT_CSTSTR("%s", "^$LoRa addr ");
  PRINT_VALUE("%d", loraAddr);
  PRINT_CSTSTR("%s", ": state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
  if (optAESgw)
    PRINT_CSTSTR("%s", "^$Handle AES encrypted data\n");
  if (optRAW) {
    PRINT_CSTSTR("%s", "^$Raw format, not assuming any header in reception\n");
    sx1272._rawFormat = true;
  }
  PRINT_CSTSTR("%s", "^$SX1272/76 configured ");
  PRINT_CSTSTR("%s", "as LR-BS. Waiting RF input for transparent RF-serial bridge\n");
}
void setup() {
  int e;
  e = sx1272.ON();
  PRINT_CSTSTR("%s", "^$**********Power ON: state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
  if (!e) {
    radioON = true;
    startConfig();
  }
  e = sx1272.getSyncWord();
  if (!e) {
    PRINT_CSTSTR("%s", "^$Default sync word: 0x");
    PRINT_HEX("%X", sx1272._syncWord);
    PRINTLN;
  }
  if (optSW != 0x12) {
    e = sx1272.setSyncWord(optSW);
    PRINT_CSTSTR("%s", "^$Set sync word to 0x");
    PRINT_HEX("%X", optSW);
    PRINTLN;
    PRINT_CSTSTR("%s", "^$LoRa sync word: state ");
    PRINT_VALUE("%d", e);
    PRINTLN;
  }
  FLUSHOUTPUT;
  delay(1000);
  lastDownlinkCheckTime = millis();
}

void loop(void) {
  int i = 0, e;
  int cmdValue;
  receivedFromSerial = false;
  receivedFromLoRa = false;
  if (radioON && !receivedFromSerial) {
    e = 1;
    if (status_counter == 60 || status_counter == 0) {
      PRINT_CSTSTR("%s", "^$Low-level gw status ON");
      PRINTLN;
      FLUSHOUTPUT;
      status_counter = 0;
    }
#ifdef RECEIVE_ALL
    e = sx1272.receiveAll(MAX_TIMEOUT);
#else
#ifdef GW_AUTO_ACK
    e = sx1272.receivePacketTimeout(MAX_TIMEOUT);
    status_counter++;
    if (e != 0 && e != 3) {
      PRINT_CSTSTR("%s", "^$Receive error ");
      PRINT_VALUE("%d", e);
      PRINTLN;
      if (e == 2) {
        sx1272.OFF();
        radioON = false;
        PRINT_CSTSTR("%s", "^$Resetting radio module");
        PRINTLN;
        e = sx1272.ON();
        PRINT_CSTSTR("%s", "^$Setting power ON: state ");
        PRINT_VALUE("%d", e);
        PRINTLN;
        if (!e) {
          radioON = true;
          startConfig();
        }
        status_counter = 0;
        e = 1;
      }
      FLUSHOUTPUT;
    }
    if (!e && sx1272._requestACK_indicator) {
      PRINT_CSTSTR("%s", "^$ACK requested by ");
      PRINT_VALUE("%d", sx1272.packet_received.src);
      PRINTLN;
      FLUSHOUTPUT;
    }
#else
    if (withAck)
      e = sx1272.receivePacketTimeoutACK(MAX_TIMEOUT);
    else
      e = sx1272.receivePacketTimeout(MAX_TIMEOUT);
#endif
#endif
    if (!e) {
      int a = 0, b = 0;
      uint8_t tmp_length;
      receivedFromLoRa = true;
      lastDownlinkCheckTime = millis();
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

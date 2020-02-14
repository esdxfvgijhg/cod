
#include "lib/SX1272.h"
#ifdef ARDUINO
#define PABOOST
#endif
#define BAND868
#ifndef MAX_DBM
#define MAX_DBM 14
#endif
#ifndef ARDUINO
#include <getopt.h>
#include <math.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <termios.h>
#include <time.h>
#include <unistd.h>
#endif
#ifdef ARDUINO
#include <SPI.h>
#define PRINTLN Serial.println("")
#define PRINT_CSTSTR(fmt, param) Serial.print(F(param))
#define PRINT_STR(fmt, param) Serial.print(param)
#define PRINT_VALUE(fmt, param) Serial.print(param)
#define PRINT_HEX(fmt, param) Serial.print(param, HEX)
#define FLUSHOUTPUT Serial.flush();
#else
#define PRINTLN printf("\n")
#define PRINT_CSTSTR(fmt, param) printf(fmt, param)
#define PRINT_STR(fmt, param) PRINT_CSTSTR(fmt, param)
#define PRINT_VALUE(fmt, param) PRINT_CSTSTR(fmt, param)
#define PRINT_HEX(fmt, param) PRINT_VALUE(fmt, param)
#define FLUSHOUTPUT fflush(stdout);
#endif
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
#if not defined ARDUINO && defined DOWNLINK
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
int xtoi(const char *hexstring);
#endif
#ifdef BAND868
#define MAX_NB_CHANNEL 15
#define STARTING_CHANNEL 4
#define ENDING_CHANNEL 18
#ifdef SENEGAL_REGULATION
uint8_t loraChannelIndex = 0;
#else
uint8_t loraChannelIndex = 6;
#endif
uint32_t loraChannelArray[MAX_NB_CHANNEL] = {CH_04_868, CH_05_868, CH_06_868, CH_07_868, CH_08_868, CH_09_868, CH_10_868, CH_11_868, CH_12_868, CH_13_868, CH_14_868, CH_15_868, CH_16_868, CH_17_868, CH_18_868};
#elif defined BAND900
#define MAX_NB_CHANNEL 13
#define STARTING_CHANNEL 0
#define ENDING_CHANNEL 12
uint8_t loraChannelIndex = 5;
uint32_t loraChannelArray[MAX_NB_CHANNEL] = {CH_00_900, CH_01_900, CH_02_900, CH_03_900, CH_04_900, CH_05_900, CH_06_900, CH_07_900, CH_08_900, CH_09_900, CH_10_900, CH_11_900, CH_12_900};
#elif defined BAND433
#define MAX_NB_CHANNEL 4
#define STARTING_CHANNEL 0
#define ENDING_CHANNEL 3
uint8_t loraChannelIndex = 0;
uint32_t loraChannelArray[MAX_NB_CHANNEL] = {CH_00_433, CH_01_433, CH_02_433, CH_03_433};
#endif
#define GW_AUTO_ACK
#define LORAMODE 1
#define LORA_ADDR 1
#define UNLOCK_PIN 1234
#define WITH_DATA_PREFIX
#ifdef WITH_DATA_PREFIX
#define DATA_PREFIX_0 0xFF
#define DATA_PREFIX_1 0xFE
#endif
#ifdef LORA_LAS
#include "LoRaActivitySharing.h"
LASBase loraLAS = LASBase();
#endif
#ifndef ARDUINO
char keyPressBuff[30];
uint8_t keyIndex = 0;
int ch;
#endif
#define MAX_CMD_LENGTH 100
char cmd[MAX_CMD_LENGTH] = "****************";
int msg_sn = 0;
uint8_t unlocked_try = 3;
boolean unlocked = false;
boolean receivedFromSerial = false;
boolean receivedFromLoRa = false;
boolean withAck = false;
bool radioON = false;
bool RSSIonSend = true;
uint8_t loraMode = LORAMODE;
uint32_t loraChannel = loraChannelArray[loraChannelIndex];
#if defined PABOOST || defined RADIO_RFM92_95 || defined RADIO_INAIR9B || defined RADIO_20DBM
char loraPower = 'x';
#else
char loraPower = 'M';
#endif
uint8_t loraAddr = LORA_ADDR;
int status_counter = 0;
unsigned long startDoCad, endDoCad;
bool extendedIFS = true;
uint8_t SIFS_cad_number;
uint8_t send_cad_number = 3;
uint8_t SIFS_value[11] = {0, 183, 94, 44, 47, 23, 24, 12, 12, 7, 4};
uint8_t CAD_value[11] = {0, 62, 31, 16, 16, 8, 9, 5, 3, 1, 1};
bool optAESgw = false;
uint16_t optBW = 0;
uint8_t optSF = 0;
uint8_t optCR = 0;
uint8_t optCH = 0;
bool optRAW = false;
double optFQ = -1.0;
uint8_t optSW = 0x12;
bool optHEX = false;
#if defined ARDUINO && defined SHOW_FREEMEMORY && not defined __MK20DX256__ && not defined __MKL26Z64__ && not defined __SAMD21G18A__ && not defined _VARIANT_ARDUINO_DUE_X_
int freeMemory() {
  extern int __heap_start, *__brkval;
  int v;
  return (int)&v - (__brkval == 0 ? (int)&__heap_start : (int)__brkval);
}
#endif
long getCmdValue(int &i, char *strBuff = NULL) {
  char seqStr[7] = "******";
  int j = 0;
  while ((char)cmd[i] != '#' && (i < strlen(cmd)) && j < strlen(seqStr)) {
    seqStr[j] = (char)cmd[i];
    i++;
    j++;
  }
  seqStr[j] = '\0';
  if (strBuff) {
    strcpy(strBuff, seqStr);
  } else
    return (atol(seqStr));
}
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
    if (optSF < 10)
      SIFS_cad_number = 6;
    else
      SIFS_cad_number = 3;
  } else {
    PRINT_CSTSTR("%s", "^$LoRa mode ");
    PRINT_VALUE("%d", loraMode);
    PRINTLN;
    e = sx1272.setMode(loraMode);
    PRINT_CSTSTR("%s", "^$Setting mode: state ");
    PRINT_VALUE("%d", e);
    PRINTLN;
#ifdef LORA_LAS
    loraLAS.setSIFS(loraMode);
#endif
    if (loraMode > 7)
      SIFS_cad_number = 6;
    else
      SIFS_cad_number = 3;
  }
  if (loraMode == 11) {
    PRINT_CSTSTR("%s", "^$Configuring for LoRaWAN\n");
    if (optFQ < 0.0) {
#ifdef BAND868
      e = sx1272.setChannel(CH_18_868);
      optFQ = 868.1;
      PRINT_CSTSTR("%s", "^$Set frequency to 868.1MHz: state ");
#elif defined BAND900
      optFQ = 923.2;
      loraChannel = optFQ * 1000000.0 * RH_LORA_FCONVERT;
      e = sx1272.setChannel(loraChannel);
      PRINT_CSTSTR("%s", "^$Set frequency to 923.2MHz: state ");
#elif defined BAND433
      optFQ = 433.175;
      loraChannel = optFQ * 1000000.0 * RH_LORA_FCONVERT;
      e = sx1272.setChannel(loraChannel);
      PRINT_CSTSTR("%s", "^$Set frequency to 433.175MHz: state ");
#endif
    } else {
      PRINT_CSTSTR("%s", "^$Frequency ");
      PRINT_VALUE("%f", optFQ);
      PRINT_CSTSTR("%s", ": state ");
    }
    optRAW = true;
    optSW = 0x34;
  } else {
    e = sx1272.setChannel(loraChannel);
    if (optFQ > 0.0) {
      PRINT_CSTSTR("%s", "^$Frequency ");
      PRINT_VALUE("%f", optFQ);
      PRINT_CSTSTR("%s", ": state ");
    } else {
#ifdef BAND868
      if (loraChannelIndex > 5) {
        PRINT_CSTSTR("%s", "^$Channel CH_1");
        PRINT_VALUE("%d", loraChannelIndex - 6);
      } else {
        PRINT_CSTSTR("%s", "^$Channel CH_0");
        PRINT_VALUE("%d", loraChannelIndex + STARTING_CHANNEL);
      }
      PRINT_CSTSTR("%s", "_868: state ");
#elif defined BAND900
      PRINT_CSTSTR("%s", "^$Channel CH_");
      PRINT_VALUE("%d", loraChannelIndex);
      PRINT_CSTSTR("%s", "_900: state ");
#elif defined BAND433
      PRINT_CSTSTR("%s", "^$Channel CH_");
      PRINT_VALUE("%d", loraChannelIndex);
      PRINT_CSTSTR("%s", "_433: state ");
#endif
      optFQ = loraChannel / (1000000.0 * RH_LORA_FCONVERT);
    }
  }
  PRINT_VALUE("%d", e);
  PRINTLN;
#ifdef PABOOST
  sx1272._needPABOOST = true;
  PRINT_CSTSTR("%s", "^$Use PA_BOOST amplifier line");
  PRINTLN;
#else
#endif
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
#if defined ARDUINO && defined GW_RELAY
  PRINT_CSTSTR("%s", "^$Act as a simple relay gateway\n");
#endif
}
void setup() {
  int e;
#ifdef ARDUINO
  delay(3000);
  randomSeed(analogRead(14));
#ifdef __SAMD21G18A__
  SerialUSB.begin(38400);
#else
  Serial.begin(38400);
#endif
#if defined ARDUINO && defined SHOW_FREEMEMORY && not defined __MK20DX256__ && not defined __MKL26Z64__ && not defined __SAMD21G18A__ && not defined _VARIANT_ARDUINO_DUE_X_
  Serial.print(freeMemory());
  Serial.println(F(" bytes of free memory."));
#endif
#else
  srand(time(NULL));
#endif
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
#ifdef LORA_LAS
  loraLAS.ON(LAS_ON_WRESET);
#endif
#ifdef CAD_TEST
  PRINT_CSTSTR("%s", "Do CAD test\n");
#endif
#if not defined ARDUINO && defined DOWNLINK
  lastDownlinkCheckTime = millis();
#endif
}
int CarrierSense(bool onlyOnce = false) {
  int e;
  bool carrierSenseRetry = false;
  if (send_cad_number) {
    do {
      do {
        startDoCad = millis();
        e = sx1272.doCAD(send_cad_number);
        endDoCad = millis();
        PRINT_CSTSTR("%s", "--> CAD duration ");
        PRINT_VALUE("%ld", endDoCad - startDoCad);
        PRINTLN;
        if (!e) {
          PRINT_CSTSTR("%s", "OK1\n");
          if (extendedIFS) {
#ifdef ARDUINO
            uint8_t w = random(1, 8);
#else
            uint8_t w = rand() % 8 + 1;
#endif
            PRINT_CSTSTR("%s", "--> waiting for ");
            PRINT_VALUE("%d", w);
            PRINT_CSTSTR("%s", " CAD = ");
            PRINT_VALUE("%d", CAD_value[loraMode] * w);
            PRINTLN;
            delay(CAD_value[loraMode] * w);
            startDoCad = millis();
            e = sx1272.doCAD(send_cad_number);
            endDoCad = millis();
            PRINT_CSTSTR("%s", "--> CAD duration ");
            PRINT_VALUE("%ld", endDoCad - startDoCad);
            PRINTLN;
            if (!e)
              PRINT_CSTSTR("%s", "OK2");
            else
              PRINT_CSTSTR("%s", "###2");
            PRINTLN;
          }
        } else {
          PRINT_CSTSTR("%s", "###1\n");
          if (onlyOnce)
            return 1;
#ifdef ARDUINO
          uint8_t w = random(1, 8);
#else
          uint8_t w = rand() % 8 + 1;
#endif
          PRINT_CSTSTR("%s", "--> waiting for ");
          PRINT_VALUE("%d", w);
          PRINT_CSTSTR("%s", " DIFS (DIFS=3SIFS) = ");
          PRINT_VALUE("%d", SIFS_value[loraMode] * 3 * w);
          PRINTLN;
          delay(SIFS_value[loraMode] * 3 * w);
          PRINT_CSTSTR("%s", "--> retry\n");
        }
      } while (e);
      if (RSSIonSend) {
        e = sx1272.getRSSI();
        uint8_t rssi_retry_count = 10;
        if (!e) {
          PRINT_CSTSTR("%s", "--> RSSI ");
          PRINT_VALUE("%d", sx1272._RSSI);
          PRINTLN;
          while (sx1272._RSSI > -90 && rssi_retry_count) {
            delay(1);
            sx1272.getRSSI();
            PRINT_CSTSTR("%s", "--> RSSI ");
            PRINT_VALUE("%d", sx1272._RSSI);
            PRINTLN;
            rssi_retry_count--;
          }
        } else
          PRINT_CSTSTR("%s", "--> RSSI error\n");
        if (!rssi_retry_count)
          carrierSenseRetry = true;
        else
          carrierSenseRetry = false;
      }
    } while (carrierSenseRetry);
  }
  return 0;
}
void loop(void) {
  int i = 0, e;
  int cmdValue;
#ifdef CAD_TEST
  startDoCad = millis();
  e = sx1272.doCAD(SIFS_cad_number);
  endDoCad = millis();
  PRINT_CSTSTR("%s", "--> SIFS duration ");
  PRINT_VALUE("%ld", endDoCad - startDoCad);
  PRINTLN;
  if (!e)
    PRINT_CSTSTR("%s", "OK");
  else
    PRINT_CSTSTR("%s", "###");
  PRINTLN;
  delay(200);
  startDoCad = millis();
  e = sx1272.doCAD(SIFS_cad_number * 3);
  endDoCad = millis();
  PRINT_CSTSTR("%s", "--> DIFS duration ");
  PRINT_VALUE("%ld", endDoCad - startDoCad);
  PRINTLN;
  if (!e)
    PRINT_CSTSTR("%s", "OK");
  else
    PRINT_CSTSTR("%s", "###");
  PRINTLN;
  delay(200);
#endif
  receivedFromSerial = false;
  receivedFromLoRa = false;
#ifdef LORA_LAS
  loraLAS.checkCycle();
#endif
#if defined ARDUINO && not defined GW_RELAY
  if (Serial.available()) {
    i = 0;
    while (Serial.available() && i < 80) {
      cmd[i] = Serial.read();
      i++;
      delay(50);
    }
    cmd[i] = '\0';
    PRINT_CSTSTR("%s", "Rcv serial: ");
    PRINT_STR("%s", cmd);
    PRINTLN;
    receivedFromSerial = true;
  }
#endif
#if not defined ARDUINO && defined WINPUT
  while (unistd::read(0, &ch, 1)) {
    if (ch == '\n') {
      strcpy(cmd, keyPressBuff);
      PRINT_CSTSTR("%s", "Cmd from keyboard: ");
      PRINT_STR("%s", cmd);
      PRINTLN;
      keyIndex = 0;
      receivedFromSerial = true;
    } else {
      if (ch == 127 || ch == 8) {
        keyIndex--;
      } else {
        keyPressBuff[keyIndex] = (char)ch;
        keyIndex++;
      }
    }
    keyPressBuff[keyIndex] = '\0';
    PRINT_CSTSTR("%s", "keyboard input : ");
    PRINT_STR("%s", keyPressBuff);
    PRINTLN;
  }
#endif
  if (radioON && !receivedFromSerial) {
    e = 1;
#ifndef CAD_TEST
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
#endif
    if (!e) {
      int a = 0, b = 0;
      uint8_t tmp_length;
      receivedFromLoRa = true;
#if not defined ARDUINO && defined DOWNLINK
      lastDownlinkCheckTime = millis();
      if (!optNDL)
        enableDownlinkCheck = true;
#endif
#if not defined ARDUINO && not defined GW_RELAY
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
#endif
      tmp_length = sx1272.getPayloadLength();
#if not defined GW_RELAY
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
#endif
#if not defined ARDUINO && not defined GW_RELAY
      strftime(time_buffer, 30, "%Y-%m-%dT%H:%M:%S", tm_info);
      sprintf(cmd, "^t%s.%03d\n", time_buffer, millisec);
      PRINT_STR("%s", cmd);
#endif
#ifdef LORA_LAS
      if (loraLAS.isLASMsg(sx1272.packet_received.data)) {
        tmp_length = sx1272.getPayloadLength();
        int v = loraLAS.handleLASMsg(sx1272.packet_received.src, sx1272.packet_received.data, tmp_length);
        if (v == DSP_DATA) {
          a = LAS_DSP + DATA_HEADER_LEN + 1;
#ifdef WITH_DATA_PREFIX
          PRINT_STR("%c", (char)DATA_PREFIX_0);
          PRINT_STR("%c", (char)DATA_PREFIX_1);
#endif
        } else
          a = tmp_length;
      } else
        PRINT_CSTSTR("%s", "No LAS header. Write raw data\n");
#else
#if defined WITH_DATA_PREFIX && not defined GW_RELAY
      PRINT_STR("%c", (char)DATA_PREFIX_0);
      PRINT_STR("%c", (char)DATA_PREFIX_1);
#endif
#endif
#if defined ARDUINO && defined GW_RELAY
      sx1272._nodeAddress = sx1272.packet_received.src;
      sx1272._packetNumber = sx1272.packet_received.packnum;
      sx1272.setPacketType(sx1272.packet_received.type);
      CarrierSense();
      e = sx1272.sendPacketTimeout(1, sx1272.packet_received.data, tmp_length, 10000);
      PRINT_CSTSTR("%s", "Packet re-sent, state ");
      PRINT_VALUE("%d", e);
      PRINTLN;
      sx1272._nodeAddress = loraAddr;
#else
      FLUSHOUTPUT;
      for (; a < tmp_length; a++, b++) {
        if (optHEX) {
          if ((uint8_t)sx1272.packet_received.data[a] < 16)
            PRINT_CSTSTR("%s", "0");
          PRINT_HEX("%X", (uint8_t)sx1272.packet_received.data[a]);
          PRINT_CSTSTR("%s", " ");
        } else
          PRINT_STR("%c", (char)sx1272.packet_received.data[a]);
        if (b < MAX_CMD_LENGTH)
          cmd[b] = (char)sx1272.packet_received.data[a];
      }
      cmd[b] = '\0';
      PRINTLN;
      FLUSHOUTPUT;
#if not defined ARDUINO && defined WINPUT
      if (keyIndex) {
        PRINT_CSTSTR("%s", "keyboard input : ");
        PRINT_STR("%s", keyPressBuff);
        PRINTLN;
      }
#endif
#endif
    }
  }
  if (receivedFromSerial || receivedFromLoRa) {
    i = 0;
    if (cmd[i] == '/' && cmd[i + 1] == '@') {
      PRINT_CSTSTR("%s", "^$Parsing command\n");
      i = 2;
      PRINT_CSTSTR("%s", "^$");
      PRINT_STR("%s", cmd);
      PRINTLN;
      if ((receivedFromLoRa && cmd[i] != 'U' && !unlocked) || !unlocked_try) {
        PRINT_CSTSTR("%s", "^$Remote config locked\n");
        cmd[i] = '*';
      }
      switch (cmd[i]) {
#ifdef ENABLE_REMOTE
      case 'U':
        if (unlocked_try) {
          i++;
          cmdValue = getCmdValue(i);
          if (cmdValue == UNLOCK_PIN) {
            unlocked = !unlocked;
            if (unlocked)
              PRINT_CSTSTR("%s", "^$Unlocked\n");
            else
              PRINT_CSTSTR("%s", "^$Locked\n");
          } else
            unlocked_try--;
          if (unlocked_try == 0)
            PRINT_CSTSTR("%s", "^$Bad pin\n");
        }
        break;
#endif
      case 'S':
        if (cmd[i + 1] == 'F') {
          i = i + 2;
          cmdValue = getCmdValue(i);
          if (cmdValue > 5 && cmdValue < 13) {
            PRINT_CSTSTR("%s", "^$set SF: ");
            PRINT_VALUE("%d", cmdValue);
            PRINTLN;
            e = sx1272.setSF(cmdValue);
            PRINT_CSTSTR("%s", "^$set SF: state ");
            PRINT_VALUE("%d", e);
            PRINTLN;
          }
        }
        break;
      case 'M':
        i++;
        cmdValue = getCmdValue(i);
        if (cmdValue > 11)
          cmdValue = 4;
        if (cmdValue < 0)
          cmdValue = 4;
        loraMode = cmdValue;
        PRINT_CSTSTR("%s", "^$Set LoRa mode to ");
        PRINT_VALUE("%d", loraMode);
        PRINTLN;
        e = sx1272.setMode(loraMode);
        PRINT_CSTSTR("%s", "^$LoRa mode: state ");
        PRINT_VALUE("%d", e);
        PRINTLN;
#ifdef LORA_LAS
        loraLAS.setSIFS(loraMode);
#endif
        e = sx1272.getPreambleLength();
        PRINT_CSTSTR("%s", "Get Preamble Length: state ");
        PRINT_VALUE("%d", e);
        PRINTLN;
        PRINT_CSTSTR("%s", "Preamble Length: ");
        PRINT_VALUE("%d", sx1272._preamblelength);
        PRINTLN;
        break;
      case 'W':
        i++;
        cmdValue = getCmdValue(i);
        cmdValue = (cmdValue / 10) * 16 + (cmdValue % 10);
        if (cmdValue > 255)
          cmdValue = 0x12;
        if (cmdValue <= 0)
          cmdValue = 0x12;
        PRINT_CSTSTR("%s", "^$Set sync word to 0x");
        PRINT_HEX("%X", cmdValue);
        PRINTLN;
        e = sx1272.setSyncWord(cmdValue);
        PRINT_CSTSTR("%s", "^$LoRa sync word: state ");
        PRINT_VALUE("%d", e);
        PRINTLN;
        break;
      case 'C':
        if (cmd[i + 1] == 'A' && cmd[i + 2] == 'D') {
          if (cmd[i + 3] == 'O' && cmd[i + 4] == 'N') {
            i = i + 5;
            cmdValue = getCmdValue(i);
            if (cmdValue > 255)
              cmdValue = 255;
            send_cad_number = cmdValue;
            PRINT_CSTSTR("%s", "Set send_cad_number to ");
            PRINT_VALUE("%d", send_cad_number);
            PRINTLN;
            break;
          }
          if (cmd[i + 3] == 'O' && cmd[i + 4] == 'F' && cmd[i + 5] == 'F') {
            send_cad_number = 0;
            break;
          }
          startDoCad = millis();
          e = sx1272.doCAD(SIFS_cad_number);
          endDoCad = millis();
          PRINT_CSTSTR("%s", "--> SIFS duration ");
          PRINT_VALUE("%ld", endDoCad - startDoCad);
          PRINTLN;
          if (!e)
            PRINT_CSTSTR("%s", "OK");
          else
            PRINT_CSTSTR("%s", "###");
          PRINTLN;
        } else {
          i++;
          cmdValue = getCmdValue(i);
          if (cmdValue < STARTING_CHANNEL || cmdValue > ENDING_CHANNEL)
            loraChannelIndex = STARTING_CHANNEL;
          else
            loraChannelIndex = cmdValue;
          loraChannelIndex = loraChannelIndex - STARTING_CHANNEL;
          loraChannel = loraChannelArray[loraChannelIndex];
          PRINT_CSTSTR("%s", "^$Set LoRa channel to ");
          PRINT_VALUE("%d", cmdValue);
          PRINTLN;
          e = sx1272.setChannel(loraChannel);
          PRINT_CSTSTR("%s", "^$Setting Channel: state ");
          PRINT_VALUE("%d", e);
          PRINTLN;
          PRINT_CSTSTR("%s", "Time: ");
          PRINT_VALUE("%d", sx1272._stoptime - sx1272._starttime);
          PRINTLN;
        }
        break;
      case 'P':
        if (cmd[i + 1] == 'L' || cmd[i + 1] == 'H' || cmd[i + 1] == 'M' || cmd[i + 1] == 'x' || cmd[i + 1] == 'X') {
          loraPower = cmd[i + 1];
          PRINT_CSTSTR("%s", "^$Set LoRa Power to ");
          PRINT_VALUE("%c", loraPower);
          PRINTLN;
          e = sx1272.setPower(loraPower);
          PRINT_CSTSTR("%s", "^$Setting Power: state ");
          PRINT_VALUE("%d", e);
          PRINTLN;
        } else
          PRINT_CSTSTR("%s", "Invalid Power. L, H, M, x or X accepted.\n");
        break;
      case 'O':
        if (cmd[i + 1] == 'N') {
          PRINT_CSTSTR("%s", "^$Setting LoRa module to ON");
          e = sx1272.ON();
          PRINT_CSTSTR("%s", "^$Setting power ON: state ");
          PRINT_VALUE("%d", e);
          PRINTLN;
          if (!e) {
            radioON = true;
            startConfig();
          }
          delay(500);
        } else if (cmd[i + 1] == 'F' && cmd[i + 2] == 'F') {
          PRINT_CSTSTR("%s", "^$Setting LoRa module to OFF\n");
          sx1272.OFF();
          radioON = false;
        } else
          PRINT_CSTSTR("%s", "Invalid command. ON or OFF accepted.\n");
        break;
#ifdef LORA_LAS
      case 'L':
        if (cmd[i + 1] == 'A' && cmd[i + 2] == 'S') {
          if (cmd[i + 3] == 'S')
            loraLAS.showLAS();
          if (cmd[i + 3] == 'R') {
            loraLAS.reset();
            loraLAS.showLAS();
          }
          if (cmd[i + 3] == 'O' && cmd[i + 4] == 'N')
            loraLAS.ON(LAS_ON_NORESET);
          if (cmd[i + 3] == 'O' && cmd[i + 4] == 'F' && cmd[i + 5] == 'F')
            loraLAS.OFF();
          if (cmd[i + 3] == 'I') {
            loraLAS.sendInit(LAS_INIT_RESTART);
          }
        }
        break;
#endif
      default:
        PRINT_CSTSTR("%s", "Unrecognized cmd\n");
        break;
      }
      FLUSHOUTPUT;
    }
  }
#if not defined ARDUINO && defined DOWNLINK
  else {
    bool triggerDownlinkCheck = false;
    if (millis() - lastDownlinkCheckTime < 0) {
      if (millis() + ULONG_MAX - lastDownlinkCheckTime > interDownlinkCheckTime)
        triggerDownlinkCheck = true;
    }
    if ((millis() - lastDownlinkCheckTime > interDownlinkCheckTime || triggerDownlinkCheck) && enableDownlinkCheck) {
      char time_buffer[30];
      int millisec;
      struct tm *tm_info;
      struct timeval tv;
      gettimeofday(&tv, NULL);
      tm_info = localtime(&tv.tv_sec);
      strftime(time_buffer, 30, "%Y-%m-%dT%H:%M:%S", tm_info);
      printf("^$-----------------------------------------------------\n");
      printf("^$Check for downlink requests %s\n", time_buffer);
      fp = fopen("downlink/downlink.txt", "r");
      if (fp) {
        fclose(fp);
        system("sed -i 's/\r//g' downlink/downlink.txt");
        system("sed -i '/^$/d' downlink/downlink.txt");
        fp = fopen("downlink/downlink.txt", "r");
        dl_total_line = 1;
        hasDownlinkEntry = true;
        while (!feof(fp)) {
          json_entry[dl_total_line] = (char *)malloc(json_entry_size * sizeof(char));
          dl_line_size = getline(&json_entry[dl_total_line], &json_entry_size, fp);
          printf("^$Read downlink %d: %ld\n", dl_total_line, dl_line_size);
          if (dl_line_size > 0)
            dl_total_line++;
        }
        fclose(fp);
        char tmp_c[100];
        sprintf(tmp_c, "mv downlink/downlink.txt downlink/downlink-backup-%s.txt", time_buffer);
        system(tmp_c);
      } else {
        hasDownlinkEntry = false;
        printf("^$NO NEW DOWNLINK ENTRY\n");
      }
      if (hasDownlinkEntry) {
        Document document;
        printf("^$Queue all valid downlink requests\n");
        for (dl_line_index = 1; dl_line_index < dl_total_line; dl_line_index++) {
          StringBuffer json_record_buffer;
          Writer<StringBuffer> writer(json_record_buffer);
          printf("^$Downlink entry %d: %s", dl_line_index, json_entry[dl_line_index]);
          document.Parse(json_entry[dl_line_index]);
          if (document["status"].IsString())
            printf("^$status = %s\n", document["status"].GetString());
          if (document["dst"].IsInt())
            printf("^$dst = %d\n", document["dst"].GetInt());
          if (document["data"].IsString())
            printf("^$data = %s\n", document["data"].GetString());
          if (document["status"] == "send_request" && document["dst"].IsInt()) {
            document["status"].SetString("queued", document.GetAllocator());
            document.Accept(writer);
            printf("^$JSON record: %s\n", json_record_buffer.GetString());
            FLUSHOUTPUT;
            fp = fopen("downlink/downlink-queued.txt", "a");
            if (fp) {
              gettimeofday(&tv, NULL);
              millisec = lrint(tv.tv_usec / 1000.0);
              if (millisec >= 1000) {
                millisec -= 1000;
                tv.tv_sec++;
              }
              tm_info = localtime(&tv.tv_sec);
              strftime(time_buffer, 30, "%Y-%m-%dT%H:%M:%S", tm_info);
              fprintf(fp, "%s.%03d %s\n", time_buffer, millisec, json_record_buffer.GetString());
              fclose(fp);
            }
          } else
            printf("^$DISCARDING: not valid send_request\n");
        }
        dl_line_index = 1;
      }
      printf("^$-----------------------------------------------------\n");
      lastDownlinkSendTime = 0;
      enableDownlinkCheck = false;
      FLUSHOUTPUT;
    }
    if (hasDownlinkEntry && (millis() - lastDownlinkSendTime > interDownlinkSendTime)) {
      Document document;
      printf("^$-----------------------------------------------------\n");
      printf("^$Process downlink requests %d: %s\n", dl_line_index, json_entry[dl_line_index]);
      StringBuffer json_record_buffer;
      Writer<StringBuffer> writer(json_record_buffer);
      document.Parse(json_entry[dl_line_index]);
      if (document["status"].IsString())
        printf("^$status = %s\n", document["status"].GetString());
      if (document["dst"].IsInt())
        printf("^$dst = %d\n", document["dst"].GetInt());
      if (document["data"].IsString())
        printf("^$data = %s\n", document["data"].GetString());
      if (document["status"] == "send_request" && document["dst"].IsInt()) {
        extendedIFS = false;
        if (!CarrierSense(true)) {
          char time_buffer[30];
          int millisec;
          struct tm *tm_info;
          struct timeval tv;
          gettimeofday(&tv, NULL);
          sx1272.setPacketType(PKT_TYPE_DATA | PKT_FLAG_DATA_DOWNLINK);
#ifdef INCLUDE_MIC_IN_DOWNLINK
          if (document["MIC0"].IsString() && document["MIC0"] != "") {
            uint8_t downlink_message[100];
            sx1272.setPacketType(PKT_TYPE_DATA | PKT_FLAG_DATA_ENCRYPTED | PKT_FLAG_DATA_DOWNLINK);
            uint8_t l = document["data"].GetStringLength();
            memcpy(downlink_message, (uint8_t *)document["data"].GetString(), l);
            downlink_message[l] = (uint8_t)xtoi(document["MIC0"].GetString());
            downlink_message[l + 1] = (uint8_t)xtoi(document["MIC1"].GetString());
            downlink_message[l + 2] = (uint8_t)xtoi(document["MIC2"].GetString());
            downlink_message[l + 3] = (uint8_t)xtoi(document["MIC3"].GetString());
            l += 4;
            e = sx1272.sendPacketTimeout(document["dst"].GetInt(), downlink_message, l, 10000);
          } else {
            e = sx1272.sendPacketTimeout(document["dst"].GetInt(), (uint8_t *)document["data"].GetString(), document["data"].GetStringLength(), 10000);
          }
#else
          e = sx1272.sendPacketTimeout(document["dst"].GetInt(), (uint8_t *)document["data"].GetString(), document["data"].GetStringLength(), 10000);
#endif
          PRINT_CSTSTR("%s", "Packet sent, state ");
          PRINT_VALUE("%d", e);
          PRINTLN;
          if (!e)
            document["status"].SetString("sent", document.GetAllocator());
          else
            document["status"].SetString("sent_fail", document.GetAllocator());
          document.Accept(writer);
          printf("^$JSON record: %s\n", json_record_buffer.GetString());
          FLUSHOUTPUT;
          free(json_entry[dl_line_index]);
          fp = fopen("downlink/downlink-sent.txt", "a");
          if (fp) {
            millisec = lrint(tv.tv_usec / 1000.0);
            if (millisec >= 1000) {
              millisec -= 1000;
              tv.tv_sec++;
            }
            tm_info = localtime(&tv.tv_sec);
            strftime(time_buffer, 30, "%Y-%m-%dT%H:%M:%S", tm_info);
            fprintf(fp, "%s.%03d %s\n", time_buffer, millisec, json_record_buffer.GetString());
            fclose(fp);
          }
          dl_line_index++;
        } else {
          printf("^$DELAYED: busy channel\n");
        }
        extendedIFS = true;
      } else {
        printf("^$DISCARDING: not valid send_request\n");
        dl_line_index++;
      }
      if (dl_line_index == dl_total_line) {
        hasDownlinkEntry = false;
        printf("^$-----------------------------------------------------\n");
        printf("^$NO MORE PENDING send_request\n");
      }
      lastDownlinkSendTime = millis();
    }
  }
#endif
}
#ifndef ARDUINO
#ifdef WINPUT
void INThandler(int sig) {
  struct termios old = {0};
  if (tcgetattr(0, &old) < 0)
    perror("tcsetattr()");
  old.c_lflag |= ICANON;
  old.c_lflag |= ECHO;
  if (tcsetattr(0, TCSADRAIN, &old) < 0)
    perror("tcsetattr ~ICANON");
  PRINT_CSTSTR("%s", "Bye.\n");
  exit(0);
}
#endif
int xtoi(const char *hexstring) {
  int i = 0;
  if ((*hexstring == '0') && (*(hexstring + 1) == 'x'))
    hexstring += 2;
  while (*hexstring) {
    char c = toupper(*hexstring++);
    if ((c < '0') || (c > 'F') || ((c > '9') && (c < 'A')))
      break;
    c -= '0';
    if (c > 9)
      c -= 7;
    i = (i << 4) + c;
  }
  return i;
}
int main(int argc, char *argv[]) {
  int opt = 0;
  static struct option long_options[] = {{"mode", required_argument, 0, 'a'}, {"aes", no_argument, 0, 'b'},
                                         {"bw", required_argument, 0, 'c'},   {"cr", required_argument, 0, 'd'},
                                         {"sf", required_argument, 0, 'e'},   {"raw", no_argument, 0, 'f'},
                                         {"freq", required_argument, 0, 'g'}, {"ch", required_argument, 0, 'h'},
                                         {"sw", required_argument, 0, 'i'},
#ifdef DOWNLINK
                                         {"ndl", no_argument, 0, 'j'},
#endif
                                         {"hex", no_argument, 0, 'k'},        {0, 0, 0, 0}};
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
#ifdef DOWNLINK
    case 'j':
      optNDL = true;
      break;
#endif
    case 'k':
      optHEX = true;
      break;
    }
  }
#ifdef WINPUT
  struct termios old = {0};
  if (tcgetattr(0, &old) < 0)
    perror("tcsetattr()");
  old.c_lflag &= ~ICANON;
  old.c_lflag &= ~ECHO;
  old.c_cc[VMIN] = 0;
  old.c_cc[VTIME] = 0;
  if (tcsetattr(0, TCSANOW, &old) < 0)
    perror("tcsetattr ICANON");
  signal(SIGINT, INThandler);
#endif
  setup();
  while (1) {
    loop();
  }
  return (0);
}
#endif

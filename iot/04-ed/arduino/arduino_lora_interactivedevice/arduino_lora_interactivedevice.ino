
#include "SX1272.h"
#include <SPI.h>
#define ETSI_EUROPE_REGULATION
#define BAND868
#ifdef ETSI_EUROPE_REGULATION
#define MAX_DBM 14
#elif defined SENEGAL_REGULATION
#define MAX_DBM 10
#elif defined FCC_US_REGULATION
#define MAX_DBM 14
#endif
#define PABOOST
#define WITH_AES
#define LORAMODE 1
#define LORA_ADDR 6
#ifdef WITH_APPKEY
uint8_t my_appKey[4] = {5, 6, 7, 8};
#endif
#ifdef OLED
#include <U8x8lib.h>
#define OLED_PWR_PIN 8
#if defined ARDUINO_Heltec_WIFI_LoRa_32 || defined ARDUINO_WIFI_LoRa_32 || defined HELTEC_LORA
U8X8_SSD1306_128X64_NONAME_SW_I2C u8x8(15, 4, 16);
#elif defined ESP8266 || defined ARDUINO_ESP8266_ESP01
U8X8_SSD1306_128X64_NONAME_SW_I2C u8x8(12, 14, U8X8_PIN_NONE);
#else
#ifdef OLED_GND234
#ifdef OLED_PWR_PIN
#undef OLED_PWR_PIN
#define OLED_PWR_PIN 2
#endif
U8X8_SSD1306_128X64_NONAME_SW_I2C u8x8(3, 4, U8X8_PIN_NONE);
#else
U8X8_SSD1306_128X64_NONAME_SW_I2C u8x8(A5, A4, U8X8_PIN_NONE);
#endif
#endif
char oled_msg[20];
#endif
#if defined __SAMD21G18A__ && not defined ARDUINO_SAMD_FEATHER_M0
#define PRINTLN SerialUSB.println("")
#define PRINT_CSTSTR(fmt, param) SerialUSB.print(F(param))
#define PRINT_STR(fmt, param) SerialUSB.print(param)
#define PRINT_VALUE(fmt, param) SerialUSB.print(param)
#define PRINT_HEX(fmt, param) SerialUSB.print(param, HEX)
#define FLUSHOUTPUT SerialUSB.flush();
#else
#define PRINTLN Serial.println("")
#define PRINT_CSTSTR(fmt, param) Serial.print(F(param))
#define PRINT_STR(fmt, param) Serial.print(param)
#define PRINT_VALUE(fmt, param) Serial.print(param)
#define PRINT_HEX(fmt, param) Serial.print(param, HEX)
#define FLUSHOUTPUT Serial.flush();
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
#ifdef WITH_SEND_LED
#define SEND_LED 44
#endif
#define DEFAULT_DEST_ADDR 1
#define UNLOCK_PIN 1234
#ifdef LORA_LAS
#include "LoRaActivitySharing.h"
LASDevice loraLAS(LORA_ADDR, LAS_DEFAULT_ALPHA, DEFAULT_DEST_ADDR);
#endif
int dest_addr = DEFAULT_DEST_ADDR;
char cmd[260] = "****************";
char sprintf_buf[100];
uint32_t msg_sn = 0;
uint8_t unlocked_try = 3;
boolean unlocked = false;
boolean receivedFromSerial = false;
boolean receivedFromLoRa = false;
boolean withAck = false;
bool radioON = false;
uint8_t loraMode = LORAMODE;
uint32_t loraChannel = loraChannelArray[loraChannelIndex];
uint8_t loraAddr = LORA_ADDR;
unsigned long startDoCad, endDoCad;
bool extendedIFS = true;
uint8_t SIFS_cad_number;
uint8_t send_cad_number = 9;
uint8_t SIFS_value[11] = {0, 183, 94, 44, 47, 23, 24, 12, 12, 7, 4};
uint8_t CAD_value[11] = {0, 62, 31, 16, 16, 8, 9, 5, 3, 1, 1};
uint8_t carrier_sense_method = 2;
bool RSSIonSend = false;
unsigned int inter_pkt_time = 0;
unsigned int random_inter_pkt_time = 0;
unsigned long next_periodic_sendtime = 0L;
uint8_t MSS = 220;
#ifdef WITH_AES
#include "AES-128_V10.h"
#include "Encrypt_V31.h"
unsigned char AppSkey[16] = {0x2B, 0x7E, 0x15, 0x16, 0x28, 0xAE, 0xD2, 0xA6, 0xAB, 0xF7, 0x15, 0x88, 0x09, 0xCF, 0x4F, 0x3C};
unsigned char NwkSkey[16] = {0x2B, 0x7E, 0x15, 0x16, 0x28, 0xAE, 0xD2, 0xA6, 0xAB, 0xF7, 0x15, 0x88, 0x09, 0xCF, 0x4F, 0x3D};
unsigned char DevAddr[4] = {0x01, 0x02, 0x03, LORA_ADDR};
uint16_t Frame_Counter_Up = 0x0000;
unsigned char Direction = 0x00;
boolean with_aes = false;
#endif
boolean full_lorawan = false;
#if defined ARDUINO && defined SHOW_FREEMEMORY && not defined __MK20DX256__ && not defined __MKL26Z64__ && not defined __SAMD21G18A__ && not defined ARDUINO_SAM_DUE
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
  if (loraMode == 11) {
    e = sx1272.setChannel(CH_18_868);
    PRINT_CSTSTR("%s", "^$Channel CH_18_868: state ");
  } else {
    e = sx1272.setChannel(loraChannel);
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
  }
  PRINT_VALUE("%d", e);
  PRINTLN;
#ifdef PABOOST
  sx1272._needPABOOST = true;
  PRINT_CSTSTR("%s", "^$Use PA_BOOST amplifier line");
  PRINTLN;
#else
#endif
  PRINT_CSTSTR("%s", "^$Set LoRa power dBm to ");
  PRINT_VALUE("%d", (uint8_t)MAX_DBM);
  PRINTLN;
  e = sx1272.setPowerDBM((uint8_t)MAX_DBM);
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
  sx1272._nodeAddress = loraAddr;
  e = 0;
  PRINT_CSTSTR("%s", "^$LoRa addr ");
  PRINT_VALUE("%d", loraAddr);
  PRINT_CSTSTR("%s", ": state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
  e = sx1272.getCRC();
  PRINT_CSTSTR("%s", "^$CRC ");
  PRINT_VALUE("%d", sx1272._CRC);
  PRINT_CSTSTR("%s", ": state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
  e = sx1272.setCRC_ON();
  PRINT_CSTSTR("%s", "^$CRC ");
  PRINT_VALUE("%d", sx1272._CRC);
  PRINT_CSTSTR("%s", ": state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
  PRINT_CSTSTR("%s", "^$SX1272/76 configured ");
  PRINT_CSTSTR("%s", "as device. Waiting serial input for serial-RF bridge\n");
}
void CarrierSense0() {}
void CarrierSense1() {
  int e;
  bool carrierSenseRetry = false;
  uint8_t n_collision = 0;
  PRINT_CSTSTR("%s", "--> CarrierSense1: do CAD for DIFS=9CAD");
  PRINTLN;
  if (send_cad_number) {
    do {
      do {
        startDoCad = millis();
        e = sx1272.doCAD(send_cad_number);
        endDoCad = millis();
        PRINT_CSTSTR("%s", "--> SIFS/DIFS duration ");
        PRINT_VALUE("%ld", endDoCad - startDoCad);
        PRINTLN;
        if (!e) {
          PRINT_CSTSTR("%s", "OK1\n");
          extendedIFS = true;
          if (extendedIFS) {
            uint8_t w = random(1, 8);
            PRINT_CSTSTR("%s", "--> extended wait for ");
            PRINT_VALUE("%d", w);
            PRINT_CSTSTR("%s", " CAD = ");
            PRINT_VALUE("%d", CAD_value[loraMode] * w);
            PRINTLN;
            delay(CAD_value[loraMode] * w);
            startDoCad = millis();
            e = sx1272.doCAD(send_cad_number);
            endDoCad = millis();
            PRINT_CSTSTR("%s", "--> SIFS/DIFS duration ");
            PRINT_VALUE("%ld", endDoCad - startDoCad);
            PRINTLN;
            if (!e)
              PRINT_CSTSTR("%s", "OK2");
            else
              PRINT_CSTSTR("%s", "###2");
            PRINTLN;
          }
        } else {
          n_collision++;
          PRINT_CSTSTR("%s", "###");
          PRINT_VALUE("%d", n_collision);
          PRINTLN;
          uint8_t w = random(1, 8);
          PRINT_CSTSTR("%s", "--> Channel busy. Wait for ");
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
}
void CarrierSense2() {
  int e;
  bool carrierSenseRetry = false;
  uint8_t foundBusyDuringDIFSafterBusyState = 0;
  uint8_t n_collision = 0;
  uint8_t W = 2;
  PRINT_CSTSTR("%s", "--> CarrierSense2: do CAD for DIFS=9CAD");
  PRINTLN;
  if (send_cad_number) {
    do {
      do {
        if (foundBusyDuringDIFSafterBusyState > 1 && foundBusyDuringDIFSafterBusyState < 5)
          W = W * 2;
        startDoCad = millis();
        e = sx1272.doCAD(send_cad_number);
        endDoCad = millis();
        PRINT_CSTSTR("%s", "--> DIFS duration ");
        PRINT_VALUE("%ld", endDoCad - startDoCad);
        PRINTLN;
        if (!e) {
          if (n_collision) {
            PRINT_CSTSTR("%s", "--> counting for ");
            uint8_t w = random(0, W * send_cad_number);
            PRINT_VALUE("%d", w);
            PRINTLN;
            int busyCount = 0;
            bool nowBusy = false;
            do {
              if (nowBusy)
                e = sx1272.doCAD(send_cad_number);
              else
                e = sx1272.doCAD(1);
              if (nowBusy && e) {
                PRINT_CSTSTR("%s", "#");
                busyCount++;
              } else if (nowBusy && !e) {
                PRINT_CSTSTR("%s", "|");
                nowBusy = false;
              } else if (!e) {
                w--;
                PRINT_CSTSTR("%s", "-");
              } else {
                PRINT_CSTSTR("%s", "*");
                nowBusy = true;
                busyCount++;
              }
            } while (w);
            PRINTLN;
            PRINT_CSTSTR("%s", "--> found busy during ");
            PRINT_VALUE("%d", busyCount);
            PRINTLN;
          } else {
            PRINT_CSTSTR("%s", "OK1\n");
            extendedIFS = false;
            if (extendedIFS) {
              uint8_t w = random(1, 8);
              PRINT_CSTSTR("%s", "--> extended waiting for ");
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
          }
        } else {
          n_collision++;
          foundBusyDuringDIFSafterBusyState++;
          PRINT_CSTSTR("%s", "###");
          PRINT_VALUE("%d", n_collision);
          PRINTLN;
          PRINT_CSTSTR("%s", "--> Channel busy. Retry CAD until free channel\n");
          int busyCount = 0;
          startDoCad = millis();
          do {
            e = sx1272.doCAD(1);
            if (e) {
              PRINT_CSTSTR("%s", "R");
              busyCount++;
            }
          } while (e);
          endDoCad = millis();
          PRINTLN;
          PRINT_CSTSTR("%s", "--> found busy during ");
          PRINT_VALUE("%d", busyCount);
          PRINTLN;
          PRINT_CSTSTR("%s", "--> wait duration ");
          PRINT_VALUE("%ld", endDoCad - startDoCad);
          PRINTLN;
          PRINT_CSTSTR("%s", "--> retry\n");
          e = 1;
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
}
void CarrierSense3() {
  int e;
  bool carrierSenseRetry = false;
  uint8_t n_collision = 0;
  uint8_t n_cad = 9;
  uint32_t max_toa = sx1272.getToA(255);
  if (send_cad_number) {
    do {
      PRINT_CSTSTR("%s", "--> CarrierSense3: do CAD for MaxToa=");
      PRINT_VALUE("%ld", max_toa);
      PRINTLN;
      for (int i = 0; i < n_cad; i++) {
        startDoCad = millis();
        e = sx1272.doCAD(1);
        endDoCad = millis();
        if (!e) {
          PRINT_VALUE("%ld", endDoCad);
          PRINT_CSTSTR("%s", " 0 ");
          PRINT_VALUE("%d", sx1272._RSSI);
          PRINT_CSTSTR("%s", " ");
          PRINT_VALUE("%ld", endDoCad - startDoCad);
          PRINTLN;
        } else
          continue;
        delay(max_toa / (n_cad - 1) - (millis() - startDoCad));
      }
      if (e) {
        n_collision++;
        PRINT_CSTSTR("%s", "###");
        PRINT_VALUE("%d", n_collision);
        PRINTLN;
        PRINT_CSTSTR("%s", "Channel busy. Wait for MaxToA=");
        PRINT_VALUE("%ld", max_toa);
        PRINTLN;
        delay(max_toa);
        PRINT_CSTSTR("%s", "--> retry\n");
        carrierSenseRetry = true;
      } else
        carrierSenseRetry = false;
    } while (carrierSenseRetry);
  }
}
void setup() {
  int e;
  delay(3000);
  randomSeed(analogRead(14));
#if defined __SAMD21G18A__ && not defined ARDUINO_SAMD_FEATHER_M0
  SerialUSB.begin(38400);
#else
  Serial.begin(38400);
#endif
  PRINT_CSTSTR("%s", "LoRa interactive device\n");
#ifdef ARDUINO_AVR_PRO
  PRINT_CSTSTR("%s", "Arduino Pro Mini detected\n");
#endif
#ifdef ARDUINO_AVR_NANO
  PRINT_CSTSTR("%s", "Arduino Nano detected\n");
#endif
#ifdef ARDUINO_AVR_MINI
  PRINT_CSTSTR("%s", "Arduino Mini/Nexus detected\n");
#endif
#ifdef ARDUINO_AVR_MEGA2560
  PRINT_CSTSTR("%s", "Arduino Mega2560 detected\n");
#endif
#ifdef ARDUINO_SAM_DUE
  PRINT_CSTSTR("%s", "Arduino Due detected\n");
#endif
#ifdef __MK66FX1M0__
  PRINT_CSTSTR("%s", "Teensy36 MK66FX1M0 detected\n");
#endif
#ifdef __MK64FX512__
  PRINT_CSTSTR("%s", "Teensy35 MK64FX512 detected\n");
#endif
#ifdef __MK20DX256__
  PRINT_CSTSTR("%s", "Teensy31/32 MK20DX256 detected\n");
#endif
#ifdef __MKL26Z64__
  PRINT_CSTSTR("%s", "TeensyLC MKL26Z64 detected\n");
#endif
#if defined ARDUINO_SAMD_ZERO && not defined ARDUINO_SAMD_FEATHER_M0
  PRINT_CSTSTR("%s", "Arduino M0/Zero detected\n");
#endif
#ifdef ARDUINO_AVR_FEATHER32U4
  PRINT_CSTSTR("%s", "Adafruit Feather32U4 detected\n");
#endif
#ifdef ARDUINO_SAMD_FEATHER_M0
  PRINT_CSTSTR("%s", "Adafruit FeatherM0 detected\n");
#endif
#ifdef __AVR_ATmega328P__
  PRINT_CSTSTR("%s", "ATmega328P detected\n");
#endif
#ifdef __AVR_ATmega32U4__
  PRINT_CSTSTR("%s", "ATmega32U4 detected\n");
#endif
#ifdef __AVR_ATmega2560__
  PRINT_CSTSTR("%s", "ATmega2560 detected\n");
#endif
#ifdef __SAMD21G18A__
  PRINT_CSTSTR("%s", "SAMD21G18A ARM Cortex-M0 detected\n");
#endif
#ifdef __SAM3X8E__
  PRINT_CSTSTR("%s", "SAM3X8E ARM Cortex-M3 detected\n");
#endif
#if defined ARDUINO && defined SHOW_FREEMEMORY && not defined __MK20DX256__ && not defined __MKL26Z64__ && not defined __SAMD21G18A__ && not defined ARDUINO_SAM_DUE
  Serial.print(freeMemory());
  Serial.println(F(" bytes of free memory."));
#endif
  e = sx1272.ON();
  PRINT_CSTSTR("%s", "^$**********Power ON: state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
  e = sx1272.getSyncWord();
  if (!e) {
    PRINT_CSTSTR("%s", "^$Default sync word: 0x");
    PRINT_HEX("%X", sx1272._syncWord);
    PRINTLN;
  }
  if (!e) {
    radioON = true;
    startConfig();
  }
  FLUSHOUTPUT;
  delay(1000);
#ifdef LORA_LAS
  loraLAS.ON(LAS_ON_WRESET);
#endif
#ifdef OLED
#ifdef OLED_PWR_PIN
  pinMode(OLED_PWR_PIN, OUTPUT);
  digitalWrite(OLED_PWR_PIN, HIGH);
#endif
  u8x8.begin();
  u8x8.setFont(u8x8_font_chroma48medium8_r);
#endif
#ifdef CAD_TEST
  PRINT_CSTSTR("%s", "Do CAD test\n");
#ifdef OLED
  u8x8.drawString(0, 0, "CAD TEST");
  sprintf(oled_msg, "LoRa mode %d", loraMode);
  u8x8.drawString(0, 1, oled_msg);
#endif
#endif
#ifdef PERIODIC_SENDER
  inter_pkt_time = PERIODIC_SENDER;
  PRINT_CSTSTR("%s", "Periodic sender ON");
  PRINTLN;
#ifdef OLED
  u8x8.drawString(0, 0, "PERIODIC SEND");
  sprintf(oled_msg, "LoRa mode %d", loraMode);
  u8x8.drawString(0, 1, oled_msg);
  sprintf(oled_msg, "period=%d", inter_pkt_time);
  u8x8.drawString(0, 2, oled_msg);
#endif
#endif
}
void loop(void) {
  int i = 0, e;
  int cmdValue;
  uint8_t app_key_offset = 0;
#ifdef CAD_TEST
  uint8_t SX1272_led_cad = 4;
  bool CadDetected = false;
  unsigned long firstDetected, lastDetected = 0;
  pinMode(SX1272_led_cad, OUTPUT);
  while (1) {
    startDoCad = millis();
    e = sx1272.doCAD(1);
    endDoCad = millis();
    if (e && !CadDetected) {
      digitalWrite(SX1272_led_cad, HIGH);
      PRINT_CSTSTR("%s", "###########################\n");
      PRINT_CSTSTR("%s", "no activity for (ms): ");
      PRINT_VALUE("%ld", endDoCad - lastDetected);
      PRINTLN;
      PRINT_CSTSTR("%s", "###########################\n");
      firstDetected = endDoCad;
      CadDetected = true;
#ifdef OLED
      u8x8.drawString(0, 0, "#########");
      u8x8.clearLine(1);
      sprintf(oled_msg, "%ld", endDoCad - lastDetected);
      u8x8.drawString(0, 1, oled_msg);
      u8x8.drawString(0, 2, "#########");
#endif
    }
    if (!e && CadDetected) {
      digitalWrite(SX1272_led_cad, LOW);
      PRINT_CSTSTR("%s", "+++++++++++++++++++++++++++\n");
      PRINT_CSTSTR("%s", "time (ms): ");
      PRINT_VALUE("%ld", endDoCad);
      PRINTLN;
      PRINT_CSTSTR("%s", "duration (ms): ");
      PRINT_VALUE("%ld", endDoCad - firstDetected);
      PRINTLN;
      PRINT_CSTSTR("%s", "current RSSI: ");
      PRINT_VALUE("%d", sx1272._RSSI);
      PRINTLN;
      lastDetected = endDoCad;
      CadDetected = false;
#ifdef OLED
      u8x8.clearLine(3);
      u8x8.drawString(0, 3, "+++++++++");
      u8x8.clearLine(4);
      sprintf(oled_msg, "%ld", endDoCad);
      u8x8.drawString(0, 4, oled_msg);
      u8x8.clearLine(5);
      sprintf(oled_msg, "%ld", endDoCad - firstDetected);
      u8x8.drawString(0, 5, oled_msg);
#endif
    }
    if (e) {
      PRINT_VALUE("%ld", endDoCad);
      PRINT_CSTSTR("%s", " 1 ");
      PRINT_VALUE("%d", sx1272._RSSI);
      PRINT_CSTSTR("%s", " ");
      PRINT_VALUE("%ld", endDoCad - startDoCad);
      PRINTLN;
#ifdef OLED
      u8x8.clearLine(3);
      sprintf(oled_msg, "%ld", endDoCad);
      u8x8.drawString(0, 3, oled_msg);
      u8x8.clearLine(4);
      sprintf(oled_msg, "%d", sx1272._RSSI);
      u8x8.drawString(0, 4, oled_msg);
      u8x8.clearLine(5);
      sprintf(oled_msg, "%d", endDoCad - startDoCad);
      u8x8.drawString(0, 5, oled_msg);
#endif
    }
    delay(200);
  }
#endif
  receivedFromSerial = false;
  receivedFromLoRa = false;
#ifdef LORA_LAS
  loraLAS.checkCycle();
#endif
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
  if (radioON && !receivedFromSerial) {
    if (inter_pkt_time)
      if (millis() > next_periodic_sendtime) {
        PRINT_CSTSTR("%s", "time is ");
        PRINT_VALUE("%ld", millis());
        PRINTLN;
        sprintf(cmd, "msg%3d***", msg_sn++);
        for (i = strlen(cmd); i < MSS; i++)
          cmd[i] = '*';
        cmd[i] = '\0';
        PRINT_CSTSTR("%s", "Sending : ");
        PRINT_STR("%s", cmd);
        PRINTLN;
        if (carrier_sense_method == 0)
          CarrierSense0();
        if (carrier_sense_method == 1)
          CarrierSense1();
        if (carrier_sense_method == 2)
          CarrierSense2();
        if (carrier_sense_method == 3)
          CarrierSense3();
#ifdef OLED
        u8x8.clearLine(5);
        sprintf(oled_msg, "Sending %d Bytes", strlen(cmd));
        u8x8.drawString(0, 5, oled_msg);
#endif
        PRINT_CSTSTR("%s", "Packet number ");
        PRINT_VALUE("%d", sx1272._packetNumber);
        PRINTLN;
        PRINT_CSTSTR("%s", "Payload size is ");
        PRINT_VALUE("%d", strlen(cmd));
        PRINTLN;
        uint32_t toa = sx1272.getToA(strlen(cmd) + (full_lorawan ? 0 : OFFSET_PAYLOADLENGTH));
        PRINT_CSTSTR("%s", "ToA w/4B header is ");
        PRINT_VALUE("%d", toa);
        PRINTLN;
#ifdef OLED
        u8x8.clearLine(6);
        sprintf(oled_msg, "ToA : ", toa);
        u8x8.drawString(0, 6, oled_msg);
#endif
        long startSend = millis();
#ifdef WITH_SEND_LED
        digitalWrite(SEND_LED, HIGH);
#endif
        e = sx1272.sendPacketTimeout(dest_addr, (uint8_t *)cmd, strlen(cmd), 10000);
#ifdef WITH_SEND_LED
        digitalWrite(SEND_LED, LOW);
#endif
        PRINT_CSTSTR("%s", "LoRa Sent in ");
        PRINT_VALUE("%ld", millis() - startSend);
        PRINTLN;
        PRINT_CSTSTR("%s", "Packet sent, state ");
        PRINT_VALUE("%d", e);
        PRINTLN;
#ifdef OLED
        u8x8.clearLine(5);
        u8x8.clearLine(7);
        sprintf(oled_msg, "Sending state: ", e);
        u8x8.drawString(0, 7, oled_msg);
#endif
        if (random_inter_pkt_time) {
          random_inter_pkt_time = random(2000, inter_pkt_time);
          next_periodic_sendtime = millis() + random_inter_pkt_time;
        } else
          next_periodic_sendtime = millis() + inter_pkt_time;
        PRINT_CSTSTR("%s", "next at ");
        PRINT_VALUE("%ld", next_periodic_sendtime);
        PRINTLN;
      }
    e = 1;
#ifndef CAD_TEST
    uint16_t w_timer = 1000;
    if (loraMode == 1)
      w_timer = 2500;
    e = sx1272.receivePacketTimeout(w_timer);
#endif
    if (!e) {
      int a = 0, b = 0;
      uint8_t tmp_length;
      receivedFromLoRa = true;
      sx1272.getSNR();
      sx1272.getRSSIpacket();
      tmp_length = sx1272._payloadlength;
      sprintf(sprintf_buf, "--- rxlora. dst=%d type=0x%.2X src=%d seq=%d len=%d SNR=%d RSSIpkt=%d BW=%d CR=4/%d SF=%d\n", sx1272.packet_received.dst, sx1272.packet_received.type, sx1272.packet_received.src, sx1272.packet_received.packnum, tmp_length, sx1272._SNR, sx1272._RSSIpacket, (sx1272._bandwidth == BW_125) ? 125 : ((sx1272._bandwidth == BW_250) ? 250 : 500), sx1272._codingRate + 4, sx1272._spreadingFactor);
      PRINT_STR("%s", sprintf_buf);
      sprintf(sprintf_buf, "^p%d,%d,%d,%d,%d,%d,%d\n", sx1272.packet_received.dst, sx1272.packet_received.type, sx1272.packet_received.src, sx1272.packet_received.packnum, tmp_length, sx1272._SNR, sx1272._RSSIpacket);
      PRINT_STR("%s", sprintf_buf);
      sprintf(sprintf_buf, "^r%d,%d,%d\n", (sx1272._bandwidth == BW_125) ? 125 : ((sx1272._bandwidth == BW_250) ? 250 : 500), sx1272._codingRate + 4, sx1272._spreadingFactor);
      PRINT_STR("%s", sprintf_buf);
#ifdef LORA_LAS
      if (loraLAS.isLASMsg(sx1272.packet_received.data)) {
        tmp_length = sx1272._payloadlength;
        int v = loraLAS.handleLASMsg(sx1272.packet_received.src, sx1272.packet_received.data, tmp_length);
        if (v == DSP_DATA) {
          a = LAS_DSP + DATA_HEADER_LEN + 1;
        } else
          a = tmp_length;
      } else
        PRINT_CSTSTR("%s", "No LAS header. Write raw data\n");
#endif
      for (; a < tmp_length; a++, b++) {
        PRINT_STR("%c", (char)sx1272.packet_received.data[a]);
        cmd[b] = (char)sx1272.packet_received.data[a];
      }
      cmd[b] = '\0';
      PRINTLN;
      FLUSHOUTPUT;
    }
  }
  if (receivedFromSerial || receivedFromLoRa) {
    boolean sendCmd = false;
    boolean withTmpAck = false;
    int forTmpDestAddr = -1;
    i = 0;
    if (cmd[i] == '/' && cmd[i + 1] == '@') {
      PRINT_CSTSTR("%s", "^$Parsing command\n");
      i = i + 2;
      PRINT_CSTSTR("%s", "^$");
      PRINT_STR("%s", cmd);
      PRINTLN;
      if ((receivedFromLoRa && cmd[i] != 'U' && !unlocked) || !unlocked_try) {
        PRINT_CSTSTR("%s", "^$Remote config locked\n");
        cmd[i] = '*';
      }
      switch (cmd[i]) {
      case 'D':
        if (cmd[i + 1] == 'B' && cmd[i + 2] == 'M') {
          i = i + 3;
          cmdValue = getCmdValue(i);
          if (cmdValue > 0 && cmdValue < 15) {
            PRINT_CSTSTR("%s", "^$set power dBm: ");
            PRINT_VALUE("%d", cmdValue);
            PRINTLN;
            e = sx1272.setPowerDBM((uint8_t)cmdValue);
            PRINT_CSTSTR("%s", "^$set power dBm: state ");
            PRINT_VALUE("%d", e);
            PRINTLN;
          }
        } else {
          i++;
          cmdValue = getCmdValue(i);
          i++;
          if (cmdValue > 255)
            cmdValue = 255;
          if (cmdValue < 0)
            cmdValue = 0;
          if (i == strlen(cmd)) {
            dest_addr = cmdValue;
            PRINT_CSTSTR("%s", "Set LoRa dest addr to ");
            PRINT_VALUE("%d", dest_addr);
            PRINTLN;
          } else {
            forTmpDestAddr = cmdValue;
            PRINT_CSTSTR("%s", "Set LoRa dest addr FOR THIS ASCII STRING to ");
            PRINT_VALUE("%d", forTmpDestAddr);
            PRINTLN;
            sendCmd = true;
          }
        }
        break;
      case 'T':
        i++;
        if (cmd[i] == 'R') {
          random_inter_pkt_time = 1;
          i++;
        } else
          random_inter_pkt_time = 0;
        cmdValue = getCmdValue(i);
        inter_pkt_time = cmdValue;
        if (inter_pkt_time) {
          PRINT_CSTSTR("%s", "Set inter-packet time to ");
          PRINT_VALUE("%ld", inter_pkt_time);
          PRINTLN;
          next_periodic_sendtime = millis() + inter_pkt_time;
        } else {
          PRINT_CSTSTR("%s", "Disable periodic send\n");
        }
        if (random_inter_pkt_time) {
          random_inter_pkt_time = random(2000, inter_pkt_time);
          next_periodic_sendtime = millis() + random_inter_pkt_time;
        }
        break;
      case 'Z':
        i++;
        cmdValue = getCmdValue(i);
        if (cmdValue > 250)
          cmdValue = 250;
        if (cmdValue < 10)
          cmdValue = 10;
        MSS = cmdValue;
        PRINT_CSTSTR("%s", "Set MSS to ");
        PRINT_VALUE("%d", MSS);
        PRINTLN;
        break;
      case 'R':
#ifdef LORA_LAS
        if (cmd[i + 1] == 'E' && cmd[i + 2] == 'G') {
          PRINT_CSTSTR("%s", "^$Send LAS REG msg\n");
          loraLAS.sendReg();
        }
#endif
        if (cmd[i + 1] == 'S' && cmd[i + 2] == 'S' && cmd[i + 3] == 'I') {
          RSSIonSend = !RSSIonSend;
          if (RSSIonSend)
            PRINT_CSTSTR("%s", "RSSI ON\n");
          else
            PRINT_CSTSTR("%s", "RSSI OFF\n");
        }
        break;
      case 'E':
        if (cmd[i + 1] == 'I' && cmd[i + 2] == 'F' && cmd[i + 3] == 'S') {
          extendedIFS = !extendedIFS;
          if (extendedIFS)
            PRINT_CSTSTR("%s", "EIFS ON\n");
          else
            PRINT_CSTSTR("%s", "EIFS OFF\n");
        }
        break;
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
        } else {
          i++;
          cmdValue = getCmdValue(i);
          i++;
          if (cmdValue > 250) {
            PRINT_CSTSTR("%s", "No more than 250B\n");
          } else {
            int k = 0;
            for (k = 0; k < cmdValue; k++)
              cmd[k + i] = '#';
            cmd[k + i] = '\0';
            sendCmd = true;
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
        } else if (cmd[i + 1] == 'S') {
          i = i + 2;
          cmdValue = getCmdValue(i);
          if (cmdValue > 3) {
            PRINT_CSTSTR("%s", "^$Carrier Sense method must be 0, 1, 2 or 3.\n");
            cmdValue = 2;
          }
          carrier_sense_method = cmdValue;
          PRINT_CSTSTR("%s", "^$Selected carrier Sense method is ");
          PRINT_VALUE("%d", carrier_sense_method);
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
          char loraPower = cmd[i + 1];
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
      case 'A':
        if (cmd[i + 1] == 'C' && cmd[i + 2] == 'K') {
          if (cmd[i + 3] == '#') {
            i = i + 4;
            withTmpAck = true;
            sendCmd = true;
          } else {
            if (cmd[i + 3] == 'O' && cmd[i + 4] == 'N') {
              withAck = true;
              PRINT_CSTSTR("%s", "^$ACK enabled\n");
            }
            if (cmd[i + 3] == 'O' && cmd[i + 4] == 'F' && cmd[i + 5] == 'F') {
              withAck = false;
              PRINT_CSTSTR("%s", "^$ACK disabled\n");
            }
          }
        }
#ifdef WITH_AES
        else if (cmd[i + 1] == 'E' && cmd[i + 2] == 'S') {
          with_aes = !with_aes;
          if (with_aes)
            PRINT_CSTSTR("%s", "AES ON\n");
          else
            PRINT_CSTSTR("%s", "AES OFF\n");
        }
#endif
        else {
          i++;
          cmdValue = getCmdValue(i);
          if (cmdValue > 255)
            cmdValue = 255;
          if (cmdValue < 1)
            cmdValue = LORA_ADDR;
          loraAddr = cmdValue;
          PRINT_CSTSTR("%s", "^$Set LoRa node addr to ");
          PRINT_VALUE("%d", loraAddr);
          PRINTLN;
          e = sx1272.setNodeAddress(loraAddr);
          PRINT_CSTSTR("%s", "^$Setting LoRa node addr: state ");
          PRINT_VALUE("%d", e);
          PRINTLN;
        }
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
      case 'L':
#ifdef LORA_LAS
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
        }
#endif
#ifdef WITH_AES
        if (cmd[i + 1] == 'W') {
          full_lorawan = !full_lorawan;
          if (full_lorawan) {
            PRINT_CSTSTR("%s", "NATIVE LORAWAN FORMAT ON\n");
            sx1272._rawFormat = true;
            with_aes = true;
            PRINT_CSTSTR("%s", "FOR SENDING TO A LORAWAN GW, YOU HAVE TO:\n");
            PRINT_CSTSTR("%s", "SET TO MODE 11: /@M11#\n");
            PRINT_CSTSTR("%s", "SET CHANNEL to 18: /@C18#\n");
            PRINT_CSTSTR("%s", "SET SYNC WORD to 0x34: /@W34#\n");
          } else {
            PRINT_CSTSTR("%s", "NATIVE LORAWAN FORMAT OFF\n");
            PRINT_CSTSTR("%s", "WARNING: AES IS NOW OFF\n");
            sx1272._rawFormat = false;
            with_aes = false;
          }
        }
#endif
        break;
      default:
        PRINT_CSTSTR("%s", "Unrecognized cmd\n");
        break;
      }
      FLUSHOUTPUT;
    } else
      sendCmd = true;
    if (sendCmd && receivedFromSerial) {
      uint8_t pl = strlen((char *)(&cmd[i]));
      PRINT_CSTSTR("%s", "Sending. Length is ");
      PRINT_VALUE("%d", pl);
      PRINTLN;
      PRINT_STR("%s", (char *)(&cmd[i]));
      PRINTLN;
#ifdef LORA_LAS
      if (forTmpDestAddr >= 0)
        e = loraLAS.sendData(forTmpDestAddr, (uint8_t *)(&cmd[i]), pl, 0, LAS_FIRST_DATAPKT + LAS_LAST_DATAPKT, withAck | withTmpAck);
      else
        e = loraLAS.sendData(dest_addr, (uint8_t *)(&cmd[i]), pl, 0, LAS_FIRST_DATAPKT + LAS_LAST_DATAPKT, withAck | withTmpAck);
      if (e == TOA_OVERUSE) {
        PRINT_CSTSTR("%s", "^$Not sent, TOA_OVERUSE\n");
      }
      if (e == LAS_LBT_ERROR) {
        PRINT_CSTSTR("%s", "^$LBT error\n");
      }
      if (e == LAS_SEND_ERROR || e == LAS_ERROR) {
        PRINT_CSTSTR("%s", "Send error\n");
      }
#else
#ifdef WITH_SEND_LED
      digitalWrite(SEND_LED, HIGH);
#endif
      PRINT_CSTSTR("%s", "Packet number ");
      PRINT_VALUE("%d", sx1272._packetNumber);
      PRINTLN;
      unsigned char LORAWAN_Data[256];
      unsigned char LORAWAN_Package_Length = 9;
      uint8_t p_type = PKT_TYPE_DATA;
#ifdef WITH_APPKEY
      app_key_offset = (full_lorawan ? 0 : sizeof(my_appKey));
      if (app_key_offset) {
        p_type = p_type | PKT_FLAG_DATA_WAPPKEY;
      }
#endif
#ifdef WITH_AES
      if (with_aes) {
        p_type = p_type | PKT_FLAG_DATA_ENCRYPTED;
#ifdef WITH_APPKEY
        memcpy(LORAWAN_Data + LORAWAN_Package_Length, my_appKey, app_key_offset);
        pl += app_key_offset;
#endif
        memcpy(LORAWAN_Data + LORAWAN_Package_Length + app_key_offset, (uint8_t *)(&cmd[i]), pl);
        PRINT_CSTSTR("%s", "plain payload hex\n");
        for (int j = i; j < i + pl; j++) {
          if (LORAWAN_Data[LORAWAN_Package_Length + j] < 16)
            PRINT_CSTSTR("%s", "0");
          PRINT_HEX("%X", LORAWAN_Data[LORAWAN_Package_Length + j]);
          PRINT_CSTSTR("%s", " ");
        }
        PRINTLN;
        PRINT_CSTSTR("%s", "Encrypting\n");
        PRINT_CSTSTR("%s", "encrypted payload\n");
        Encrypt_Payload(LORAWAN_Data + LORAWAN_Package_Length, pl, Frame_Counter_Up, Direction);
        for (int j = i; j < i + pl; j++) {
          if (LORAWAN_Data[LORAWAN_Package_Length + j] < 16)
            PRINT_CSTSTR("%s", "0");
          PRINT_HEX("%X", LORAWAN_Data[LORAWAN_Package_Length + j]);
          PRINT_CSTSTR("%s", " ");
        }
        PRINTLN;
        unsigned char MIC[4];
        unsigned char Mac_Header = 0x40;
        unsigned char Frame_Control = 0x00;
        unsigned char Frame_Port = 0x01;
        LORAWAN_Data[0] = Mac_Header;
        LORAWAN_Data[1] = DevAddr[3];
        LORAWAN_Data[2] = DevAddr[2];
        LORAWAN_Data[3] = DevAddr[1];
        LORAWAN_Data[4] = DevAddr[0];
        LORAWAN_Data[5] = Frame_Control;
        LORAWAN_Data[6] = (Frame_Counter_Up & 0x00FF);
        LORAWAN_Data[7] = ((Frame_Counter_Up >> 8) & 0x00FF);
        LORAWAN_Data[8] = Frame_Port;
        LORAWAN_Package_Length = LORAWAN_Package_Length + pl;
        PRINT_CSTSTR("%s", "calculate MIC with NwkSKey\n");
        Calculate_MIC(LORAWAN_Data, MIC, LORAWAN_Package_Length, Frame_Counter_Up, Direction);
        for (int j = 0; j < 4; j++) {
          LORAWAN_Data[j + LORAWAN_Package_Length] = MIC[j];
        }
        LORAWAN_Package_Length = LORAWAN_Package_Length + 4;
        PRINT_CSTSTR("%s", "transmitted LoRaWAN-like packet:\n");
        PRINT_CSTSTR("%s", "MHDR[1] | DevAddr[4] | FCtrl[1] | FCnt[2] | FPort[1] | EncryptedPayload | MIC[4]\n");
        for (int j = 0; j < LORAWAN_Package_Length; j++) {
          if (LORAWAN_Data[j] < 16)
            PRINT_CSTSTR("%s", "0");
          PRINT_HEX("%X", LORAWAN_Data[j]);
          PRINT_CSTSTR("%s", " ");
        }
        PRINTLN;
        pl = LORAWAN_Package_Length;
        if (full_lorawan) {
          PRINT_CSTSTR("%s", "end-device uses native LoRaWAN packet format\n");
        } else {
          PRINT_CSTSTR("%s", "end-device uses encapsulated LoRaWAN packet format only for encryption\n");
        }
        Frame_Counter_Up++;
      } else {
#ifdef WITH_APPKEY
        memcpy(LORAWAN_Data, my_appKey, app_key_offset);
#endif
        memcpy(LORAWAN_Data + app_key_offset, (uint8_t *)(&cmd[i]), pl);
        pl += app_key_offset;
      }
#else
#ifdef WITH_APPKEY
                        memcpy(LORAWAN_Data,my_appKey,app_key_offset));
#endif
                        memcpy(LORAWAN_Data + app_key_offset, (uint8_t *)(&cmd[i]), pl);
                        pl += app_key_offset;
#endif
      sx1272.setPacketType(p_type);
      PRINT_CSTSTR("%s", "Payload size is ");
      PRINT_VALUE("%d", pl);
      PRINTLN;
      uint32_t toa = sx1272.getToA(pl + (full_lorawan ? 0 : OFFSET_PAYLOADLENGTH));
      PRINT_CSTSTR("%s", "ToA is w/4B header ");
      PRINT_VALUE("%d", toa);
      PRINTLN;
      long startSend, endSend;
      long startSendCad;
      startSendCad = millis();
      if (carrier_sense_method == 0)
        CarrierSense0();
      if (carrier_sense_method == 1)
        CarrierSense1();
      if (carrier_sense_method == 2)
        CarrierSense2();
      if (carrier_sense_method == 3)
        CarrierSense3();
      startSend = millis();
      if (forTmpDestAddr >= 0) {
        if (withAck)
          e = sx1272.sendPacketTimeoutACK(forTmpDestAddr, LORAWAN_Data, pl, 10000);
        else
          e = sx1272.sendPacketTimeout(forTmpDestAddr, LORAWAN_Data, pl, 10000);
      } else {
        if (withAck || withTmpAck)
          e = sx1272.sendPacketTimeoutACK(dest_addr, LORAWAN_Data, pl, 10000);
        else
          e = sx1272.sendPacketTimeout(dest_addr, LORAWAN_Data, pl, 10000);
      }
#ifdef WITH_SEND_LED
      digitalWrite(SEND_LED, LOW);
#endif
      endSend = millis();
      if ((withAck || withTmpAck) && !e) {
        sx1272.getSNR();
        sx1272.getRSSIpacket();
        sprintf(sprintf_buf, "--- rxlora ACK. SNR=%d RSSIpkt=%d\n", sx1272._SNR, sx1272._RSSIpacket);
        PRINT_STR("%s", sprintf_buf);
        PRINT_CSTSTR("%s", "LoRa (ACK) Sent in ");
      } else
        PRINT_CSTSTR("%s", "LoRa Sent in ");
      PRINT_VALUE("%ld", endSend - startSend);
      PRINTLN;
      PRINT_CSTSTR("%s", "LoRa Sent w/CAD in ");
      PRINT_VALUE("%ld", endSend - startSendCad);
      PRINTLN;
#endif
      PRINT_CSTSTR("%s", "Packet sent, state ");
      PRINT_VALUE("%d", e);
      PRINTLN;
    }
  }
}

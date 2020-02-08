
#include "SX1272.h"
#include "my_temp_sensor_code.h"
#include <SPI.h>
#define WITH_EEPROM
#define STRING_LIB
#define LOW_POWER
#define LOW_POWER_HIBERNATE
#define WITH_AES
#define LORAWAN
#if defined ARDUINO_SAM_DUE || defined __SAMD21G18A__
#undef WITH_EEPROM
#endif
#if defined ARDUINO_SAM_DUE
#undef LOW_POWER
#endif
#define ETSI_EUROPE_REGULATION
#define BAND868
#define PABOOST
uint8_t node_addr = 6;
#define LORAMODE 1
#ifdef LORAWAN
int SF = 12;
#endif
unsigned int idlePeriodInMin = 30;
#define FORCE_DEFAULT_VALUE
#ifdef WITH_APPKEY
uint8_t my_appKey[4] = {5, 6, 7, 8};
#endif
#ifdef WITH_AES
#include "AES-128_V10.h"
#include "Encrypt_V31.h"
#define AES_SHOWB64
#ifdef AES_SHOWB64
#include <Base64.h>
#endif
unsigned char AppSkey[16] = {0x05, 0x40, 0xAC, 0x07, 0xB0, 0x9E, 0x0C, 0x60, 0x65, 0x0D, 0x50, 0xCF, 0x00, 0xF0, 0x1C, 0x0D};
unsigned char NwkSkey[16] = {0x01, 0x10, 0xFF, 0x00, 0x60, 0xBA, 0x0A, 0xE0, 0x0F, 0x0A, 0x60, 0x6B, 0x0A, 0x50, 0x8F, 0x01};
#if defined LORAWAN || defined EXTDEVADDR
unsigned char DevAddr[4] = {0x26, 0x01, 0x17, 0x21};
#else
unsigned char DevAddr[4] = {0x00, 0x00, 0x00, node_addr};
#endif
uint16_t Frame_Counter_Up = 0x0000;
unsigned char Direction = 0x00;
#endif
#ifdef WITH_LSC
#include "LSC_Encrypt.h"
#define LSC_SHOWB64
#ifdef LSC_SHOWB64
#include <Base64.h>
#endif
#define MICv2
#define MIC 4
uint8_t LSC_Nonce[16] = {0x2B, 0x7E, 0x15, 0x16, 0x28, 0xAE, 0xD2, 0xA6, 0xAB, 0xF7, 0x15, 0x88, 0x09, 0xCF, 0x4F, 0x3C};
#endif
uint8_t message[80];
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
#ifdef WITH_EEPROM
#include <EEPROM.h>
#endif
#ifdef ETSI_EUROPE_REGULATION
#define MAX_DBM 14
#elif defined SENEGAL_REGULATION
#define MAX_DBM 10
#elif defined FCC_US_REGULATION
#define MAX_DBM 14
#endif
#ifdef BAND868
#ifdef SENEGAL_REGULATION
const uint32_t DEFAULT_CHANNEL = CH_04_868;
#else
const uint32_t DEFAULT_CHANNEL = CH_10_868;
#endif
#elif defined BAND900
const uint32_t DEFAULT_CHANNEL = CH_05_900;
#elif defined BAND433
const uint32_t DEFAULT_CHANNEL = CH_00_433;
#endif
#define DEFAULT_DEST_ADDR 1
#ifdef WITH_ACK
#define NB_RETRIES 2
#endif
#ifdef LOW_POWER
#if defined __MK20DX256__ || defined __MKL26Z64__ || defined __MK64FX512__ || defined __MK66FX1M0__
#define LOW_POWER_PERIOD 60
#include <Snooze.h>
SnoozeTimer timer;
SnoozeBlock sleep_config(timer);
#else
#define LOW_POWER_PERIOD 8
#include "LowPower.h"
#ifdef __SAMD21G18A__
#include "RTCZero.h"
RTCZero rtc;
#endif
#endif
unsigned int nCycle = idlePeriodInMin * 60 / LOW_POWER_PERIOD;
#endif
unsigned long nextTransmissionTime = 0L;
#ifdef LORAWAN
int loraMode = 1;
#else
int loraMode = LORAMODE;
#endif
#ifdef WITH_EEPROM
struct sx1272config {
  uint8_t flag1;
  uint8_t flag2;
  uint8_t seq;
  uint8_t addr;
  unsigned int idle_period;
  uint8_t overwrite;
};
sx1272config my_sx1272config;
#endif
#ifdef WITH_RCVW
#define DELAY_BEFORE_RCVW 5000
long getCmdValue(int &i, char *strBuff = NULL) {
  char seqStr[7] = "******";
  int j = 0;
  while ((char)message[i] != '#' && (i < strlen((char *)message)) && j < strlen(seqStr)) {
    seqStr[j] = (char)message[i];
    i++;
    j++;
  }
  seqStr[j] = '\0';
  if (strBuff) {
    strcpy(strBuff, seqStr);
  } else
    return (atol(seqStr));
}
#endif
#ifndef STRING_LIB
char *ftoa(char *a, double f, int precision) {
  long p[] = {0, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000};
  char *ret = a;
  long heiltal = (long)f;
  itoa(heiltal, a, 10);
  while (*a != '\0')
    a++;
  *a++ = '.';
  long desimal = abs((long)((f - heiltal) * p[precision]));
  if (desimal < p[precision - 1]) {
    *a++ = '0';
  }
  itoa(desimal, a, 10);
  return ret;
}
#endif
void setup() {
  int e;
  sensor_Init();
#ifdef LOW_POWER
#ifdef __SAMD21G18A__
  rtc.begin();
#endif
#else
  digitalWrite(PIN_POWER, HIGH);
#endif
  delay(3000);
#if defined __SAMD21G18A__ && not defined ARDUINO_SAMD_FEATHER_M0
  SerialUSB.begin(38400);
#else
  Serial.begin(38400);
#endif
  PRINT_CSTSTR("%s", "LoRa temperature sensor, extended version\n");
#ifdef ARDUINO_AVR_PRO
  PRINT_CSTSTR("%s", "Arduino Pro Mini detected\n");
#endif
#ifdef ARDUINO_AVR_NANO
  PRINT_CSTSTR("%s", "Arduino Nano detected\n");
#endif
#ifdef ARDUINO_AVR_MINI
  PRINT_CSTSTR("%s", "Arduino MINI/Nexus detected\n");
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
  PRINT_CSTSTR("%s", "SAMD21G18A ARM Cortex-M0+ detected\n");
#endif
#ifdef __SAM3X8E__
  PRINT_CSTSTR("%s", "SAM3X8E ARM Cortex-M3 detected\n");
#endif
  sx1272.ON();
#ifdef WITH_EEPROM
  EEPROM.get(0, my_sx1272config);
  if (my_sx1272config.flag1 == 0x12 && my_sx1272config.flag2 == 0x35) {
    PRINT_CSTSTR("%s", "Get back previous sx1272 config\n");
    sx1272._packetNumber = my_sx1272config.seq;
    PRINT_CSTSTR("%s", "Using packet sequence number of ");
    PRINT_VALUE("%d", sx1272._packetNumber);
    PRINTLN;
#ifdef FORCE_DEFAULT_VALUE
    PRINT_CSTSTR("%s", "Forced to use default parameters\n");
    my_sx1272config.flag1 = 0x12;
    my_sx1272config.flag2 = 0x35;
    my_sx1272config.seq = sx1272._packetNumber;
    my_sx1272config.addr = node_addr;
    my_sx1272config.idle_period = idlePeriodInMin;
    my_sx1272config.overwrite = 0;
    EEPROM.put(0, my_sx1272config);
#else
    if (my_sx1272config.addr != 0 && my_sx1272config.overwrite == 1) {
      PRINT_CSTSTR("%s", "Used stored address\n");
      node_addr = my_sx1272config.addr;
    } else
      PRINT_CSTSTR("%s", "Stored node addr is null\n");
    if (my_sx1272config.idle_period != 0 && my_sx1272config.overwrite == 1) {
      PRINT_CSTSTR("%s", "Used stored idle period\n");
      idlePeriodInMin = my_sx1272config.idle_period;
    } else
      PRINT_CSTSTR("%s", "Stored idle period is null\n");
#endif
#if defined WITH_AES && not defined EXTDEVADDR && not defined LORAWAN
    DevAddr[3] = (unsigned char)node_addr;
#endif
    PRINT_CSTSTR("%s", "Using node addr of ");
    PRINT_VALUE("%d", node_addr);
    PRINTLN;
    PRINT_CSTSTR("%s", "Using idle period of ");
    PRINT_VALUE("%d", idlePeriodInMin);
    PRINTLN;
  } else {
    my_sx1272config.flag1 = 0x12;
    my_sx1272config.flag2 = 0x35;
    my_sx1272config.seq = sx1272._packetNumber;
    my_sx1272config.addr = node_addr;
    my_sx1272config.idle_period = idlePeriodInMin;
    my_sx1272config.overwrite = 0;
  }
#endif
  e = sx1272.setMode(loraMode);
  PRINT_CSTSTR("%s", "Setting Mode: state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
  sx1272._enableCarrierSense = true;
#ifdef LOW_POWER
  sx1272._RSSIonSend = false;
#endif
#ifdef LORAWAN
  e = sx1272.setSF(SF);
  PRINT_CSTSTR("%s", "Set SF to ");
  PRINT_VALUE("%d", SF);
  PRINT_CSTSTR("%s", ": state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
#ifdef BAND868
  e = sx1272.setChannel(CH_18_868);
  PRINT_CSTSTR("%s", "Set frequency to 868.1MHz: state ");
#elif defined BAND900
  float loraChannel = 923.2 * 1000000.0 * RH_LORA_FCONVERT;
  e = sx1272.setChannel(loraChannel);
  PRINT_CSTSTR("%s", "Set frequency to 923.2MHz: state ");
#elif defined BAND433
  float loraChannel = 433.175 * 1000000.0 * RH_LORA_FCONVERT;
  e = sx1272.setChannel(loraChannel);
  PRINT_CSTSTR("%s", "Set frequency to 433.175MHz: state ");
#endif
#else
  e = sx1272.setChannel(DEFAULT_CHANNEL);
  PRINT_CSTSTR("%s", "Setting Channel: state ");
#endif
  PRINT_VALUE("%d", e);
  PRINTLN;
#ifdef PABOOST
  sx1272._needPABOOST = true;
#else
#endif
  e = sx1272.setPowerDBM((uint8_t)MAX_DBM);
  PRINT_CSTSTR("%s", "Setting Power: state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
  e = sx1272.setNodeAddress(node_addr);
  PRINT_CSTSTR("%s", "Setting node addr: state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
#ifdef LORAWAN
  e = sx1272.setSyncWord(0x34);
  PRINT_CSTSTR("%s", "Set sync word to 0x34: state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
#endif
#ifdef WITH_LSC
  LSC_session_init();
#endif
  PRINT_CSTSTR("%s", "SX1272 successfully configured\n");
  delay(500);
}
void loop(void) {
  long startSend;
  long endSend;
  uint8_t app_key_offset = 0;
  int e;
  float temp;
#ifndef LOW_POWER
  if (millis() > nextTransmissionTime) {
#endif
#ifdef LOW_POWER
    digitalWrite(PIN_POWER, HIGH);
    delay(200);
#endif
    temp = 0.0;
    for (int i = 0; i < 5; i++) {
      temp += sensor_getValue();
      delay(100);
    }
#ifdef LOW_POWER
    digitalWrite(PIN_POWER, LOW);
#endif
    PRINT_CSTSTR("%s", "Mean temp is ");
    temp = temp / 5;
    PRINT_VALUE("%f", temp);
    PRINTLN;
#if defined WITH_APPKEY && not defined LORAWAN
    app_key_offset = sizeof(my_appKey);
    memcpy(message, my_appKey, app_key_offset);
#endif
    uint8_t r_size;
#ifdef STRING_LIB
    r_size = sprintf((char *)message + app_key_offset, "\\!%s/%s", nomenclature_str, String(temp).c_str());
#else
  char float_str[10];
  ftoa(float_str, temp, 2);
  r_size = sprintf((char *)message + app_key_offset, "\\!%s/%s", nomenclature_str, float_str);
#endif
    PRINT_CSTSTR("%s", "Sending ");
    PRINT_STR("%s", (char *)(message + app_key_offset));
    PRINTLN;
    PRINT_CSTSTR("%s", "Real payload size is ");
    PRINT_VALUE("%d", r_size);
    PRINTLN;
    int pl = r_size + app_key_offset;
    uint8_t p_type = PKT_TYPE_DATA;
#if defined WITH_AES || defined WITH_LSC
    p_type = p_type | PKT_FLAG_DATA_ENCRYPTED;
#endif
#ifdef WITH_APPKEY
    p_type = p_type | PKT_FLAG_DATA_WAPPKEY;
#endif
    sx1272.setPacketType(p_type);
#ifdef WITH_AES
    PRINT_STR("%s", (char *)(message + app_key_offset));
    PRINTLN;
    PRINT_CSTSTR("%s", "plain payload hex\n");
    for (int i = 0; i < pl; i++) {
      if (message[i] < 16)
        PRINT_CSTSTR("%s", "0");
      PRINT_HEX("%X", message[i]);
      PRINT_CSTSTR("%s", " ");
    }
    PRINTLN;
    PRINT_CSTSTR("%s", "Encrypting\n");
    PRINT_CSTSTR("%s", "encrypted payload\n");
    Encrypt_Payload((unsigned char *)message, pl, Frame_Counter_Up, Direction);
    for (int i = 0; i < pl; i++) {
      if (message[i] < 16)
        PRINT_CSTSTR("%s", "0");
      PRINT_HEX("%X", message[i]);
      PRINT_CSTSTR("%s", " ");
    }
    PRINTLN;
    unsigned char LORAWAN_Data[80];
    unsigned char LORAWAN_Package_Length;
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
    LORAWAN_Package_Length = 9;
    for (int i = 0; i < r_size + app_key_offset; i++) {
      LORAWAN_Data[LORAWAN_Package_Length + i] = message[i];
    }
    LORAWAN_Package_Length = LORAWAN_Package_Length + r_size + app_key_offset;
    PRINT_CSTSTR("%s", "calculate MIC with NwkSKey\n");
    Calculate_MIC(LORAWAN_Data, MIC, LORAWAN_Package_Length, Frame_Counter_Up, Direction);
    for (int i = 0; i < 4; i++) {
      LORAWAN_Data[i + LORAWAN_Package_Length] = MIC[i];
    }
    LORAWAN_Package_Length = LORAWAN_Package_Length + 4;
    PRINT_CSTSTR("%s", "transmitted LoRaWAN-like packet:\n");
    PRINT_CSTSTR("%s", "MHDR[1] | DevAddr[4] | FCtrl[1] | FCnt[2] | FPort[1] | EncryptedPayload | MIC[4]\n");
    for (int i = 0; i < LORAWAN_Package_Length; i++) {
      if (LORAWAN_Data[i] < 16)
        PRINT_CSTSTR("%s", "0");
      PRINT_HEX("%X", LORAWAN_Data[i]);
      PRINT_CSTSTR("%s", " ");
    }
    PRINTLN;
    memcpy(message, LORAWAN_Data, LORAWAN_Package_Length);
    pl = LORAWAN_Package_Length;
#ifdef AES_SHOWB64
    int b64_encodedLen = base64_enc_len(pl) + 1;
    char b64_encoded[b64_encodedLen];
    base64_encode(b64_encoded, (char *)message, pl);
    PRINT_CSTSTR("%s", "[base64 LoRaWAN HEADER+CIPHER+MIC]:");
    PRINT_STR("%s", b64_encoded);
    PRINTLN;
#endif
#ifdef LORAWAN
    PRINT_CSTSTR("%s", "end-device uses native LoRaWAN packet format\n");
    sx1272._rawFormat = true;
#else
    PRINT_CSTSTR("%s", "end-device uses encapsulated LoRaWAN packet format only for encryption\n");
#endif
    Frame_Counter_Up++;
#endif
#ifdef WITH_LSC
    PRINT_STR("%s", (char *)(message + app_key_offset));
    PRINTLN;
    PRINT_CSTSTR("%s", "[PLAIN HEX]:\n");
    for (int i = 0; i < pl; i++) {
      if (message[i] < 16)
        PRINT_CSTSTR("%s", "0");
      PRINT_HEX("%X", message[i]);
      PRINT_CSTSTR("%s", " ");
    }
    PRINTLN;
    unsigned char cipher[80];
    PRINT_CSTSTR("%s", "Encrypting\n");
    LSC_encrypt(message, cipher + OFFSET_PAYLOADLENGTH, pl, sx1272._packetNumber, LSC_ENCRYPT);
    PRINT_CSTSTR("%s", "[CIPHER]:\n");
    for (int i = 0; i < pl; i++) {
      if (cipher[OFFSET_PAYLOADLENGTH + i] < 16)
        PRINT_CSTSTR("%s", "0");
      PRINT_HEX("%X", cipher[OFFSET_PAYLOADLENGTH + i]);
      PRINT_CSTSTR("%s", " ");
    }
    PRINTLN;
    cipher[0] = DEFAULT_DEST_ADDR;
    cipher[1] = p_type;
    cipher[2] = node_addr;
    cipher[3] = sx1272._packetNumber;
    PRINT_CSTSTR("%s", "[HEADER+CIPHER]:\n");
    for (int i = 0; i < pl + OFFSET_PAYLOADLENGTH; i++) {
      if (cipher[i] < 16)
        PRINT_CSTSTR("%s", "0");
      PRINT_HEX("%X", cipher[i]);
      if (i == OFFSET_PAYLOADLENGTH - 1)
        PRINT_CSTSTR("%s", "|");
      else
        PRINT_CSTSTR("%s", " ");
    }
    PRINTLN;
    LSC_setMIC(cipher, message, pl + OFFSET_PAYLOADLENGTH, sx1272._packetNumber + 1);
    PRINT_CSTSTR("%s", "[encrypted HEADER+CIPHER]:\n");
    for (int i = 0; i < pl + OFFSET_PAYLOADLENGTH; i++) {
      if (message[i] < 16)
        PRINT_CSTSTR("%s", "0");
      PRINT_HEX("%X", message[i]);
      PRINT_CSTSTR("%s", " ");
    }
    PRINTLN;
    PRINT_CSTSTR("%s", "[MIC]:\n");
    for (int i = 0; i < 4; i++) {
      if (cipher[pl + OFFSET_PAYLOADLENGTH + i] < 16)
        PRINT_CSTSTR("%s", "0");
      PRINT_HEX("%X", cipher[pl + OFFSET_PAYLOADLENGTH + i]);
      PRINT_CSTSTR("%s", " ");
    }
    PRINTLN;
    PRINT_CSTSTR("%s", "transmitted packet:\n");
    PRINT_CSTSTR("%s", "CIPHER | MIC[4]\n");
    for (int i = 0; i < pl + MIC; i++) {
      if (cipher[OFFSET_PAYLOADLENGTH + i] < 16)
        PRINT_CSTSTR("%s", "0");
      PRINT_HEX("%X", cipher[OFFSET_PAYLOADLENGTH + i]);
      if (i == pl - 1)
        PRINT_CSTSTR("%s", "|");
      else
        PRINT_CSTSTR("%s", " ");
    }
    PRINTLN;
    memcpy(message, cipher + OFFSET_PAYLOADLENGTH, pl + MIC);
    pl = pl + MIC;
#ifdef LSC_SHOWB64
    int b64_encodedLen = base64_enc_len(pl) + 1;
    char b64_encoded[b64_encodedLen];
    base64_encode(b64_encoded, (char *)message, pl);
    PRINT_CSTSTR("%s", "[base64 CIPHER+MIC]:");
    PRINT_STR("%s", b64_encoded);
    PRINTLN;
#endif
#endif
    sx1272.CarrierSense();
    startSend = millis();
#ifdef WITH_ACK
    int n_retry = NB_RETRIES;
    do {
      e = sx1272.sendPacketTimeoutACK(DEFAULT_DEST_ADDR, message, pl);
      if (e == 3)
        PRINT_CSTSTR("%s", "No ACK");
      n_retry--;
      if (n_retry)
        PRINT_CSTSTR("%s", "Retry");
      else
        PRINT_CSTSTR("%s", "Abort");
    } while (e && n_retry);
#else
  e = sx1272.sendPacketTimeout(DEFAULT_DEST_ADDR, message, pl);
#endif
    endSend = millis();
#ifdef LORAWAN
    sx1272._rawFormat = false;
#endif
#ifdef WITH_EEPROM
    my_sx1272config.seq = sx1272._packetNumber;
    EEPROM.put(0, my_sx1272config);
#endif
    PRINT_CSTSTR("%s", "LoRa pkt size ");
    PRINT_VALUE("%d", pl);
    PRINTLN;
    PRINT_CSTSTR("%s", "LoRa pkt seq ");
    PRINT_VALUE("%d", sx1272.packet_sent.packnum);
    PRINTLN;
    PRINT_CSTSTR("%s", "LoRa Sent in ");
    PRINT_VALUE("%ld", endSend - startSend);
    PRINTLN;
    PRINT_CSTSTR("%s", "LoRa Sent w/CAD in ");
    PRINT_VALUE("%ld", endSend - sx1272._startDoCad);
    PRINTLN;
    PRINT_CSTSTR("%s", "Packet sent, state ");
    PRINT_VALUE("%d", e);
    PRINTLN;
#ifdef WITH_RCVW
    PRINT_CSTSTR("%s", "Wait for ");
    PRINT_VALUE("%d", DELAY_BEFORE_RCVW - 1000);
    PRINTLN;
    delay(DELAY_BEFORE_RCVW - 1000);
    PRINT_CSTSTR("%s", "Wait for incoming packet\n");
    e = sx1272.receivePacketTimeout(10000);
    if (!e) {
      int i = 0;
      int cmdValue;
      uint8_t tmp_length;
      sx1272.getSNR();
      sx1272.getRSSIpacket();
      tmp_length = sx1272._payloadlength;
      sprintf((char *)message, "^p%d,%d,%d,%d,%d,%d,%d\n", sx1272.packet_received.dst, sx1272.packet_received.type, sx1272.packet_received.src, sx1272.packet_received.packnum, tmp_length, sx1272._SNR, sx1272._RSSIpacket);
      PRINT_STR("%s", (char *)message);
      for (; i < tmp_length; i++) {
        PRINT_STR("%c", (char)sx1272.packet_received.data[i]);
        message[i] = (char)sx1272.packet_received.data[i];
      }
      message[i] = (char)'\0';
      PRINTLN;
      FLUSHOUTPUT;
      i = 0;
      if (message[i] == '/' && message[i + 1] == '@') {
        PRINT_CSTSTR("%s", "Parsing command\n");
        i = i + 2;
        switch ((char)message[i]) {
#ifndef LORAWAN
        case 'A':
          i++;
          cmdValue = getCmdValue(i);
          if (cmdValue > 255)
            cmdValue = 255;
          if (cmdValue < 2)
            cmdValue = node_addr;
          node_addr = cmdValue;
#ifdef WITH_AES
          DevAddr[3] = (unsigned char)node_addr;
#endif
          PRINT_CSTSTR("%s", "Set LoRa node addr to ");
          PRINT_VALUE("%d", node_addr);
          PRINTLN;
          e = sx1272.setNodeAddress(node_addr);
          PRINT_CSTSTR("%s", "Setting LoRa node addr: state ");
          PRINT_VALUE("%d", e);
          PRINTLN;
#ifdef WITH_EEPROM
          my_sx1272config.addr = node_addr;
          my_sx1272config.overwrite = 1;
          EEPROM.put(0, my_sx1272config);
#endif
          break;
#endif
        case 'I':
          i++;
          cmdValue = getCmdValue(i);
          if (cmdValue < 1)
            cmdValue = idlePeriodInMin;
          idlePeriodInMin = cmdValue;
          PRINT_CSTSTR("%s", "Set duty-cycle to ");
          PRINT_VALUE("%d", idlePeriodInMin);
          PRINTLN;
#ifdef WITH_EEPROM
          my_sx1272config.idle_period = idlePeriodInMin;
          my_sx1272config.overwrite = 1;
          EEPROM.put(0, my_sx1272config);
#endif
          break;
        default:
          PRINT_CSTSTR("%s", "Unrecognized cmd\n");
          break;
        }
      }
    } else
      PRINT_CSTSTR("%s", "No packet\n");
#endif
#if defined LOW_POWER && not defined _VARIANT_ARDUINO_DUE_X_
    PRINT_CSTSTR("%s", "Switch to power saving mode\n");
    e = sx1272.setSleepMode();
    if (!e)
      PRINT_CSTSTR("%s", "Successfully switch LoRa module in sleep mode\n");
    else
      PRINT_CSTSTR("%s", "Could not switch LoRa module in sleep mode\n");
    FLUSHOUTPUT
    delay(50);
#ifdef __SAMD21G18A__
    rtc.setTime(17, 0, 0);
    rtc.setDate(1, 1, 2000);
    rtc.setAlarmTime(17, idlePeriodInMin, 0);
    rtc.enableAlarm(rtc.MATCH_HHMMSS);
    rtc.standbyMode();
    LowPower.standby();
    PRINT_CSTSTR("%s", "SAMD21G18A wakes up from standby\n");
    FLUSHOUTPUT
#else
    nCycle = idlePeriodInMin * 60 / LOW_POWER_PERIOD + random(2, 4);
#if defined __MK20DX256__ || defined __MKL26Z64__ || defined __MK64FX512__ || defined __MK66FX1M0__
    timer.setTimer(LOW_POWER_PERIOD * 1000 + random(1, 5) * 1000);
    nCycle = idlePeriodInMin * 60 / LOW_POWER_PERIOD;
#endif
    for (int i = 0; i < nCycle; i++) {
#if defined ARDUINO_AVR_PRO || defined ARDUINO_AVR_NANO || defined ARDUINO_AVR_UNO || defined ARDUINO_AVR_MINI || defined __AVR_ATmega32U4__
      LowPower.powerDown(SLEEP_8S, ADC_OFF, BOD_OFF);
#elif defined ARDUINO_AVR_MEGA2560
      LowPower.powerDown(SLEEP_8S, ADC_OFF, BOD_OFF);
#elif defined __MK20DX256__ || defined __MKL26Z64__ || defined __MK64FX512__ || defined __MK66FX1M0__
#ifdef LOW_POWER_HIBERNATE
      Snooze.hibernate(sleep_config);
#else
      Snooze.deepSleep(sleep_config);
#endif
#else
      delay(LOW_POWER_PERIOD * 1000);
#endif
      PRINT_CSTSTR("%s", ".");
      FLUSHOUTPUT
      delay(10);
    }
    delay(50);
#endif
#else
  PRINT_VALUE("%ld", nextTransmissionTime);
  PRINTLN;
  PRINT_CSTSTR("%s", "Will send next value at\n");
  nextTransmissionTime = millis() + (unsigned long)idlePeriodInMin * 60 * 1000 + (unsigned long)random(15, 60) * 1000;
  PRINT_VALUE("%ld", nextTransmissionTime);
  PRINTLN;
}
#endif
  }

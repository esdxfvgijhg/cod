
#include "DHT22_Humidity.h"
#include "DHT22_Temperature.h"
#include "SX1272.h"
#include "Sensor.h"
#include <SPI.h>
#define WITH_EEPROM
#define SERIAL_MONITOR
#define LOW_POWER
#define LOW_POWER_HIBERNATE
#define OLED
#define ETSI_EUROPE_REGULATION
#define BAND868
#define PABOOST
#define LORAMODE 1
uint16_t node_addr = 8;
uint16_t idlePeriodInMin = 10;
#ifdef WITH_APPKEY
uint8_t my_appKey[4] = {5, 6, 7, 8};
#endif
uint8_t message[80];
const int number_of_sensors = 2;
Sensor *sensor_ptrs[number_of_sensors];
#ifdef SERIAL_MONITOR
#define PRINTLN Serial.println("")
#define PRINT_CSTSTR(fmt, param) Serial.print(F(param))
#define PRINT_STR(fmt, param) Serial.print(param)
#define PRINT_VALUE(fmt, param) Serial.print(param)
#define PRINT_HEX(fmt, param) Serial.print(param, HEX)
#define FLUSHOUTPUT Serial.flush();
#else
#define PRINTLN
#define PRINT_CSTSTR(fmt, param)
#define PRINT_STR(fmt, param)
#define PRINT_VALUE(fmt, param)
#define PRINT_HEX(fmt, param)
#define FLUSHOUTPUT
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
const uint32_t DEFAULT_CHANNEL = CH_08_900;
#elif defined BAND433
const uint32_t DEFAULT_CHANNEL = CH_00_433;
#endif
#ifdef OLED
#include <U8x8lib.h>
#define OLED_PWR_PIN 8
#if defined ARDUINO_Heltec_WIFI_LoRa_32 || defined ARDUINO_WIFI_LoRa_32 || defined HELTEC_LORA
U8X8_SSD1306_128X64_NONAME_SW_I2C u8x8(15, 4, 16);
#elif defined ESP8266 || defined ARDUINO_ESP8266_ESP01
U8X8_SSD1306_128X64_NONAME_SW_I2C u8x8(12, 14, U8X8_PIN_NONE);
#else
U8X8_SSD1306_128X64_NONAME_SW_I2C u8x8(A5, A4, U8X8_PIN_NONE);
#endif
char oled_msg[20];
#endif
#define DEFAULT_DEST_ADDR 1
#ifdef WITH_ACK
#define NB_RETRIES 2
#endif
#if defined ARDUINO_AVR_PRO || defined ARDUINO_AVR_MINI || defined ARDUINO_SAM_DUE || defined __MK20DX256__ || defined __MKL26Z64__ || defined __MK64FX512__ || defined __MK66FX1M0__ || defined __SAMD21G18A__
#define TEMP_SCALE 3300.0
#else
#define TEMP_SCALE 5000.0
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
#endif
unsigned int nCycle = idlePeriodInMin * 60 / LOW_POWER_PERIOD;
#endif
#ifdef WITH_AES
#include "AES-128_V10.h"
#include "Encrypt_V31.h"
unsigned char AppSkey[16] = {0x2B, 0x7E, 0x15, 0x16, 0x28, 0xAE, 0xD2, 0xA6, 0xAB, 0xF7, 0x15, 0x88, 0x09, 0xCF, 0x4F, 0x3C};
unsigned char NwkSkey[16] = {0x2B, 0x7E, 0x15, 0x16, 0x28, 0xAE, 0xD2, 0xA6, 0xAB, 0xF7, 0x15, 0x88, 0x09, 0xCF, 0x4F, 0x3C};
unsigned char DevAddr[4] = {0x00, 0x00, 0x00, node_addr};
uint16_t Frame_Counter_Up = 0x0000;
unsigned char Direction = 0x00;
#endif
unsigned long nextTransmissionTime = 0L;
int loraMode = LORAMODE;
#ifdef WITH_EEPROM
struct sx1272config {
  uint8_t flag1;
  uint8_t flag2;
  uint8_t seq;
};
sx1272config my_sx1272config;
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
#ifdef LOW_POWER
  bool low_power_status = IS_LOWPOWER;
#else
  bool low_power_status = IS_NOT_LOWPOWER;
#endif
  sensor_ptrs[0] = new DHT22_Temperature("TC", IS_NOT_ANALOG, IS_CONNECTED, low_power_status, A0, 9);
  sensor_ptrs[1] = new DHT22_Humidity("HU", IS_NOT_ANALOG, IS_CONNECTED, low_power_status, A0, 9);
  delay(3000);
  Serial.begin(38400);
#ifdef OLED_PWR_PIN
  pinMode(OLED_PWR_PIN, OUTPUT);
  digitalWrite(OLED_PWR_PIN, HIGH);
#endif
#ifdef OLED
  u8x8.begin();
  u8x8.setFont(u8x8_font_chroma48medium8_r);
  u8x8.drawString(0, 1, "Arduino LoRa DHT");
#endif
  PRINT_CSTSTR("%s", "LoRa DHT node\n");
#ifdef ARDUINO_AVR_PRO
  PRINT_CSTSTR("%s", "Arduino Pro Mini\n");
#endif
#ifdef __AVR_ATmega328P__
  PRINT_CSTSTR("%s", "ATmega328P\n");
#endif
  sx1272.ON();
#ifdef WITH_EEPROM
  EEPROM.get(0, my_sx1272config);
  if (my_sx1272config.flag1 == 0x12 && my_sx1272config.flag2 == 0x35) {
    PRINT_CSTSTR("%s", "EEPROM\n");
    sx1272._packetNumber = my_sx1272config.seq;
    PRINT_CSTSTR("%s", "Using seq of ");
    PRINT_VALUE("%d", sx1272._packetNumber);
    PRINTLN;
  } else {
    my_sx1272config.flag1 = 0x12;
    my_sx1272config.flag2 = 0x35;
    my_sx1272config.seq = sx1272._packetNumber;
  }
#endif
  e = sx1272.setMode(loraMode);
  PRINT_CSTSTR("%s", "Set mode: state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
  sx1272._enableCarrierSense = true;
#ifdef LOW_POWER
  sx1272._RSSIonSend = false;
#endif
  e = sx1272.setChannel(DEFAULT_CHANNEL);
  PRINT_CSTSTR("%s", "Channel: state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
#ifdef PABOOST
  sx1272._needPABOOST = true;
#else
#endif
  e = sx1272.setPowerDBM((uint8_t)MAX_DBM);
  PRINT_CSTSTR("%s", "Power: state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
  e = sx1272.setNodeAddress(node_addr);
  PRINT_CSTSTR("%s", "node addr: state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
  PRINT_CSTSTR("%s", "SX1272 configured\n");
  delay(500);
}
void loop(void) {
  long startSend;
  long endSend;
  uint8_t app_key_offset = 0;
  int e;
  bool valid_r_mic = true;
  bool trigger_sensor = false;
  uint8_t r_size;
#ifndef LOW_POWER
  if (millis() > nextTransmissionTime) {
#endif
#if defined WITH_APPKEY && not defined LORAWAN
    app_key_offset = sizeof(my_appKey);
    memcpy(message, my_appKey, app_key_offset);
#endif
    strcpy((char *)message + app_key_offset, "\\!");
    for (int i = 0; i < number_of_sensors; i++) {
      if (sensor_ptrs[i]->get_is_connected() || sensor_ptrs[i]->has_fake_data()) {
#ifdef STRING_LIB
        if (i == 0) {
          r_size = sprintf((char *)message + app_key_offset, "%s%s/%s", (char *)message + app_key_offset, sensor_ptrs[i]->get_nomenclature(), String(sensor_ptrs[i]->get_value()).c_str());
        } else {
          r_size = sprintf((char *)message + app_key_offset, "%s/%s/%s", (char *)message + app_key_offset, sensor_ptrs[i]->get_nomenclature(), String(sensor_ptrs[i]->get_value()).c_str());
        }
#else
      char float_str[10];
      ftoa(float_str, sensor_ptrs[i]->get_value(), 2);
      if (i == 0) {
        r_size = sprintf((char *)message + app_key_offset, "%s%s/%s", (char *)message + app_key_offset, sensor_ptrs[i]->get_nomenclature(), float_str);
      } else {
        r_size = sprintf((char *)message + app_key_offset, "%s/%s/%s", (char *)message + app_key_offset, sensor_ptrs[i]->get_nomenclature(), float_str);
      }
#endif
      }
    }
    PRINTLN;
    PRINT_CSTSTR("%s", "Payload ");
    PRINT_STR("%s", (char *)(message + app_key_offset));
    PRINTLN;
#ifdef OLED
    u8x8.clearLine(3);
    sprintf(oled_msg, "%s", (char *)(message + app_key_offset + 2));
    u8x8.drawString(0, 3, oled_msg);
#endif
    PRINT_CSTSTR("%s", "Size is ");
    PRINT_VALUE("%d", r_size);
    PRINTLN;
    int pl = r_size + app_key_offset;
    uint8_t p_type = PKT_TYPE_DATA;
#if defined WITH_AES
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
    Calculate_MIC(LORAWAN_Data, MIC, LORAWAN_Package_Length, Frame_Counter_Up, Direction);
    for (int i = 0; i < 4; i++) {
      LORAWAN_Data[i + LORAWAN_Package_Length] = MIC[i];
    }
    LORAWAN_Package_Length = LORAWAN_Package_Length + 4;
    PRINT_CSTSTR("%s", "MHDR[1] | DevAddr[4] | FCtrl[1] | FCnt[2] | FPort[1] | Payload | MIC[4]\n");
    for (int i = 0; i < LORAWAN_Package_Length; i++) {
      if (LORAWAN_Data[i] < 16)
        PRINT_CSTSTR("%s", "0");
      PRINT_HEX("%X", LORAWAN_Data[i]);
      PRINT_CSTSTR("%s", " ");
    }
    PRINTLN;
    memcpy(message, LORAWAN_Data, LORAWAN_Package_Length);
    pl = LORAWAN_Package_Length;
    Frame_Counter_Up++;
    p_type = p_type | PKT_FLAG_DATA_ENCRYPTED;
#endif
#ifdef WITH_APPKEY
    p_type = p_type | PKT_FLAG_DATA_WAPPKEY;
#endif
    sx1272.setPacketType(p_type);
    sx1272.CarrierSense();
    startSend = millis();
    e = sx1272.sendPacketTimeout(DEFAULT_DEST_ADDR, message, pl);
    endSend = millis();
#ifdef WITH_EEPROM
    my_sx1272config.seq = sx1272._packetNumber;
    EEPROM.put(0, my_sx1272config);
#endif
    PRINT_CSTSTR("%s", "pkt size ");
    PRINT_VALUE("%d", pl);
    PRINTLN;
    PRINT_CSTSTR("%s", "pkt seq ");
    PRINT_VALUE("%d", sx1272.packet_sent.packnum);
    PRINTLN;
    PRINT_CSTSTR("%s", "Sent in ");
    PRINT_VALUE("%ld", endSend - startSend);
    PRINTLN;
    PRINT_CSTSTR("%s", "Sent w/CAD in ");
    PRINT_VALUE("%ld", endSend - sx1272._startDoCad);
    PRINTLN;
    PRINT_CSTSTR("%s", "Sent, state ");
    PRINT_VALUE("%d", e);
    PRINTLN;
#if defined OLED
    u8x8.clearLine(4);
    sprintf(oled_msg, "LoRa Sent: %d", e);
    u8x8.drawString(0, 4, oled_msg);
#endif
#ifdef LOW_POWER
    PRINT_CSTSTR("%s", "To sleep mode for ");
    PRINT_VALUE("%d", idlePeriodInMin);
    PRINT_CSTSTR("%s", "mins");
    PRINTLN;
    e = sx1272.setSleepMode();
#if defined OLED
    u8x8.clearLine(5);
    u8x8.drawString(0, 5, "Sleep...");
#endif
    PRINT_CSTSTR("%s", "radio sleep: ");
    if (!e)
      PRINT_CSTSTR("%s", "ok\n");
    else
      PRINT_CSTSTR("%s", "err\n");
    FLUSHOUTPUT
    delay(50);
    nCycle = idlePeriodInMin * 60 / LOW_POWER_PERIOD + random(1, 2);
    for (int i = 0; i < nCycle; i++) {
#if defined ARDUINO_AVR_PRO || defined ARDUINO_AVR_NANO || defined ARDUINO_AVR_UNO || defined ARDUINO_AVR_MINI || defined __AVR_ATmega32U4__
      LowPower.powerDown(SLEEP_8S, ADC_OFF, BOD_OFF);
#else
      delay(LOW_POWER_PERIOD * 1000);
#endif
      PRINT_CSTSTR("%s", ".");
      FLUSHOUTPUT
      delay(10);
    }
    delay(50);
#else
  PRINT_VALUE("%ld", nextTransmissionTime);
  PRINTLN;
  PRINT_CSTSTR("%s", "Will send next value at\n");
  nextTransmissionTime = millis() + (unsigned long)idlePeriodInMin * 60 * 1000 + (unsigned long)random(8, 16) * 1000;
  PRINT_VALUE("%ld", nextTransmissionTime);
  PRINTLN;
}
#endif
  }

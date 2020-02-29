
#include "SX1272.h"
#include "my_temp_sensor_code.h"
#include <SPI.h>
#define WITH_EEPROM
#define STRING_LIB
#define LOW_POWER
#define LOW_POWER_HIBERNATE
#if defined ARDUINO_SAM_DUE || defined __SAMD21G18A__
#undef WITH_EEPROM
#endif
#if defined ARDUINO_SAM_DUE
#undef LOW_POWER
#endif
#define ETSI_EUROPE_REGULATION
#define BAND868
#define PABOOST
#define node_addr 8
#define LORAMODE 1
unsigned int idlePeriodInMin = 10;
#ifdef WITH_APPKEY
uint8_t my_appKey[4] = {5, 6, 7, 8};
#endif
uint8_t message[50];
#if defined __SAMD21G18A__ && not defined ARDUINO_SAMD_FEATHER_M0
#define PRINTLN SerialUSB.println("")
#define PRINT_CSTSTR(fmt, param) SerialUSB.print(F(param))
#define PRINT_STR(fmt, param) SerialUSB.print(param)
#define PRINT_VALUE(fmt, param) SerialUSB.print(param)
#define FLUSHOUTPUT SerialUSB.flush();
#else
#define PRINTLN Serial.println("")
#define PRINT_CSTSTR(fmt, param) Serial.print(F(param))
#define PRINT_STR(fmt, param) Serial.print(param)
#define PRINT_VALUE(fmt, param) Serial.print(param)
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
#elif defined ARDUINO_ESP8266_ESP01 || defined ARDUINO_ESP8266_NODEMCU
#define LOW_POWER_PERIOD 60
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
  PRINT_CSTSTR("%s", "Simple LoRa temperature sensor\n");
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
#if defined ARDUINO_ESP8266_ESP01 || defined ARDUINO_ESP8266_NODEMCU
  PRINT_CSTSTR("%s", "Expressif ESP8266 detected\n");
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
#if defined ARDUINO_ESP8266_ESP01 || defined ARDUINO_ESP8266_NODEMCU
  EEPROM.begin(512);
#endif
  EEPROM.get(0, my_sx1272config);
  if (my_sx1272config.flag1 == 0x12 && my_sx1272config.flag2 == 0x34) {
    PRINT_CSTSTR("%s", "Get back previous sx1272 config\n");
    sx1272._packetNumber = my_sx1272config.seq;
    PRINT_CSTSTR("%s", "Using packet sequence number of ");
    PRINT_VALUE("%d", sx1272._packetNumber);
    PRINTLN;
  } else {
    my_sx1272config.flag1 = 0x12;
    my_sx1272config.flag2 = 0x34;
    my_sx1272config.seq = sx1272._packetNumber;
  }
#endif
  e = sx1272.setMode(loraMode);
  PRINT_CSTSTR("%s", "Setting Mode: state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
#ifdef MY_FREQUENCY
  e = sx1272.setChannel(MY_FREQUENCY * 1000000.0 * RH_LORA_FCONVERT);
  PRINT_CSTSTR("%s", "Setting customized frequency: ");
  PRINT_VALUE("%f", MY_FREQUENCY);
  PRINTLN;
#else
  e = sx1272.setChannel(DEFAULT_CHANNEL);
#endif
  PRINT_CSTSTR("%s", "Setting Channel: state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
  sx1272._enableCarrierSense = true;
#ifdef LOW_POWER
  sx1272._RSSIonSend = false;
#endif
#ifdef USE_LORAWAN_SW
  e = sx1272.setSyncWord(0x34);
  PRINT_CSTSTR("%s", "Set sync word to 0x34: state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
#endif
#ifdef PABOOST
  sx1272._needPABOOST = true;
#endif
  e = sx1272.setPowerDBM((uint8_t)MAX_DBM);
  PRINT_CSTSTR("%s", "Setting Power: state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
  e = sx1272.setNodeAddress(node_addr);
  PRINT_CSTSTR("%s", "Setting node addr: state ");
  PRINT_VALUE("%d", e);
  PRINTLN;
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
#ifdef WITH_APPKEY
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
    sx1272.CarrierSense();
    startSend = millis();
#ifdef WITH_APPKEY
    sx1272.setPacketType(PKT_TYPE_DATA | PKT_FLAG_DATA_WAPPKEY);
#else
  sx1272.setPacketType(PKT_TYPE_DATA);
#endif
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
#ifdef WITH_EEPROM
    my_sx1272config.seq = sx1272._packetNumber;
    EEPROM.put(0, my_sx1272config);
#if defined ARDUINO_ESP8266_ESP01 || defined ARDUINO_ESP8266_NODEMCU
    EEPROM.commit();
#endif
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
    PRINT_CSTSTR("%s", "Remaining ToA is ");
    PRINT_VALUE("%d", sx1272.getRemainingToA());
    PRINTLN;
#if defined LOW_POWER && not defined ARDUINO_SAM_DUE
    PRINT_CSTSTR("%s", "Switch to power saving mode\n");
    e = sx1272.setSleepMode();
    if (!e)
      PRINT_CSTSTR("%s", "Successfully switch LoRa module in sleep mode\n");
    else
      PRINT_CSTSTR("%s", "Could not switch LoRa module in sleep mode\n");
    FLUSHOUTPUT
#ifdef LOW_POWER_TEST
    delay(10000);
#else
    delay(50);
#endif
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
#if defined __MK20DX256__ || defined __MKL26Z64__ || defined __MK64FX512__ || defined __MK66FX1M0__
    timer.setTimer(LOW_POWER_PERIOD * 1000);
#endif
    nCycle = idlePeriodInMin * 60 / LOW_POWER_PERIOD;
    for (uint8_t i = 0; i < nCycle; i++) {
#if defined ARDUINO_AVR_MEGA2560 || defined ARDUINO_AVR_PRO || defined ARDUINO_AVR_NANO || defined ARDUINO_AVR_UNO || defined ARDUINO_AVR_MINI || defined __AVR_ATmega32U4__
      LowPower.powerDown(SLEEP_8S, ADC_OFF, BOD_OFF);
#elif defined __MK20DX256__ || defined __MKL26Z64__ || defined __MK64FX512__ || defined __MK66FX1M0__
#ifdef LOW_POWER_HIBERNATE
      Snooze.hibernate(sleep_config);
#else
      Snooze.deepSleep(sleep_config);
#endif
#elif defined ARDUINO_ESP8266_ESP01 || defined ARDUINO_ESP8266_NODEMCU
      ESP.deepSleep(LOW_POWER_PERIOD * 1000 * 1000);
#else
      delay(LOW_POWER_PERIOD * 1000);
#endif
      PRINT_CSTSTR("%s", ".");
      FLUSHOUTPUT
      delay(1);
    }
#endif
#else
  PRINT_VALUE("%ld", nextTransmissionTime);
  PRINTLN;
  PRINT_CSTSTR("%s", "Will send next value at\n");
  nextTransmissionTime = millis() + (unsigned long)idlePeriodInMin * 60 * 1000;
  PRINT_VALUE("%ld", nextTransmissionTime);
  PRINTLN;
}
#endif
  }


#include "SX1272.h"
#include "my_demo_sensor_code.h"
#define PABOOST
#define node_addr 9
#define ETSI_EUROPE_REGULATION
#ifdef ETSI_EUROPE_REGULATION
#define MAX_DBM 14
#elif defined SENEGAL_REGULATION
#define MAX_DBM 10
#elif defined FCC_US_REGULATION
#define MAX_DBM 14
#endif
#ifdef OLED
#define OLED_PWR_PIN 8
#include <U8x8lib.h>
#if defined ARDUINO_Heltec_WIFI_LoRa_32 || defined ARDUINO_WIFI_LoRa_32 || defined HELTEC_LORA
U8X8_SSD1306_128X64_NONAME_SW_I2C u8x8(15, 4, 16);
#elif defined ESP8266 || defined ARDUINO_ESP8266_ESP01
U8X8_SSD1306_128X64_NONAME_SW_I2C u8x8(12, 14, U8X8_PIN_NONE);
#else
U8X8_SSD1306_128X64_NONAME_SW_I2C u8x8(A5, A4, U8X8_PIN_NONE);
#endif
char oled_msg[20];
#endif
#define FLOAT_TEMP
#define DEFAULT_DEST_ADDR 1
#define LORAMODE 1
double sensor_value;
unsigned long nextTransmissionTime = 0L;
char float_str[20];
uint8_t message[100];
int loraMode = LORAMODE;
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
void setup() {
  int e;
  delay(3000);
  Serial.begin(38400);
  Serial.println(F("Simple LoRa sensor demo"));
#ifdef OLED
  u8x8.begin();
  u8x8.setFont(u8x8_font_chroma48medium8_r);
  u8x8.drawString(0, 1, "Simple TempDemo");
  u8x8.drawString(0, 2, "LoRa mode 1");
#endif
#if defined ARDUINO_Heltec_WIFI_LoRa_32 || defined ARDUINO_WIFI_LoRa_32 || defined HELTEC_LORA
  sx1272.setCSPin(18);
#endif
  sx1272.ON();
  e = sx1272.setMode(loraMode);
  Serial.print(F("Setting Mode: state "));
  Serial.println(e, DEC);
  sx1272._enableCarrierSense = true;
  e = sx1272.setChannel(CH_10_868);
  Serial.print(F("Setting Channel: state "));
  Serial.println(e, DEC);
#ifdef PABOOST
  sx1272._needPABOOST = true;
#else
#endif
  e = sx1272.setPowerDBM((uint8_t)MAX_DBM);
  Serial.print(F("Setting Power: state "));
  Serial.println(e);
  e = sx1272.setNodeAddress(node_addr);
  Serial.print(F("Setting node addr: state "));
  Serial.println(e, DEC);
  Serial.println(F("SX1272 successfully configured"));
  delay(500);
  sensor_Init();
}
void loop(void) {
  long startSend;
  long endSend;
  int e;
  if (millis() > nextTransmissionTime) {
    sensor_value = sensor_getValue();
    Serial.print(F("(Sensor value is "));
    Serial.println(sensor_value);
    uint8_t r_size;
#ifdef FLOAT_TEMP
    ftoa(float_str, sensor_value, 2);
    r_size = sprintf((char *)message, "\\!%s/%s", nomenclature_str, float_str);
#else
    r_size = sprintf((char *)message, "\\!%s/%d", nomenclature_str, (int)sensor_value);
#endif
#ifdef OLED
    u8x8.clearLine(3);
    u8x8.clearLine(4);
    u8x8.clearLine(5);
    u8x8.drawString(0, 3, "Sending");
    u8x8.drawString(0, 4, (char *)message);
#endif
    Serial.print(F("Sending "));
    Serial.println((char *)(message));
    Serial.print(F("Real payload size is "));
    Serial.println(r_size);
    int pl = r_size;
    sx1272.CarrierSense();
    startSend = millis();
    sx1272.setPacketType(PKT_TYPE_DATA);
    e = sx1272.sendPacketTimeout(DEFAULT_DEST_ADDR, message, pl);
    endSend = millis();
    Serial.print(F("LoRa pkt seq "));
    Serial.println(sx1272.packet_sent.packnum);
    Serial.print(F("LoRa Sent in "));
    Serial.println(endSend - startSend);
    Serial.print(F("LoRa Sent w/CAD in "));
    Serial.println(endSend - sx1272._startDoCad);
    Serial.print(F("Packet sent, state "));
    Serial.println(e);
#ifdef OLED
    u8x8.clearLine(3);
    u8x8.clearLine(5);
    sprintf(oled_msg, "Sending done %d", e);
    u8x8.drawString(0, 3, oled_msg);
    u8x8.drawString(0, 5, "Waiting...");
#endif
    nextTransmissionTime = millis() + 60000;
  }
}

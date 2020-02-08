
#include <RHDatagram.h>
#include <RH_RF95.h>
#include <SPI.h>
#define RFM95_CS 10
#define RFM95_RST 9
#define RFM95_INT 2
#define RF95_FREQ 865.20
RH_RF95 rf95(RFM95_CS, RFM95_INT);
#define PKT_TYPE_DATA 0x10
#define PKT_TYPE_ACK 0x20
#define PKT_FLAG_ACK_REQ 0x08
#define PKT_FLAG_DATA_ENCRYPTED 0x04
#define PKT_FLAG_DATA_WAPPKEY 0x02
RH_RF95::ModemConfig my_Bw125Cr45Sf4096 = {0x72, 0xc4, 0x08};
#define PABOOST
#define node_addr 6
#ifdef WITH_APPKEY
uint8_t my_appKey[4] = {5, 6, 7, 8};
#endif
RHDatagram manager(rf95, node_addr);
uint8_t seq = 0;
void setup() {
  delay(3000);
  pinMode(RFM95_RST, OUTPUT);
  Serial.begin(38400);
  delay(100);
  Serial.println("Arduino LoRa RX Test!");
  while (!rf95.init()) {
    Serial.println("LoRa radio init failed");
  }
  Serial.println("LoRa radio init OK!");
  if (!rf95.setFrequency(RF95_FREQ)) {
    Serial.println("setFrequency failed");
    while (1)
      ;
  }
  Serial.print("Set Freq to: ");
  Serial.println(RF95_FREQ);
  rf95.setModemRegisters(&my_Bw125Cr45Sf4096);
#ifdef PABOOST
  rf95.setTxPower(14, false);
#else
  rf95.setTxPower(14, true);
#endif
}
void loop() {
  uint8_t message[20];
  uint8_t data[] = "hello";
  uint8_t app_key_offset = 0;
#ifdef WITH_APPKEY
  app_key_offset = sizeof(my_appKey);
  memcpy(message, my_appKey, app_key_offset);
#endif
  memcpy(message + app_key_offset, data, sizeof(data) - 1);
  manager.setHeaderTo(1);
#ifdef WITH_APPKEY
  manager.setHeaderFrom(PKT_TYPE_DATA | PKT_FLAG_DATA_WAPPKEY);
#else
  manager.setHeaderFrom(PKT_TYPE_DATA);
#endif
  manager.setHeaderId(node_addr);
  manager.setHeaderFlags(seq++, 0xFF);
  Serial.println("Sending");
  manager.sendto(message, sizeof(data) - 1 + app_key_offset, 1);
  delay(5000);
}

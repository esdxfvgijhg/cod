
#ifndef SX1272_h
#define SX1272_h
#include <stdint.h>
#ifdef RASPBERRY2
#include "arduPi_pi2.h"
#else
#include "arduPi.h"
#endif
#ifndef inttypes_h
#include <inttypes.h>
#endif
#define W_REQUESTED_ACK
#define SX1272_RST 6
#define SX1272Chip 0
#define SX1276Chip 1
#define SX1272_SS 10
#define SX1272_debug_mode 0
#define bitRead(value, bit) (((value) >> (bit)) & 0x01)
#define bitSet(value, bit) ((value) |= (1UL << (bit)))
#define bitClear(value, bit) ((value) &= ~(1UL << (bit)))
#define REG_FIFO 0x00
#define REG_OP_MODE 0x01
#define REG_BITRATE_MSB 0x02
#define REG_BITRATE_LSB 0x03
#define REG_FDEV_MSB 0x04
#define REG_FDEV_LSB 0x05
#define REG_FRF_MSB 0x06
#define REG_FRF_MID 0x07
#define REG_FRF_LSB 0x08
#define REG_PA_CONFIG 0x09
#define REG_PA_RAMP 0x0A
#define REG_OCP 0x0B
#define REG_LNA 0x0C
#define REG_RX_CONFIG 0x0D
#define REG_FIFO_ADDR_PTR 0x0D
#define REG_RSSI_CONFIG 0x0E
#define REG_FIFO_TX_BASE_ADDR 0x0E
#define REG_RSSI_COLLISION 0x0F
#define REG_FIFO_RX_BASE_ADDR 0x0F
#define REG_RSSI_THRESH 0x10
#define REG_FIFO_RX_CURRENT_ADDR 0x10
#define REG_RSSI_VALUE_FSK 0x11
#define REG_IRQ_FLAGS_MASK 0x11
#define REG_RX_BW 0x12
#define REG_IRQ_FLAGS 0x12
#define REG_AFC_BW 0x13
#define REG_RX_NB_BYTES 0x13
#define REG_OOK_PEAK 0x14
#define REG_RX_HEADER_CNT_VALUE_MSB 0x14
#define REG_OOK_FIX 0x15
#define REG_RX_HEADER_CNT_VALUE_LSB 0x15
#define REG_OOK_AVG 0x16
#define REG_RX_PACKET_CNT_VALUE_MSB 0x16
#define REG_RX_PACKET_CNT_VALUE_LSB 0x17
#define REG_MODEM_STAT 0x18
#define REG_PKT_SNR_VALUE 0x19
#define REG_AFC_FEI 0x1A
#define REG_PKT_RSSI_VALUE 0x1A
#define REG_AFC_MSB 0x1B
#define REG_RSSI_VALUE_LORA 0x1B
#define REG_AFC_LSB 0x1C
#define REG_HOP_CHANNEL 0x1C
#define REG_FEI_MSB 0x1D
#define REG_MODEM_CONFIG1 0x1D
#define REG_FEI_LSB 0x1E
#define REG_MODEM_CONFIG2 0x1E
#define REG_PREAMBLE_DETECT 0x1F
#define REG_SYMB_TIMEOUT_LSB 0x1F
#define REG_RX_TIMEOUT1 0x20
#define REG_PREAMBLE_MSB_LORA 0x20
#define REG_RX_TIMEOUT2 0x21
#define REG_PREAMBLE_LSB_LORA 0x21
#define REG_RX_TIMEOUT3 0x22
#define REG_PAYLOAD_LENGTH_LORA 0x22
#define REG_RX_DELAY 0x23
#define REG_MAX_PAYLOAD_LENGTH 0x23
#define REG_OSC 0x24
#define REG_HOP_PERIOD 0x24
#define REG_PREAMBLE_MSB_FSK 0x25
#define REG_FIFO_RX_BYTE_ADDR 0x25
#define REG_PREAMBLE_LSB_FSK 0x26
#define REG_MODEM_CONFIG3 0x26
#define REG_SYNC_CONFIG 0x27
#define REG_SYNC_VALUE1 0x28
#define REG_SYNC_VALUE2 0x29
#define REG_SYNC_VALUE3 0x2A
#define REG_SYNC_VALUE4 0x2B
#define REG_SYNC_VALUE5 0x2C
#define REG_SYNC_VALUE6 0x2D
#define REG_SYNC_VALUE7 0x2E
#define REG_SYNC_VALUE8 0x2F
#define REG_PACKET_CONFIG1 0x30
#define REG_PACKET_CONFIG2 0x31
#define REG_DETECT_OPTIMIZE 0x31
#define REG_PAYLOAD_LENGTH_FSK 0x32
#define REG_NODE_ADRS 0x33
#define REG_BROADCAST_ADRS 0x34
#define REG_FIFO_THRESH 0x35
#define REG_SEQ_CONFIG1 0x36
#define REG_SEQ_CONFIG2 0x37
#define REG_DETECTION_THRESHOLD 0x37
#define REG_TIMER_RESOL 0x38
#define REG_TIMER1_COEF 0x39
#define REG_SYNC_WORD 0x39
#define REG_TIMER2_COEF 0x3A
#define REG_IMAGE_CAL 0x3B
#define REG_TEMP 0x3C
#define REG_LOW_BAT 0x3D
#define REG_IRQ_FLAGS1 0x3E
#define REG_IRQ_FLAGS2 0x3F
#define REG_DIO_MAPPING1 0x40
#define REG_DIO_MAPPING2 0x41
#define REG_VERSION 0x42
#define REG_AGC_REF 0x43
#define REG_AGC_THRESH1 0x44
#define REG_AGC_THRESH2 0x45
#define REG_AGC_THRESH3 0x46
#define REG_PLL_HOP 0x4B
#define REG_TCXO 0x58
#define REG_PA_DAC 0x5A
#define REG_PLL 0x5C
#define REG_PLL_LOW_PN 0x5E
#define REG_FORMER_TEMP 0x6C
#define REG_BIT_RATE_FRAC 0x70
#define RF_IMAGECAL_AUTOIMAGECAL_MASK 0x7F
#define RF_IMAGECAL_AUTOIMAGECAL_ON 0x80
#define RF_IMAGECAL_AUTOIMAGECAL_OFF 0x00
#define RF_IMAGECAL_IMAGECAL_MASK 0xBF
#define RF_IMAGECAL_IMAGECAL_START 0x40
#define RF_IMAGECAL_IMAGECAL_RUNNING 0x20
#define RF_IMAGECAL_IMAGECAL_DONE 0x00
#define RF_IMAGECAL_TEMPCHANGE_HIGHER 0x08
#define RF_IMAGECAL_TEMPCHANGE_LOWER 0x00
#define RF_IMAGECAL_TEMPTHRESHOLD_MASK 0xF9
#define RF_IMAGECAL_TEMPTHRESHOLD_05 0x00
#define RF_IMAGECAL_TEMPTHRESHOLD_10 0x02
#define RF_IMAGECAL_TEMPTHRESHOLD_15 0x04
#define RF_IMAGECAL_TEMPTHRESHOLD_20 0x06
#define RF_IMAGECAL_TEMPMONITOR_MASK 0xFE
#define RF_IMAGECAL_TEMPMONITOR_ON 0x00
#define RF_IMAGECAL_TEMPMONITOR_OFF 0x01
#define RH_LORA_FXOSC 32000000.0
#define RH_LORA_FCONVERT (524288 / RH_LORA_FXOSC)
const uint32_t CH_04_868 = 0xD7CCCC;
const uint32_t CH_05_868 = 0xD7E000;
const uint32_t CH_06_868 = 0xD7F333;
const uint32_t CH_07_868 = 0xD80666;
const uint32_t CH_08_868 = 0xD81999;
const uint32_t CH_09_868 = 0xD82CCC;
const uint32_t CH_10_868 = 0xD84CCC;
const uint32_t CH_11_868 = 0xD86000;
const uint32_t CH_12_868 = 0xD87333;
const uint32_t CH_13_868 = 0xD88666;
const uint32_t CH_14_868 = 0xD89999;
const uint32_t CH_15_868 = 0xD8ACCC;
const uint32_t CH_16_868 = 0xD8C000;
const uint32_t CH_17_868 = 0xD90000;
const uint32_t CH_18_868 = 0xD90666;
const uint32_t CH_00_900 = 0xE1C51E;
const uint32_t CH_01_900 = 0xE24F5C;
const uint32_t CH_02_900 = 0xE2D999;
const uint32_t CH_03_900 = 0xE363D7;
const uint32_t CH_04_900 = 0xE3EE14;
const uint32_t CH_05_900 = 0xE47851;
const uint32_t CH_06_900 = 0xE5028F;
const uint32_t CH_07_900 = 0xE58CCC;
const uint32_t CH_08_900 = 0xE6170A;
const uint32_t CH_09_900 = 0xE6A147;
const uint32_t CH_10_900 = 0xE72B85;
const uint32_t CH_11_900 = 0xE7B5C2;
const uint32_t CH_12_900 = 0xE4C000;
const uint32_t CH_00_433 = 0x6C5333;
const uint32_t CH_01_433 = 0x6C6666;
const uint32_t CH_02_433 = 0x6C7999;
const uint32_t CH_03_433 = 0x6C9333;
const uint8_t SX1272_BW_125 = 0x00;
const uint8_t SX1272_BW_250 = 0x01;
const uint8_t SX1272_BW_500 = 0x02;
const uint8_t BW_7_8 = 0x00;
const uint8_t BW_10_4 = 0x01;
const uint8_t BW_15_6 = 0x02;
const uint8_t BW_20_8 = 0x03;
const uint8_t BW_31_25 = 0x04;
const uint8_t BW_41_7 = 0x05;
const uint8_t BW_62_5 = 0x06;
const uint8_t BW_125 = 0x07;
const uint8_t BW_250 = 0x08;
const uint8_t BW_500 = 0x09;
const double SignalBwLog[] = {5.0969100130080564143587833158265, 5.397940008672037609572522210551, 5.6989700043360188047862611052755};
const uint8_t CR_5 = 0x01;
const uint8_t CR_6 = 0x02;
const uint8_t CR_7 = 0x03;
const uint8_t CR_8 = 0x04;
const uint8_t SF_6 = 0x06;
const uint8_t SF_7 = 0x07;
const uint8_t SF_8 = 0x08;
const uint8_t SF_9 = 0x09;
const uint8_t SF_10 = 0x0A;
const uint8_t SF_11 = 0x0B;
const uint8_t SF_12 = 0x0C;
const uint8_t LORA_SLEEP_MODE = 0x80;
const uint8_t LORA_STANDBY_MODE = 0x81;
const uint8_t LORA_TX_MODE = 0x83;
const uint8_t LORA_RX_MODE = 0x85;
const uint8_t LORA_CAD_MODE = 0x87;
#define LNA_MAX_GAIN 0x23
#define LNA_OFF_GAIN 0x00
#define LNA_LOW_GAIN 0x20
const uint8_t LORA_STANDBY_FSK_REGS_MODE = 0xC1;
const uint8_t FSK_SLEEP_MODE = 0x00;
const uint8_t FSK_STANDBY_MODE = 0x01;
const uint8_t FSK_TX_MODE = 0x03;
const uint8_t FSK_RX_MODE = 0x05;
const uint8_t HEADER_ON = 0;
const uint8_t HEADER_OFF = 1;
const uint8_t CRC_ON = 1;
const uint8_t CRC_OFF = 0;
const uint8_t LORA = 1;
const uint8_t FSK = 0;
const uint8_t BROADCAST_0 = 0x00;
const uint8_t MAX_LENGTH = 255;
const uint8_t MAX_PAYLOAD = 251;
const uint8_t MAX_LENGTH_FSK = 64;
const uint8_t MAX_PAYLOAD_FSK = 60;
const uint8_t ACK_LENGTH = 7;
#ifdef W_NET_KEY
const uint8_t NET_KEY_LENGTH = 2;
const uint8_t OFFSET_PAYLOADLENGTH = 4 + NET_KEY_LENGTH;
const uint8_t net_key_0 = 0x12;
const uint8_t net_key_1 = 0x34;
#else
const uint8_t OFFSET_PAYLOADLENGTH = 4;
#endif
const uint8_t OFFSET_RSSI = 139;
const uint8_t NOISE_FIGURE = 6.0;
const uint8_t NOISE_ABSOLUTE_ZERO = 174.0;
const uint16_t MAX_TIMEOUT = 10000;
const uint16_t MAX_WAIT = 12000;
const uint8_t MAX_RETRIES = 5;
const uint8_t CORRECT_PACKET = 0;
const uint8_t INCORRECT_PACKET = 1;
const uint8_t INCORRECT_PACKET_TYPE = 2;
#define PKT_TYPE_MASK 0xF0
#define PKT_FLAG_MASK 0x0F
#define PKT_TYPE_DATA 0x10
#define PKT_TYPE_ACK 0x20
#define PKT_FLAG_ACK_REQ 0x08
#define PKT_FLAG_DATA_ENCRYPTED 0x04
#define PKT_FLAG_DATA_WAPPKEY 0x02
#define PKT_FLAG_DATA_DOWNLINK 0x01
#define SX1272_ERROR_ACK 3
#define SX1272_ERROR_TOA 4
struct pack {
#ifdef W_NET_KEY
  uint8_t netkey[NET_KEY_LENGTH];
#endif
  uint8_t dst;
  uint8_t type;
  uint8_t src;
  uint8_t packnum;
  uint8_t length;
  uint8_t *data;
  uint8_t retry;
};
class SX1272 {
public:
  SX1272();
  uint8_t ON();
  void OFF();
  byte readRegister(byte address);
  void writeRegister(byte address, byte data);
  void clearFlags();
  uint8_t setLORA();
  uint8_t setFSK();
  uint8_t getMode();
  int8_t setMode(uint8_t mode);
  uint8_t getHeader();
  int8_t setHeaderON();
  int8_t setHeaderOFF();
  uint8_t getCRC();
  uint8_t setCRC_ON();
  uint8_t setCRC_OFF();
  boolean isSF(uint8_t spr);
  int8_t getSF();
  uint8_t setSF(uint8_t spr);
  boolean isBW(uint16_t band);
  int8_t getBW();
  int8_t setBW(uint16_t band);
  boolean isCR(uint8_t cod);
  int8_t getCR();
  int8_t setCR(uint8_t cod);
  boolean isChannel(uint32_t ch);
  uint8_t getChannel();
  int8_t setChannel(uint32_t ch);
  uint8_t getPower();
  int8_t setPower(char p);
  int8_t setPowerNum(uint8_t pow);
  uint8_t getPreambleLength();
  uint8_t setPreambleLength(uint16_t l);
  uint8_t getPayloadLength();
  int8_t setPacketLength();
  int8_t setPacketLength(uint8_t l);
  uint8_t getNodeAddress();
  int8_t setNodeAddress(uint8_t addr);
  int8_t getSNR();
  uint8_t getRSSI();
  int16_t getRSSIpacket();
  uint8_t getMaxCurrent();
  int8_t setMaxCurrent(uint8_t rate);
  uint8_t getRegs();
  uint8_t truncPayload(uint16_t length16);
  uint8_t setACK();
  uint8_t receive();
  uint8_t receivePacketMAXTimeout();
  uint8_t receivePacketTimeout();
  uint8_t receivePacketTimeout(uint16_t wait);
  uint8_t receivePacketMAXTimeoutACK();
  uint8_t receivePacketTimeoutACK();
  uint8_t receivePacketTimeoutACK(uint16_t wait);
  uint8_t receiveAll();
  uint8_t receiveAll(uint16_t wait);
  boolean availableData();
  boolean availableData(uint16_t wait);
  uint8_t setPacket(uint8_t dest, uint8_t *payload);
  uint8_t getPacketMAXTimeout();
  int8_t getPacket();
  int8_t getPacket(uint16_t wait);
  uint8_t sendWithMAXTimeout();
  uint8_t sendWithTimeout();
  uint8_t sendWithTimeout(uint16_t wait);
  uint8_t sendPacketMAXTimeout(uint8_t dest, char *payload);
  uint8_t sendPacketMAXTimeout(uint8_t dest, uint8_t *payload, uint16_t length);
  uint8_t sendPacketTimeout(uint8_t dest, char *payload);
  uint8_t sendPacketTimeout(uint8_t dest, uint8_t *payload, uint16_t length);
  uint8_t sendPacketTimeout(uint8_t dest, char *payload, uint16_t wait);
  uint8_t sendPacketTimeout(uint8_t dest, uint8_t *payload, uint16_t length, uint16_t wait);
  uint8_t sendPacketMAXTimeoutACK(uint8_t dest, char *payload);
  uint8_t sendPacketMAXTimeoutACK(uint8_t dest, uint8_t *payload, uint16_t length);
  uint8_t sendPacketTimeoutACK(uint8_t dest, char *payload);
  uint8_t sendPacketTimeoutACK(uint8_t dest, uint8_t *payload, uint16_t length);
  uint8_t sendPacketTimeoutACK(uint8_t dest, char *payload, uint16_t wait);
  uint8_t sendPacketTimeoutACK(uint8_t dest, uint8_t *payload, uint16_t length, uint16_t wait);
  int8_t setDestination(uint8_t dest);
  uint8_t setTimeout();
  uint8_t setPayload(uint8_t *payload);
  uint8_t getACK();
  uint8_t getACK(uint16_t wait);
  uint8_t sendPacketMAXTimeoutACKRetries(uint8_t dest, char *payload);
  uint8_t sendPacketMAXTimeoutACKRetries(uint8_t dest, uint8_t *payload, uint16_t length);
  uint8_t sendPacketTimeoutACKRetries(uint8_t dest, char *payload);
  uint8_t sendPacketTimeoutACKRetries(uint8_t dest, uint8_t *payload, uint16_t length);
  uint8_t sendPacketTimeoutACKRetries(uint8_t dest, char *payload, uint16_t wait);
  uint8_t sendPacketTimeoutACKRetries(uint8_t dest, uint8_t *payload, uint16_t length, uint16_t wait);
  uint8_t getTemp();
  void setPacketType(uint8_t type);
  void RxChainCalibration();
  uint8_t doCAD(uint8_t counter);
  uint16_t getToA(uint8_t pl);
  void CarrierSense(uint8_t cs = 1);
  void CarrierSense1();
  void CarrierSense2();
  void CarrierSense3();
  int8_t setSyncWord(uint8_t sw);
  int8_t getSyncWord();
  int8_t setSleepMode();
  int8_t setPowerDBM(uint8_t dbm);
  long limitToA();
  long getRemainingToA();
  long removeToA(uint16_t toa);
  uint8_t _board;
  uint8_t _syncWord;
  uint8_t _defaultSyncWord;
  unsigned long _starttime;
  unsigned long _stoptime;
  unsigned long _startDoCad;
  unsigned long _endDoCad;
  uint8_t _loraMode;
  uint8_t _send_cad_number;
  bool _extendedIFS;
  bool _RSSIonSend;
  bool _enableCarrierSense;
  bool _rawFormat;
  int8_t _rcv_snr_in_ack;
  bool _needPABOOST;
  uint8_t _rawSNR;
#ifdef W_REQUESTED_ACK
  uint8_t _requestACK;
  uint8_t _requestACK_indicator;
#endif
#ifdef W_NET_KEY
  uint8_t _my_netkey[NET_KEY_LENGTH];
  uint8_t _the_net_key_0;
  uint8_t _the_net_key_1;
#endif
  uint8_t _bandwidth;
  uint8_t _codingRate;
  uint8_t _spreadingFactor;
  uint32_t _channel;
  uint8_t _power;
  int8_t _SNR;
  int8_t _RSSI;
  int16_t _RSSIpacket;
  uint16_t _preamblelength;
  uint16_t _payloadlength;
  uint8_t _nodeAddress;
  uint8_t _header;
  uint8_t _hreceived;
  uint8_t _CRC;
  uint8_t _destination;
  uint8_t _packetNumber;
  uint8_t _reception;
  uint8_t _retries;
  uint8_t _maxRetries;
  uint8_t _maxCurrent;
  uint8_t _modem;
  pack packet_sent;
  pack packet_received;
  pack ACK;
  uint8_t packet_data[MAX_PAYLOAD];
  uint8_t ack_data[2];
  int _temp;
  uint16_t _sendTime;

private:
  void maxWrite16();
  char txbuf[2];
  char rxbuf[2];
  bool _limitToA;
  long _remainingToA;
  unsigned long _startToAcycle;
  unsigned long _endToAcycle;
  uint16_t _currentToA;
};
extern SX1272 sx1272;
#endif

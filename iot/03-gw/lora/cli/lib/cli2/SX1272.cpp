
#include "SX1272.h"
#include <math.h>
uint8_t sx1272_SIFS_value[11] = {0, 183, 94, 44, 47, 23, 24, 12, 12, 7, 4};
uint8_t sx1272_CAD_value[11] = {0, 62, 31, 16, 16, 8, 9, 5, 3, 1, 1};
#define MAX_DUTY_CYCLE_PER_HOUR 36000L
#define DUTYCYCLE_DURATION 3600000L
SX1272::SX1272() {
  _bandwidth = BW_125;
  _codingRate = CR_5;
  _spreadingFactor = SF_7;
  _channel = CH_12_900;
  _header = HEADER_ON;
  _CRC = CRC_OFF;
  _modem = FSK;
  _power = 15;
  _packetNumber = 0;
  _reception = CORRECT_PACKET;
  _retries = 0;
  _defaultSyncWord = 0x12;
  _rawFormat = false;
  _extendedIFS = false;
  _RSSIonSend = true;
  _enableCarrierSense = false;
  _send_cad_number = 9;
#ifdef PABOOST
  _needPABOOST = true;
#else
  _needPABOOST = false;
#endif
  _limitToA = false;
  _startToAcycle = millis();
  _remainingToA = MAX_DUTY_CYCLE_PER_HOUR;
#ifdef W_REQUESTED_ACK
  _requestACK = 0;
#endif
#ifdef W_NET_KEY
  _my_netkey[0] = net_key_0;
  _my_netkey[1] = net_key_1;
#endif
  packet_sent.data = packet_data;
  packet_received.data = packet_data;
  ACK.data = ack_data;
  _maxRetries = 0;
  packet_sent.retry = _retries;
};
void SX1272::RxChainCalibration() {
  if (_board == SX1276Chip) {
    printf("SX1276 LF/HF calibration\n");
    writeRegister(REG_PA_CONFIG, 0x00);
    writeRegister(REG_IMAGE_CAL, (readRegister(REG_IMAGE_CAL) & RF_IMAGECAL_IMAGECAL_MASK) | RF_IMAGECAL_IMAGECAL_START);
    while ((readRegister(REG_IMAGE_CAL) & RF_IMAGECAL_IMAGECAL_RUNNING) == RF_IMAGECAL_IMAGECAL_RUNNING) {
    }
    setChannel(CH_17_868);
    writeRegister(REG_IMAGE_CAL, (readRegister(REG_IMAGE_CAL) & RF_IMAGECAL_IMAGECAL_MASK) | RF_IMAGECAL_IMAGECAL_START);
    while ((readRegister(REG_IMAGE_CAL) & RF_IMAGECAL_IMAGECAL_RUNNING) == RF_IMAGECAL_IMAGECAL_RUNNING) {
    }
  }
}
uint8_t SX1272::ON() {
  uint8_t state = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'ON'\n");
#endif
  pinMode(SX1272_SS, OUTPUT);
  digitalWrite(SX1272_SS, HIGH);
  delay(100);
  SPI.begin();
  SPI.setBitOrder(MSBFIRST);
  SPI.setClockDivider(SPI_CLOCK_DIV64);
  SPI.setDataMode(SPI_MODE0);
  delay(100);
  pinMode(SX1272_RST, OUTPUT);
  digitalWrite(SX1272_RST, LOW);
  delay(100);
  digitalWrite(SX1272_RST, HIGH);
  delay(100);
  uint8_t version = readRegister(REG_VERSION);
  if (version == 0x22) {
    printf("SX1272 detected, starting.\n");
    _board = SX1272Chip;
  } else {
    digitalWrite(SX1272_RST, LOW);
    delay(100);
    digitalWrite(SX1272_RST, HIGH);
    delay(100);
    version = readRegister(REG_VERSION);
    if (version == 0x12) {
      printf("SX1276 detected, starting.\n");
      _board = SX1276Chip;
    } else {
      printf("Unrecognized transceiver.\n");
    }
  }
  RxChainCalibration();
  setMaxCurrent(0x1B);
#if (SX1272_debug_mode > 1)
  printf("## Setting ON with maximum current supply ##\n");
  printf("\n");
#endif
  state = setLORA();
  getPreambleLength();
#ifdef W_NET_KEY
  printf("## SX1272 layer has net key##\n");
#endif
#ifdef W_INITIALIZATION
  writeRegister(0x0, 0x0);
  writeRegister(0x1, 0x81);
  writeRegister(0x2, 0x1A);
  writeRegister(0x3, 0xB);
  writeRegister(0x4, 0x0);
  writeRegister(0x5, 0x52);
  writeRegister(0x6, 0xD8);
  writeRegister(0x7, 0x99);
  writeRegister(0x8, 0x99);
  if (_board == SX1272Chip)
    writeRegister(0x9, 0x0);
  else
    writeRegister(0x9, 0x40);
  writeRegister(0xA, 0x9);
  writeRegister(0xB, 0x3B);
  writeRegister(0xC, 0x23);
  writeRegister(0xD, 0x1);
  writeRegister(0xE, 0x80);
  writeRegister(0xF, 0x0);
  writeRegister(0x10, 0x0);
  writeRegister(0x11, 0x0);
  writeRegister(0x12, 0x0);
  writeRegister(0x13, 0x0);
  writeRegister(0x14, 0x0);
  writeRegister(0x15, 0x0);
  writeRegister(0x16, 0x0);
  writeRegister(0x17, 0x0);
  writeRegister(0x18, 0x10);
  writeRegister(0x19, 0x0);
  writeRegister(0x1A, 0x0);
  writeRegister(0x1B, 0x0);
  writeRegister(0x1C, 0x0);
  if (_board == SX1272Chip) {
    writeRegister(0x1D, 0x4A);
    writeRegister(0x1E, 0x97);
  } else {
    writeRegister(0x1D, 0x82);
    writeRegister(0x1E, 0x97);
  }
  writeRegister(0x1F, 0xFF);
  writeRegister(0x20, 0x0);
  writeRegister(0x21, 0x8);
  writeRegister(0x22, 0xFF);
  writeRegister(0x23, 0xFF);
  writeRegister(0x24, 0x0);
  writeRegister(0x25, 0x0);
  if (_board == SX1272Chip)
    writeRegister(0x26, 0x0);
  else
    writeRegister(0x26, 0x04);
  writeRegister(0x27, 0x0);
  writeRegister(0x28, 0x0);
  writeRegister(0x29, 0x0);
  writeRegister(0x2A, 0x0);
  writeRegister(0x2B, 0x0);
  writeRegister(0x2C, 0x0);
  writeRegister(0x2D, 0x50);
  writeRegister(0x2E, 0x14);
  writeRegister(0x2F, 0x40);
  writeRegister(0x30, 0x0);
  writeRegister(0x31, 0x3);
  writeRegister(0x32, 0x5);
  writeRegister(0x33, 0x27);
  writeRegister(0x34, 0x1C);
  writeRegister(0x35, 0xA);
  writeRegister(0x36, 0x0);
  writeRegister(0x37, 0xA);
  writeRegister(0x38, 0x42);
  writeRegister(0x39, 0x12);
  writeRegister(0x3A, 0x65);
  writeRegister(0x3B, 0x1D);
  writeRegister(0x3C, 0x1);
  writeRegister(0x3D, 0xA1);
  writeRegister(0x3E, 0x0);
  writeRegister(0x3F, 0x0);
  writeRegister(0x40, 0x0);
  writeRegister(0x41, 0x0);
#endif
  setSyncWord(_defaultSyncWord);
  getSyncWord();
  _defaultSyncWord = _syncWord;
  return state;
}
void SX1272::OFF() {
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'OFF'\n");
#endif
  SPI.end();
  pinMode(SX1272_SS, OUTPUT);
  digitalWrite(SX1272_SS, LOW);
#if (SX1272_debug_mode > 1)
  printf("## Setting OFF ##\n");
  printf("\n");
#endif
}
byte SX1272::readRegister(byte address) {
  digitalWrite(SX1272_SS, LOW);
  bitClear(address, 7);
  txbuf[0] = address;
  txbuf[1] = 0x00;
  maxWrite16();
  digitalWrite(SX1272_SS, HIGH);
#if (SX1272_debug_mode > 1)
  printf("## Reading:	##\tRegister ");
  printf("%X", address);
  printf(":	");
  printf("%X", rxbuf[1]);
  printf("\n");
#endif
  return rxbuf[1];
}
void SX1272::writeRegister(byte address, byte data) {
  digitalWrite(SX1272_SS, LOW);
  delay(1);
  bitSet(address, 7);
  txbuf[0] = address;
  txbuf[1] = data;
  maxWrite16();
#if (SX1272_debug_mode > 1)
  printf("## Writing:	##\tRegister ");
  bitClear(address, 7);
  printf("%X", address);
  printf(":	");
  printf("%X", data);
  printf("\n");
#endif
}
void SX1272::maxWrite16() {
  digitalWrite(SX1272_SS, LOW);
  SPI.transfernb(txbuf, rxbuf, 2);
  digitalWrite(SX1272_SS, HIGH);
}
void SX1272::clearFlags() {
  byte st0;
  st0 = readRegister(REG_OP_MODE);
  if (_modem == LORA) {
    writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
    writeRegister(REG_IRQ_FLAGS, 0xFF);
    writeRegister(REG_OP_MODE, st0);
#if (SX1272_debug_mode > 1)
    printf("## LoRa flags cleared ##\n");
#endif
  } else {
    writeRegister(REG_OP_MODE, FSK_STANDBY_MODE);
    writeRegister(REG_IRQ_FLAGS1, 0xFF);
    writeRegister(REG_IRQ_FLAGS2, 0xFF);
    writeRegister(REG_OP_MODE, st0);
#if (SX1272_debug_mode > 1)
    printf("## FSK flags cleared ##\n");
#endif
  }
}
uint8_t SX1272::setLORA() {
  uint8_t state = 2;
  byte st0;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setLORA'\n");
#endif
  uint8_t retry = 0;
  do {
    delay(200);
    writeRegister(REG_OP_MODE, FSK_SLEEP_MODE);
    writeRegister(REG_OP_MODE, LORA_SLEEP_MODE);
    writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
    delay(50 + retry * 10);
    st0 = readRegister(REG_OP_MODE);
    printf("...\n");
    if ((retry % 2) == 0)
      if (retry == 20)
        retry = 0;
      else
        retry++;
  } while (st0 != LORA_STANDBY_MODE);
  if (st0 == LORA_STANDBY_MODE) {
    _modem = LORA;
    state = 0;
#if (SX1272_debug_mode > 1)
    printf("## LoRa set with success ##\n");
    printf("\n");
#endif
  } else {
    _modem = FSK;
    state = 1;
#if (SX1272_debug_mode > 1)
    printf("** There has been an error while setting LoRa **\n");
    printf("\n");
#endif
  }
  return state;
}
uint8_t SX1272::setFSK() {
  uint8_t state = 2;
  byte st0;
  byte config1;
  if (_board == SX1276Chip)
    printf("Warning: FSK has not been tested on SX1276!\n");
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setFSK'\n");
#endif
  if (_modem = LORA) {
    writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
    writeRegister(REG_OP_MODE, LORA_SLEEP_MODE);
  }
  writeRegister(REG_OP_MODE, FSK_SLEEP_MODE);
  writeRegister(REG_OP_MODE, FSK_STANDBY_MODE);
  config1 = readRegister(REG_PACKET_CONFIG1);
  config1 = config1 & 0B01111101;
  config1 = config1 | 0B00000100;
  writeRegister(REG_PACKET_CONFIG1, config1);
  writeRegister(REG_FIFO_THRESH, 0x80);
  config1 = readRegister(REG_SYNC_CONFIG);
  config1 = config1 & 0B00111111;
  writeRegister(REG_SYNC_CONFIG, config1);
  delay(100);
  st0 = readRegister(REG_OP_MODE);
  if (st0 == FSK_STANDBY_MODE) {
    _modem = FSK;
    state = 0;
#if (SX1272_debug_mode > 1)
    printf("## FSK set with success ##\n");
    printf("\n");
#endif
  } else {
    _modem = LORA;
    state = 1;
#if (SX1272_debug_mode > 1)
    printf("** There has been an error while setting FSK **\n");
    printf("\n");
#endif
  }
  return state;
}
uint8_t SX1272::getMode() {
  byte st0;
  int8_t state = 2;
  byte value = 0x00;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getMode'\n");
#endif
  st0 = readRegister(REG_OP_MODE);
  if (_modem == FSK) {
    setLORA();
  }
  value = readRegister(REG_MODEM_CONFIG1);
  if (_board == SX1272Chip) {
    _bandwidth = (value >> 6);
    _bandwidth += 7;
  } else
    _bandwidth = (value >> 4);
  if (_board == SX1272Chip)
    _codingRate = (value >> 3) & 0x07;
  else
    _codingRate = (value >> 1) & 0x07;
  value = readRegister(REG_MODEM_CONFIG2);
  _spreadingFactor = (value >> 4) & 0x0F;
  state = 1;
  if (isBW(_bandwidth)) {
    if (isCR(_codingRate)) {
      if (isSF(_spreadingFactor)) {
        state = 0;
      }
    }
  }
#if (SX1272_debug_mode > 1)
  printf("## Parameters from configuration mode are:\n");
  printf("\t Bandwidth: ");
  printf("%X", _bandwidth);
  printf("\n");
  printf("\t Coding Rate: ");
  printf("%X", _codingRate);
  printf("\n");
  printf("\t Spreading Factor: ");
  printf("%X", _spreadingFactor);
  printf(" ##\n");
  printf("\n");
#endif
  writeRegister(REG_OP_MODE, st0);
  delay(100);
  return state;
}
int8_t SX1272::setMode(uint8_t mode) {
  int8_t state = 2;
  byte st0;
  byte config1 = 0x00;
  byte config2 = 0x00;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setMode'\n");
#endif
  st0 = readRegister(REG_OP_MODE);
  if (_modem == FSK) {
    setLORA();
  }
  writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
  switch (mode) {
  case 1:
    setCR(CR_5);
    setSF(SF_12);
    setBW(BW_125);
    break;
  case 2:
    setCR(CR_5);
    setSF(SF_12);
    setBW(BW_250);
    break;
  case 3:
    setCR(CR_5);
    setSF(SF_10);
    setBW(BW_125);
    break;
  case 4:
    setCR(CR_5);
    setSF(SF_12);
    setBW(BW_500);
    break;
  case 5:
    setCR(CR_5);
    setSF(SF_10);
    setBW(BW_250);
    break;
  case 6:
    setCR(CR_5);
    setSF(SF_11);
    setBW(BW_500);
    break;
  case 7:
    setCR(CR_5);
    setSF(SF_9);
    setBW(BW_250);
    break;
  case 8:
    setCR(CR_5);
    setSF(SF_9);
    setBW(BW_500);
    break;
  case 9:
    setCR(CR_5);
    setSF(SF_8);
    setBW(BW_500);
    break;
  case 10:
    setCR(CR_5);
    setSF(SF_7);
    setBW(BW_500);
    break;
  case 11:
    setCR(CR_5);
    setSF(SF_12);
    setBW(BW_125);
    setSyncWord(0x34);
    printf("** Using sync word of 0x");
    printf("%X\n", _syncWord);
    break;
  default:
    state = -1;
  };
  if (state == -1) {
#if (SX1272_debug_mode > 1)
    printf("** The indicated mode doesn't exist, ");
    printf("please select from 1 to 10 **\n");
#endif
  } else {
    state = 1;
    config1 = readRegister(REG_MODEM_CONFIG1);
    switch (mode) {
    case 1:
      if (_board == SX1272Chip) {
        if ((config1 >> 3) == 0x01)
          state = 0;
      } else {
        if ((config1 >> 1) == 0x39)
          state = 0;
      }
      if (state == 0) {
        state = 1;
        config2 = readRegister(REG_MODEM_CONFIG2);
        if ((config2 >> 4) == SF_12) {
          state = 0;
        }
      }
      break;
    case 2:
      if (_board == SX1272Chip) {
        if ((config1 >> 3) == 0x09)
          state = 0;
      } else {
        if ((config1 >> 1) == 0x41)
          state = 0;
      }
      if (state == 0) {
        state = 1;
        config2 = readRegister(REG_MODEM_CONFIG2);
        if ((config2 >> 4) == SF_12) {
          state = 0;
        }
      }
      break;
    case 3:
      if (_board == SX1272Chip) {
        if ((config1 >> 3) == 0x01)
          state = 0;
      } else {
        if ((config1 >> 1) == 0x39)
          state = 0;
      }
      if (state == 0) {
        state = 1;
        config2 = readRegister(REG_MODEM_CONFIG2);
        if ((config2 >> 4) == SF_10) {
          state = 0;
        }
      }
      break;
    case 4:
      if (_board == SX1272Chip) {
        if ((config1 >> 3) == 0x11)
          state = 0;
      } else {
        if ((config1 >> 1) == 0x49)
          state = 0;
      }
      if (state == 0) {
        state = 1;
        config2 = readRegister(REG_MODEM_CONFIG2);
        if ((config2 >> 4) == SF_12) {
          state = 0;
        }
      }
      break;
    case 5:
      if (_board == SX1272Chip) {
        if ((config1 >> 3) == 0x09)
          state = 0;
      } else {
        if ((config1 >> 1) == 0x41)
          state = 0;
      }
      if (state == 0) {
        state = 1;
        config2 = readRegister(REG_MODEM_CONFIG2);
        if ((config2 >> 4) == SF_10) {
          state = 0;
        }
      }
      break;
    case 6:
      if (_board == SX1272Chip) {
        if ((config1 >> 3) == 0x11)
          state = 0;
      } else {
        if ((config1 >> 1) == 0x49)
          state = 0;
      }
      if (state == 0) {
        state = 1;
        config2 = readRegister(REG_MODEM_CONFIG2);
        if ((config2 >> 4) == SF_11) {
          state = 0;
        }
      }
      break;
    case 7:
      if (_board == SX1272Chip) {
        if ((config1 >> 3) == 0x09)
          state = 0;
      } else {
        if ((config1 >> 1) == 0x41)
          state = 0;
      }
      if (state == 0) {
        state = 1;
        config2 = readRegister(REG_MODEM_CONFIG2);
        if ((config2 >> 4) == SF_9) {
          state = 0;
        }
      }
      break;
    case 8:
      if (_board == SX1272Chip) {
        if ((config1 >> 3) == 0x11)
          state = 0;
      } else {
        if ((config1 >> 1) == 0x49)
          state = 0;
      }
      if (state == 0) {
        state = 1;
        config2 = readRegister(REG_MODEM_CONFIG2);
        if ((config2 >> 4) == SF_9) {
          state = 0;
        }
      }
      break;
    case 9:
      if (_board == SX1272Chip) {
        if ((config1 >> 3) == 0x11)
          state = 0;
      } else {
        if ((config1 >> 1) == 0x49)
          state = 0;
      }
      if (state == 0) {
        state = 1;
        config2 = readRegister(REG_MODEM_CONFIG2);
        if ((config2 >> 4) == SF_8) {
          state = 0;
        }
      }
      break;
    case 10:
      if (_board == SX1272Chip) {
        if ((config1 >> 3) == 0x11)
          state = 0;
      } else {
        if ((config1 >> 1) == 0x49)
          state = 0;
      }
      if (state == 0) {
        state = 1;
        config2 = readRegister(REG_MODEM_CONFIG2);
        if ((config2 >> 4) == SF_7) {
          state = 0;
        }
      }
      break;
    case 11:
      if (_board == SX1272Chip) {
        if ((config1 >> 3) == 0x01)
          state = 0;
      } else {
        if ((config1 >> 1) == 0x39)
          state = 0;
      }
      if (state == 0) {
        state = 1;
        config2 = readRegister(REG_MODEM_CONFIG2);
        if ((config2 >> 4) == SF_12) {
          state = 0;
        }
      }
      break;
    }
    if (mode != 11) {
      setSyncWord(_defaultSyncWord);
#if (SX1272_debug_mode > 1)
      printf("** Using sync word of 0x");
      printf("%X\n", _defaultSyncWord);
#endif
    }
  }
#if (SX1272_debug_mode > 1)
  if (state == 0) {
    printf("## Mode ");
    printf("%d", mode);
    printf(" configured with success ##\n");
    printf("\n");
  } else {
    printf("** There has been an error while configuring mode ");
    printf("%d", mode);
    printf(". **\n");
    printf("\n");
  }
#endif
  writeRegister(REG_OP_MODE, st0);
  delay(100);
  return state;
}
uint8_t SX1272::getHeader() {
  int8_t state = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getHeader'\n");
#endif
  uint8_t theHeaderBit;
  if (_board == SX1272Chip)
    theHeaderBit = 2;
  else
    theHeaderBit = 0;
  if (bitRead(REG_MODEM_CONFIG1, theHeaderBit) == 0) {
    _header = HEADER_ON;
    state = 1;
  } else {
    _header = HEADER_OFF;
    state = 1;
  }
  state = 0;
  if (_modem == FSK) {
#if (SX1272_debug_mode > 1)
    printf("## Notice that FSK mode packets hasn't header ##\n");
    printf("\n");
#endif
  } else {
#if (SX1272_debug_mode > 1)
    printf("## Header is ");
    if (_header == HEADER_ON) {
      printf("in explicit header mode ##\n");
    } else {
      printf("in implicit header mode ##\n");
    }
    printf("\n");
#endif
  }
  return state;
}
int8_t SX1272::setHeaderON() {
  int8_t state = 2;
  byte config1;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setHeaderON'\n");
#endif
  if (_modem == FSK) {
    state = -1;
#if (SX1272_debug_mode > 1)
    printf("## FSK mode packets hasn't header ##\n");
    printf("\n");
#endif
  } else {
    config1 = readRegister(REG_MODEM_CONFIG1);
    if (_spreadingFactor == 6) {
      state = -1;
#if (SX1272_debug_mode > 1)
      printf("## Mandatory implicit header mode with spreading factor = 6 ##\n");
#endif
    } else {
      if (_board == SX1272Chip)
        config1 = config1 & 0B11111011;
      else
        config1 = config1 & 0B11111110;
      writeRegister(REG_MODEM_CONFIG1, config1);
    }
    uint8_t theHeaderBit;
    if (_board == SX1272Chip)
      theHeaderBit = 2;
    else
      theHeaderBit = 0;
    if (_spreadingFactor != 6) {
      config1 = readRegister(REG_MODEM_CONFIG1);
      if (bitRead(config1, theHeaderBit) == HEADER_ON) {
        state = 0;
        _header = HEADER_ON;
#if (SX1272_debug_mode > 1)
        printf("## Header has been activated ##\n");
        printf("\n");
#endif
      } else {
        state = 1;
      }
    }
  }
  return state;
}
int8_t SX1272::setHeaderOFF() {
  uint8_t state = 2;
  byte config1;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setHeaderOFF'\n");
#endif
  if (_modem == FSK) {
    state = -1;
#if (SX1272_debug_mode > 1)
    printf("## Notice that FSK mode packets hasn't header ##\n");
    printf("\n");
#endif
  } else {
    config1 = readRegister(REG_MODEM_CONFIG1);
    if (_board == SX1272Chip)
      config1 = config1 | 0B00000100;
    else
      config1 = config1 | 0B00000001;
    writeRegister(REG_MODEM_CONFIG1, config1);
    config1 = readRegister(REG_MODEM_CONFIG1);
    uint8_t theHeaderBit;
    if (_board == SX1272Chip)
      theHeaderBit = 2;
    else
      theHeaderBit = 0;
    if (bitRead(config1, theHeaderBit) == HEADER_OFF) {
      state = 0;
      _header = HEADER_OFF;
#if (SX1272_debug_mode > 1)
      printf("## Header has been desactivated ##\n");
      printf("\n");
#endif
    } else {
      state = 1;
#if (SX1272_debug_mode > 1)
      printf("** Header hasn't been desactivated ##\n");
      printf("\n");
#endif
    }
  }
  return state;
}
uint8_t SX1272::getCRC() {
  int8_t state = 2;
  byte value;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getCRC'\n");
#endif
  if (_modem == LORA) {
    uint8_t theRegister;
    uint8_t theCrcBit;
    if (_board == SX1272Chip) {
      theRegister = REG_MODEM_CONFIG1;
      theCrcBit = 1;
    } else {
      theRegister = REG_MODEM_CONFIG2;
      theCrcBit = 2;
    }
    value = readRegister(theRegister);
    if (bitRead(value, theCrcBit) == CRC_OFF) {
      _CRC = CRC_OFF;
#if (SX1272_debug_mode > 1)
      printf("## CRC is desactivated ##\n");
      printf("\n");
#endif
      state = 0;
    } else {
      _CRC = CRC_ON;
#if (SX1272_debug_mode > 1)
      printf("## CRC is activated ##\n");
      printf("\n");
#endif
      state = 0;
    }
  } else {
    value = readRegister(REG_PACKET_CONFIG1);
    if (bitRead(value, 4) == CRC_OFF) {
      _CRC = CRC_OFF;
#if (SX1272_debug_mode > 1)
      printf("## CRC is desactivated ##\n");
      printf("\n");
#endif
      state = 0;
    } else {
      _CRC = CRC_ON;
#if (SX1272_debug_mode > 1)
      printf("## CRC is activated ##\n");
      printf("\n");
#endif
      state = 0;
    }
  }
  if (state != 0) {
    state = 1;
#if (SX1272_debug_mode > 1)
    printf("** There has been an error while getting configured CRC **\n");
    printf("\n");
#endif
  }
  return state;
}
uint8_t SX1272::setCRC_ON() {
  uint8_t state = 2;
  byte config1;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setCRC_ON'\n");
#endif
  if (_modem == LORA) {
    uint8_t theRegister;
    uint8_t theCrcBit;
    if (_board == SX1272Chip) {
      theRegister = REG_MODEM_CONFIG1;
      theCrcBit = 1;
    } else {
      theRegister = REG_MODEM_CONFIG2;
      theCrcBit = 2;
    }
    config1 = readRegister(theRegister);
    if (_board == SX1272Chip)
      config1 = config1 | 0B00000010;
    else
      config1 = config1 | 0B00000100;
    writeRegister(theRegister, config1);
    state = 1;
    config1 = readRegister(theRegister);
    if (bitRead(config1, theCrcBit) == CRC_ON) {
      state = 0;
      _CRC = CRC_ON;
#if (SX1272_debug_mode > 1)
      printf("## CRC has been activated ##\n");
      printf("\n");
#endif
    }
  } else {
    config1 = readRegister(REG_PACKET_CONFIG1);
    config1 = config1 | 0B00010000;
    writeRegister(REG_PACKET_CONFIG1, config1);
    state = 1;
    config1 = readRegister(REG_PACKET_CONFIG1);
    if (bitRead(config1, 4) == CRC_ON) {
      state = 0;
      _CRC = CRC_ON;
#if (SX1272_debug_mode > 1)
      printf("## CRC has been activated ##\n");
      printf("\n");
#endif
    }
  }
  if (state != 0) {
    state = 1;
#if (SX1272_debug_mode > 1)
    printf("** There has been an error while setting CRC ON **\n");
    printf("\n");
#endif
  }
  return state;
}
uint8_t SX1272::setCRC_OFF() {
  int8_t state = 2;
  byte config1;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setCRC_OFF'\n");
#endif
  if (_modem == LORA) {
    uint8_t theRegister;
    uint8_t theCrcBit;
    if (_board == SX1272Chip) {
      theRegister = REG_MODEM_CONFIG1;
      theCrcBit = 1;
    } else {
      theRegister = REG_MODEM_CONFIG2;
      theCrcBit = 2;
    }
    config1 = readRegister(theRegister);
    if (_board == SX1272Chip)
      config1 = config1 & 0B11111101;
    else
      config1 = config1 & 0B11111011;
    writeRegister(theRegister, config1);
    config1 = readRegister(theRegister);
    if ((bitRead(config1, theCrcBit)) == CRC_OFF) {
      state = 0;
      _CRC = CRC_OFF;
#if (SX1272_debug_mode > 1)
      printf("## CRC has been desactivated ##\n");
      printf("\n");
#endif
    }
  } else {
    config1 = readRegister(REG_PACKET_CONFIG1);
    config1 = config1 & 0B11101111;
    writeRegister(REG_PACKET_CONFIG1, config1);
    config1 = readRegister(REG_PACKET_CONFIG1);
    if (bitRead(config1, 4) == CRC_OFF) {
      state = 0;
      _CRC = CRC_OFF;
#if (SX1272_debug_mode > 1)
      printf("## CRC has been desactivated ##\n");
      printf("\n");
#endif
    }
  }
  if (state != 0) {
    state = 1;
#if (SX1272_debug_mode > 1)
    printf("** There has been an error while setting CRC OFF **\n");
    printf("\n");
#endif
  }
  return state;
}
boolean SX1272::isSF(uint8_t spr) {
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'isSF'\n");
#endif
  switch (spr) {
  case SF_6:
  case SF_7:
  case SF_8:
  case SF_9:
  case SF_10:
  case SF_11:
  case SF_12:
    return true;
    break;
  default:
    return false;
  }
#if (SX1272_debug_mode > 1)
  printf("## Finished 'isSF' ##\n");
  printf("\n");
#endif
}
int8_t SX1272::getSF() {
  int8_t state = 2;
  byte config2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getSF'\n");
#endif
  if (_modem == FSK) {
    state = -1;
#if (SX1272_debug_mode > 1)
    printf("** FSK mode hasn't spreading factor **\n");
    printf("\n");
#endif
  } else {
    config2 = (readRegister(REG_MODEM_CONFIG2)) >> 4;
    _spreadingFactor = config2;
    state = 1;
    if ((config2 == _spreadingFactor) && isSF(_spreadingFactor)) {
      state = 0;
#if (SX1272_debug_mode > 1)
      printf("## Spreading factor is ");
      printf("%X", _spreadingFactor);
      printf(" ##\n");
      printf("\n");
#endif
    }
  }
  return state;
}
uint8_t SX1272::setSF(uint8_t spr) {
  byte st0;
  int8_t state = 2;
  byte config1 = 0;
  byte config2 = 0;
  byte config3 = 0;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setSF'\n");
#endif
  st0 = readRegister(REG_OP_MODE);
  if (_modem == FSK) {
#if (SX1272_debug_mode > 1)
    printf("## Notice that FSK hasn't Spreading Factor parameter, ");
    printf("so you are configuring it in LoRa mode ##\n");
#endif
    state = setLORA();
  }
  writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
  config1 = (readRegister(REG_MODEM_CONFIG1));
  config2 = (readRegister(REG_MODEM_CONFIG2));
  getBW();
  boolean isLowDROp = false;
  if ((spr == SF_11 || spr == SF_12) && _bandwidth == BW_125)
    isLowDROp = true;
  if (spr == SF_12 && _bandwidth == BW_250)
    isLowDROp = true;
  switch (spr) {
  case SF_6:
    config2 = config2 & 0B01101111;
    config2 = config2 | 0B01100000;
    break;
  case SF_7:
    config2 = config2 & 0B01111111;
    config2 = config2 | 0B01110000;
    break;
  case SF_8:
    config2 = config2 & 0B10001111;
    config2 = config2 | 0B10000000;
    break;
  case SF_9:
    config2 = config2 & 0B10011111;
    config2 = config2 | 0B10010000;
    break;
  case SF_10:
    config2 = config2 & 0B10101111;
    config2 = config2 | 0B10100000;
    break;
  case SF_11:
    config2 = config2 & 0B10111111;
    config2 = config2 | 0B10110000;
    break;
  case SF_12:
    config2 = config2 & 0B11001111;
    config2 = config2 | 0B11000000;
    break;
  }
  if (isLowDROp) {
    if (_board == SX1272Chip)
      config1 = config1 | 0B00000001;
    else {
      config3 = readRegister(REG_MODEM_CONFIG3);
      config3 = config3 | 0B00001000;
    }
  } else {
    if (_board == SX1272Chip) {
      config1 = config1 & 0B11111110;
    } else {
      config3 = readRegister(REG_MODEM_CONFIG3);
      config3 = config3 & 0B11110111;
    }
  }
  if (_board == SX1272Chip) {
    config2 = config2 | 0B00000100;
    writeRegister(REG_MODEM_CONFIG1, config1);
  } else {
    config3 = config3 | 0B00000100;
    writeRegister(REG_MODEM_CONFIG3, config3);
  }
  writeRegister(REG_MODEM_CONFIG2, config2);
  if (spr == SF_6) {
    setHeaderOFF();
    writeRegister(REG_DETECT_OPTIMIZE, 0x05);
    writeRegister(REG_DETECTION_THRESHOLD, 0x0C);
  } else {
    setHeaderON();
    writeRegister(REG_DETECT_OPTIMIZE, 0x03);
    writeRegister(REG_DETECTION_THRESHOLD, 0x0A);
  }
  writeRegister(REG_OP_MODE, st0);
  delay(100);
  if (isSF(spr)) {
    state = 0;
    _spreadingFactor = spr;
#if (SX1272_debug_mode > 1)
    printf("## Spreading factor ");
    printf("%d", _spreadingFactor);
    printf(" has been successfully set ##\n");
    printf("\n");
#endif
  } else {
    if (state != 0) {
#if (SX1272_debug_mode > 1)
      printf("** There has been an error while setting the spreading factor **");
      printf("\n");
#endif
    }
  }
  return state;
}
boolean SX1272::isBW(uint16_t band) {
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'isBW'\n");
#endif
  if (_board == SX1272Chip) {
    switch (band) {
    case BW_125:
    case BW_250:
    case BW_500:
      return true;
      break;
    default:
      return false;
    }
  } else {
    switch (band) {
    case BW_7_8:
    case BW_10_4:
    case BW_15_6:
    case BW_20_8:
    case BW_31_25:
    case BW_41_7:
    case BW_62_5:
    case BW_125:
    case BW_250:
    case BW_500:
      return true;
      break;
    default:
      return false;
    }
  }
#if (SX1272_debug_mode > 1)
  printf("## Finished 'isBW' ##\n");
  printf("\n");
#endif
}
int8_t SX1272::getBW() {
  uint8_t state = 2;
  byte config1;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getBW'\n");
#endif
  if (_modem == FSK) {
    state = -1;
#if (SX1272_debug_mode > 1)
    printf("** FSK mode hasn't bandwidth **\n");
    printf("\n");
#endif
  } else {
    if (_board == SX1272Chip) {
      config1 = (readRegister(REG_MODEM_CONFIG1)) >> 6;
      config1 += 7;
    } else {
      config1 = (readRegister(REG_MODEM_CONFIG1)) >> 4;
    }
    _bandwidth = config1;
    if ((config1 == _bandwidth) && isBW(_bandwidth)) {
      state = 0;
#if (SX1272_debug_mode > 1)
      printf("## Bandwidth is ");
      printf("%X", _bandwidth);
      printf(" ##\n");
      printf("\n");
#endif
    } else {
      state = 1;
#if (SX1272_debug_mode > 1)
      printf("** There has been an error while getting bandwidth **");
      printf("\n");
#endif
    }
  }
  return state;
}
int8_t SX1272::setBW(uint16_t band) {
  byte st0;
  int8_t state = 2;
  byte config1;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setBW'\n");
#endif
  if (!isBW(band)) {
    state = 1;
#if (SX1272_debug_mode > 1)
    printf("** Bandwidth ");
    printf("%X", band);
    printf(" is not a correct value **\n");
    printf("\n");
#endif
    return state;
  }
  st0 = readRegister(REG_OP_MODE);
  if (_modem == FSK) {
#if (SX1272_debug_mode > 1)
    printf("## Notice that FSK hasn't Bandwidth parameter, ");
    printf("so you are configuring it in LoRa mode ##\n");
#endif
    state = setLORA();
  }
  writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
  config1 = (readRegister(REG_MODEM_CONFIG1));
  getSF();
  if (_board == SX1272Chip) {
    switch (band) {
    case BW_125:
      config1 = config1 & 0B00111110;
      if (_spreadingFactor == 11 || _spreadingFactor == 12) {
        config1 = config1 | 0B00000001;
      }
      break;
    case BW_250:
      config1 = config1 & 0B01111110;
      config1 = config1 | 0B01000000;
      if (_spreadingFactor == 12) {
        config1 = config1 | 0B00000001;
      }
      break;
    case BW_500:
      config1 = config1 & 0B10111110;
      config1 = config1 | 0B10000000;
      break;
    }
  } else {
    config1 = config1 & 0B00001111;
    byte config3 = readRegister(REG_MODEM_CONFIG3);
    config3 = config3 & 0B11110111;
    switch (band) {
    case BW_125:
      config1 = config1 | 0B01110000;
      if (_spreadingFactor == 11 || _spreadingFactor == 12) {
        config3 = config3 | 0B00001000;
      }
      break;
    case BW_250:
      config1 = config1 | 0B10000000;
      if (_spreadingFactor == 12) {
        config3 = config3 | 0B00001000;
      }
      break;
    case BW_500:
      config1 = config1 | 0B10010000;
      break;
    }
    writeRegister(REG_MODEM_CONFIG3, config3);
  }
  writeRegister(REG_MODEM_CONFIG1, config1);
  delay(100);
  config1 = (readRegister(REG_MODEM_CONFIG1));
  if (_board == SX1272Chip) {
    switch (band) {
    case BW_125:
      if ((config1 >> 6) == SX1272_BW_125) {
        state = 0;
        if (_spreadingFactor == 11 || _spreadingFactor == 12) {
          if (bitRead(config1, 0) == 1) {
            state = 0;
          } else {
            state = 1;
          }
        }
      }
      break;
    case BW_250:
      if ((config1 >> 6) == SX1272_BW_250) {
        state = 0;
        if (_spreadingFactor == 12) {
          if (bitRead(config1, 0) == 1) {
            state = 0;
          } else {
            state = 1;
          }
        }
      }
      break;
    case BW_500:
      if ((config1 >> 6) == SX1272_BW_500) {
        state = 0;
      }
      break;
    }
  } else {
    byte config3 = (readRegister(REG_MODEM_CONFIG3));
    switch (band) {
    case BW_125:
      if ((config1 >> 4) == BW_125) {
        state = 0;
        if (_spreadingFactor == 11 || _spreadingFactor == 12) {
          if (bitRead(config3, 3) == 1) {
            state = 0;
          } else {
            state = 1;
          }
        }
      }
      break;
    case BW_250:
      if ((config1 >> 4) == BW_250) {
        state = 0;
        if (_spreadingFactor == 12) {
          if (bitRead(config3, 3) == 1) {
            state = 0;
          } else {
            state = 1;
          }
        }
      }
      break;
    case BW_500:
      if ((config1 >> 4) == BW_500) {
        state = 0;
      }
      break;
    }
  }
  if (state == 0) {
    _bandwidth = band;
#if (SX1272_debug_mode > 1)
    printf("## Bandwidth ");
    printf("%X", band);
    printf(" has been successfully set ##\n");
    printf("\n");
#endif
  }
  writeRegister(REG_OP_MODE, st0);
  delay(100);
  return state;
}
boolean SX1272::isCR(uint8_t cod) {
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'isCR'\n");
#endif
  switch (cod) {
  case CR_5:
  case CR_6:
  case CR_7:
  case CR_8:
    return true;
    break;
  default:
    return false;
  }
#if (SX1272_debug_mode > 1)
  printf("## Finished 'isCR' ##\n");
  printf("\n");
#endif
}
int8_t SX1272::getCR() {
  int8_t state = 2;
  byte config1;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getCR'\n");
#endif
  if (_modem == FSK) {
    state = -1;
#if (SX1272_debug_mode > 1)
    printf("** FSK mode hasn't coding rate **\n");
    printf("\n");
#endif
  } else {
    if (_board == SX1272Chip) {
      config1 = (readRegister(REG_MODEM_CONFIG1)) >> 3;
      config1 = config1 & 0B00000111;
    } else {
      config1 = (readRegister(REG_MODEM_CONFIG1)) >> 1;
      config1 = config1 & 0B00000111;
    }
    _codingRate = config1;
    state = 1;
    if ((config1 == _codingRate) && isCR(_codingRate)) {
      state = 0;
#if (SX1272_debug_mode > 1)
      printf("## Coding rate is ");
      printf("%X", _codingRate);
      printf(" ##\n");
      printf("\n");
#endif
    }
  }
  return state;
}
int8_t SX1272::setCR(uint8_t cod) {
  byte st0;
  int8_t state = 2;
  byte config1;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setCR'\n");
#endif
  st0 = readRegister(REG_OP_MODE);
  if (_modem == FSK) {
#if (SX1272_debug_mode > 1)
    printf("## Notice that FSK hasn't Coding Rate parameter, ");
    printf("so you are configuring it in LoRa mode ##\n");
#endif
    state = setLORA();
  }
  writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
  config1 = readRegister(REG_MODEM_CONFIG1);
  if (_board == SX1272Chip) {
    switch (cod) {
    case CR_5:
      config1 = config1 & 0B11001111;
      config1 = config1 | 0B00001000;
      break;
    case CR_6:
      config1 = config1 & 0B11010111;
      config1 = config1 | 0B00010000;
      break;
    case CR_7:
      config1 = config1 & 0B11011111;
      config1 = config1 | 0B00011000;
      break;
    case CR_8:
      config1 = config1 & 0B11100111;
      config1 = config1 | 0B00100000;
      break;
    }
  } else {
    config1 = config1 & 0B11110001;
    switch (cod) {
    case CR_5:
      config1 = config1 | 0B00000010;
      break;
    case CR_6:
      config1 = config1 | 0B00000100;
      break;
    case CR_7:
      config1 = config1 | 0B00000110;
      break;
    case CR_8:
      config1 = config1 | 0B00001000;
      break;
    }
  }
  writeRegister(REG_MODEM_CONFIG1, config1);
  delay(100);
  config1 = readRegister(REG_MODEM_CONFIG1);
  uint8_t nshift = 3;
  if (_board == SX1276Chip)
    nshift = 1;
  switch (cod) {
  case CR_5:
    if (((config1 >> nshift) & 0B0000111) == 0x01) {
      state = 0;
    }
    break;
  case CR_6:
    if (((config1 >> nshift) & 0B0000111) == 0x02) {
      state = 0;
    }
    break;
  case CR_7:
    if (((config1 >> nshift) & 0B0000111) == 0x03) {
      state = 0;
    }
    break;
  case CR_8:
    if (((config1 >> nshift) & 0B0000111) == 0x04) {
      state = 0;
    }
    break;
  }
  if (isCR(cod)) {
    _codingRate = cod;
#if (SX1272_debug_mode > 1)
    printf("## Coding Rate ");
    printf("%X", cod);
    printf(" has been successfully set ##\n");
    printf("\n");
#endif
  } else {
    state = 1;
#if (SX1272_debug_mode > 1)
    printf("** There has been an error while configuring Coding Rate parameter **\n");
    printf("\n");
#endif
  }
  writeRegister(REG_OP_MODE, st0);
  delay(100);
  return state;
}
boolean SX1272::isChannel(uint32_t ch) {
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'isChannel'\n");
#endif
  switch (ch) {
  case CH_10_868:
  case CH_11_868:
  case CH_12_868:
  case CH_13_868:
  case CH_14_868:
  case CH_15_868:
  case CH_16_868:
  case CH_17_868:
  case CH_18_868:
  case CH_00_900:
  case CH_01_900:
  case CH_02_900:
  case CH_03_900:
  case CH_04_900:
  case CH_05_900:
  case CH_06_900:
  case CH_07_900:
  case CH_08_900:
  case CH_09_900:
  case CH_10_900:
  case CH_11_900:
  case CH_12_900:
  case CH_00_433:
    return true;
  default:
    return false;
  }
#if (SX1272_debug_mode > 1)
  printf("## Finished 'isChannel' ##\n");
  printf("\n");
#endif
}
uint8_t SX1272::getChannel() {
  uint8_t state = 2;
  uint32_t ch;
  uint8_t freq3;
  uint8_t freq2;
  uint8_t freq1;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getChannel'\n");
#endif
  freq3 = readRegister(REG_FRF_MSB);
  freq2 = readRegister(REG_FRF_MID);
  freq1 = readRegister(REG_FRF_LSB);
  ch = ((uint32_t)freq3 << 16) + ((uint32_t)freq2 << 8) + (uint32_t)freq1;
  _channel = ch;
  if ((_channel == ch) && isChannel(_channel)) {
    state = 0;
#if (SX1272_debug_mode > 1)
    printf("## Frequency channel is ");
    printf("%X", _channel);
    printf(" ##\n");
    printf("\n");
#endif
  } else {
    state = 1;
  }
  return state;
}
int8_t SX1272::setChannel(uint32_t ch) {
  byte st0;
  int8_t state = 2;
  unsigned int freq3;
  unsigned int freq2;
  uint8_t freq1;
  uint32_t freq;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setChannel'\n");
#endif
  _starttime = millis();
  st0 = readRegister(REG_OP_MODE);
  if (_modem == LORA) {
    writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
  } else {
    writeRegister(REG_OP_MODE, FSK_STANDBY_MODE);
  }
  freq3 = ((ch >> 16) & 0x0FF);
  freq2 = ((ch >> 8) & 0x0FF);
  freq1 = (ch & 0xFF);
  writeRegister(REG_FRF_MSB, freq3);
  writeRegister(REG_FRF_MID, freq2);
  writeRegister(REG_FRF_LSB, freq1);
  _stoptime = millis();
  delay(100);
  freq3 = (readRegister(REG_FRF_MSB));
  freq = (freq3 << 8) & 0xFFFFFF;
  freq2 = (readRegister(REG_FRF_MID));
  freq = (freq << 8) + ((freq2 << 8) & 0xFFFFFF);
  freq = freq + ((readRegister(REG_FRF_LSB)) & 0xFFFFFF);
  if (freq == ch) {
    state = 0;
    _channel = ch;
#if (SX1272_debug_mode > 1)
    printf("## Frequency channel ");
    printf("%X", ch);
    printf(" has been successfully set ##\n");
    printf("\n");
#endif
  } else {
    state = 1;
  }
  writeRegister(REG_OP_MODE, st0);
  delay(100);
  return state;
}
uint8_t SX1272::getPower() {
  uint8_t state = 2;
  byte value = 0x00;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getPower'\n");
#endif
  value = readRegister(REG_PA_CONFIG);
  state = 1;
  _power = value & 0B00001111;
  if (_power < 16) {
    state = 0;
#if (SX1272_debug_mode > 1)
    printf("## Output power is ");
    printf("%X", _power);
    printf(" ##\n");
    printf("\n");
#endif
  }
  return state;
}
int8_t SX1272::setPower(char p) {
  byte st0;
  int8_t state = 2;
  byte value = 0x00;
  byte RegPaDacReg = (_board == SX1272Chip) ? 0x5A : 0x4D;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setPower'\n");
#endif
  st0 = readRegister(REG_OP_MODE);
  if (_modem == LORA) {
    writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
  } else {
    writeRegister(REG_OP_MODE, FSK_STANDBY_MODE);
  }
  switch (p) {
  case 'x':
  case 'X':
  case 'M':
    value = 0x0F;
    break;
  case 'L':
    value = 0x03;
    break;
  case 'H':
    value = 0x07;
    break;
  default:
    state = -1;
    break;
  }
  setMaxCurrent(0x0B);
  if (p == 'x') {
    value = 0x0C;
    value = value | 0B10000000;
    setMaxCurrent(0x10);
  }
  if (p == 'X') {
    value = value | 0B10000000;
    writeRegister(RegPaDacReg, 0x87);
    setMaxCurrent(0x12);
  } else {
    writeRegister(RegPaDacReg, 0x84);
  }
  if (_board == SX1272Chip) {
    writeRegister(REG_PA_CONFIG, value);
  } else {
    value = value | 0B01110000;
    writeRegister(REG_PA_CONFIG, value);
  }
  _power = value;
  value = readRegister(REG_PA_CONFIG);
  if (value == _power) {
    state = 0;
#if (SX1272_debug_mode > 1)
    printf("## Output power has been successfully set ##\n");
    printf("\n");
#endif
  } else {
    state = 1;
  }
  writeRegister(REG_OP_MODE, st0);
  delay(100);
  return state;
}
int8_t SX1272::setPowerNum(uint8_t pow) {
  byte st0;
  int8_t state = 2;
  byte value = 0x00;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setPower'\n");
#endif
  st0 = readRegister(REG_OP_MODE);
  if (_modem == LORA) {
    writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
  } else {
    writeRegister(REG_OP_MODE, FSK_STANDBY_MODE);
  }
  if ((pow >= 0) && (pow < 15)) {
    _power = pow;
  } else {
    state = -1;
#if (SX1272_debug_mode > 1)
    printf("## Power value is not valid ##\n");
    printf("\n");
#endif
  }
  if (_board == SX1276Chip) {
    value = readRegister(REG_PA_CONFIG);
    value = value & 0B11110000;
    value = value + _power;
    _power = value;
  }
  writeRegister(REG_PA_CONFIG, _power);
  value = readRegister(REG_PA_CONFIG);
  if (value == _power) {
    state = 0;
#if (SX1272_debug_mode > 1)
    printf("## Output power has been successfully set ##\n");
    printf("\n");
#endif
  } else {
    state = 1;
  }
  writeRegister(REG_OP_MODE, st0);
  delay(100);
  return state;
}
uint8_t SX1272::getPreambleLength() {
  int8_t state = 2;
  uint8_t p_length;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getPreambleLength'\n");
#endif
  state = 1;
  if (_modem == LORA) {
    p_length = readRegister(REG_PREAMBLE_MSB_LORA);
    _preamblelength = (p_length << 8) & 0xFFFF;
    p_length = readRegister(REG_PREAMBLE_LSB_LORA);
    _preamblelength = _preamblelength + (p_length & 0xFFFF);
#if (SX1272_debug_mode > 1)
    printf("## Preamble length configured is ");
    printf("%X", _preamblelength);
    printf(" ##");
    printf("\n");
#endif
  } else {
    p_length = readRegister(REG_PREAMBLE_MSB_FSK);
    _preamblelength = (p_length << 8) & 0xFFFF;
    p_length = readRegister(REG_PREAMBLE_LSB_FSK);
    _preamblelength = _preamblelength + (p_length & 0xFFFF);
#if (SX1272_debug_mode > 1)
    printf("## Preamble length configured is ");
    printf("%X", _preamblelength);
    printf(" ##");
    printf("\n");
#endif
  }
  state = 0;
  return state;
}
uint8_t SX1272::setPreambleLength(uint16_t l) {
  byte st0;
  uint8_t p_length;
  int8_t state = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setPreambleLength'\n");
#endif
  st0 = readRegister(REG_OP_MODE);
  state = 1;
  if (_modem == LORA) {
    writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
    p_length = ((l >> 8) & 0x0FF);
    writeRegister(REG_PREAMBLE_MSB_LORA, p_length);
    p_length = (l & 0x0FF);
    writeRegister(REG_PREAMBLE_LSB_LORA, p_length);
  } else {
    writeRegister(REG_OP_MODE, FSK_STANDBY_MODE);
    p_length = ((l >> 8) & 0x0FF);
    writeRegister(REG_PREAMBLE_MSB_FSK, p_length);
    p_length = (l & 0x0FF);
    writeRegister(REG_PREAMBLE_LSB_FSK, p_length);
  }
  state = 0;
#if (SX1272_debug_mode > 1)
  printf("## Preamble length ");
  printf("%X", l);
  printf(" has been successfully set ##\n");
  printf("\n");
#endif
  writeRegister(REG_OP_MODE, st0);
  delay(100);
  return state;
}
uint8_t SX1272::getPayloadLength() { return _payloadlength; }
int8_t SX1272::setPacketLength() {
  uint16_t length;
  if (_rawFormat)
    length = _payloadlength;
  else
    length = _payloadlength + OFFSET_PAYLOADLENGTH;
  return setPacketLength(length);
}
int8_t SX1272::setPacketLength(uint8_t l) {
  byte st0;
  byte value = 0x00;
  int8_t state = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setPacketLength'\n");
#endif
  st0 = readRegister(REG_OP_MODE);
  packet_sent.length = l;
  if (_modem == LORA) {
    writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
    writeRegister(REG_PAYLOAD_LENGTH_LORA, packet_sent.length);
    value = readRegister(REG_PAYLOAD_LENGTH_LORA);
  } else {
    writeRegister(REG_OP_MODE, FSK_STANDBY_MODE);
    writeRegister(REG_PAYLOAD_LENGTH_FSK, packet_sent.length);
    value = readRegister(REG_PAYLOAD_LENGTH_FSK);
  }
  if (packet_sent.length == value) {
    state = 0;
#if (SX1272_debug_mode > 1)
    printf("## Packet length ");
    printf("%d", packet_sent.length);
    printf(" has been successfully set ##\n");
    printf("\n");
#endif
  } else {
    state = 1;
  }
  writeRegister(REG_OP_MODE, st0);
  delay(250);
  return state;
}
uint8_t SX1272::getNodeAddress() {
  byte st0 = 0;
  uint8_t state = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getNodeAddress'\n");
#endif
  if (_modem == LORA) {
    st0 = readRegister(REG_OP_MODE);
    writeRegister(REG_OP_MODE, LORA_STANDBY_FSK_REGS_MODE);
  }
  _nodeAddress = readRegister(REG_NODE_ADRS);
  state = 1;
  if (_modem == LORA) {
    writeRegister(REG_OP_MODE, st0);
  }
  state = 0;
#if (SX1272_debug_mode > 1)
  printf("## Node address configured is ");
  printf("%d", _nodeAddress);
  printf(" ##\n");
  printf("\n");
#endif
  return state;
}
int8_t SX1272::setNodeAddress(uint8_t addr) {
  byte st0;
  byte value;
  uint8_t state = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setNodeAddress'\n");
#endif
  if (addr > 255) {
    state = -1;
#if (SX1272_debug_mode > 1)
    printf("** Node address must be less than 255 **\n");
    printf("\n");
#endif
  } else {
    _nodeAddress = addr;
    st0 = readRegister(REG_OP_MODE);
    if (_modem == LORA) {
      writeRegister(REG_OP_MODE, LORA_STANDBY_FSK_REGS_MODE);
    } else {
      writeRegister(REG_OP_MODE, FSK_STANDBY_MODE);
    }
    writeRegister(REG_NODE_ADRS, addr);
    writeRegister(REG_BROADCAST_ADRS, BROADCAST_0);
    value = readRegister(REG_NODE_ADRS);
    writeRegister(REG_OP_MODE, st0);
    if (value == _nodeAddress) {
      state = 0;
#if (SX1272_debug_mode > 1)
      printf("## Node address ");
      printf("%d", addr);
      printf(" has been successfully set ##\n");
      printf("\n");
#endif
    } else {
      state = 1;
#if (SX1272_debug_mode > 1)
      printf("** There has been an error while setting address ##\n");
      printf("\n");
#endif
    }
  }
  return state;
}
int8_t SX1272::getSNR() {
  int8_t state = 2;
  byte value;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getSNR'\n");
#endif
  if (_modem == LORA) {
    state = 1;
    value = readRegister(REG_PKT_SNR_VALUE);
    _rawSNR = value;
    if (value & 0x80) {
      value = ((~value + 1) & 0xFF) >> 2;
      _SNR = -value;
    } else {
      _SNR = (value & 0xFF) >> 2;
    }
    state = 0;
#if (SX1272_debug_mode > 0)
    printf("## SNR value is ");
    printf("%d", _SNR);
    printf(" ##\n");
    printf("\n");
#endif
  } else {
    state = -1;
#if (SX1272_debug_mode > 0)
    printf("** SNR does not exist in FSK mode **\n");
    printf("\n");
#endif
  }
  return state;
}
uint8_t SX1272::getRSSI() {
  uint8_t state = 2;
  int rssi_mean = 0;
  int total = 5;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getRSSI'\n");
#endif
  if (_modem == LORA) {
    for (int i = 0; i < total; i++) {
      _RSSI = -(OFFSET_RSSI + (_board == SX1276Chip ? 18 : 0)) + readRegister(REG_RSSI_VALUE_LORA);
      rssi_mean += _RSSI;
    }
    rssi_mean = rssi_mean / total;
    _RSSI = rssi_mean;
    state = 0;
#if (SX1272_debug_mode > 0)
    printf("## RSSI value is ");
    printf("%d", _RSSI);
    printf(" ##\n");
    printf("\n");
#endif
  } else {
    for (int i = 0; i < total; i++) {
      _RSSI = (readRegister(REG_RSSI_VALUE_FSK) >> 1);
      rssi_mean += _RSSI;
    }
    rssi_mean = rssi_mean / total;
    _RSSI = rssi_mean;
    state = 0;
#if (SX1272_debug_mode > 0)
    printf("## RSSI value is ");
    printf("%d", _RSSI);
    printf(" ##\n");
    printf("\n");
#endif
  }
  return state;
}
int16_t SX1272::getRSSIpacket() {
  int8_t state = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getRSSIpacket'\n");
#endif
  state = 1;
  if (_modem == LORA) {
    state = getSNR();
    if (state == 0) {
      _RSSIpacket = readRegister(REG_PKT_RSSI_VALUE);
      if (_SNR < 0) {
        _RSSIpacket = -(OFFSET_RSSI + (_board == SX1276Chip ? 18 : 0) + (_channel < CH_04_868 ? 7 : 0)) + (double)_RSSIpacket + (double)_SNR * 0.25;
        state = 0;
      } else {
        _RSSIpacket = -(OFFSET_RSSI + (_board == SX1276Chip ? 18 : 0) + (_channel < CH_04_868 ? 7 : 0)) + (double)_RSSIpacket * 16.0 / 15.0;
        state = 0;
      }
#if (SX1272_debug_mode > 0)
      printf("## RSSI packet value is ");
      printf("%d", _RSSIpacket);
      printf(" ##\n");
      printf("\n");
#endif
    }
  } else {
    state = -1;
#if (SX1272_debug_mode > 0)
    printf("** RSSI packet does not exist in FSK mode **\n");
    printf("\n");
#endif
  }
  return state;
}
uint8_t SX1272::getMaxCurrent() {
  int8_t state = 2;
  byte value;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getMaxCurrent'\n");
#endif
  state = 1;
  _maxCurrent = readRegister(REG_OCP);
  _maxCurrent &= 0B00011111;
  if (_maxCurrent <= 15) {
    value = (45 + (5 * _maxCurrent));
  } else if (_maxCurrent <= 27) {
    value = (-30 + (10 * _maxCurrent));
  } else {
    value = 240;
  }
  _maxCurrent = value;
#if (SX1272_debug_mode > 1)
  printf("## Maximum current supply configured is ");
  printf("%d", value);
  printf(" mA ##\n");
  printf("\n");
#endif
  state = 0;
  return state;
}
int8_t SX1272::setMaxCurrent(uint8_t rate) {
  int8_t state = 2;
  byte st0;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setMaxCurrent'\n");
#endif
  if (rate > 0x1B) {
    state = -1;
#if (SX1272_debug_mode > 1)
    printf("** Maximum current supply is 240 mA, ");
    printf("so maximum parameter value must be 27 (DEC) or 0x1B (HEX) **\n");
    printf("\n");
#endif
  } else {
    rate |= 0B00100000;
    state = 1;
    st0 = readRegister(REG_OP_MODE);
    if (_modem == LORA) {
      writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
    } else {
      writeRegister(REG_OP_MODE, FSK_STANDBY_MODE);
    }
    writeRegister(REG_OCP, rate);
    writeRegister(REG_OP_MODE, st0);
    state = 0;
  }
  return state;
}
uint8_t SX1272::getRegs() {
  int8_t state = 2;
  uint8_t state_f = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getRegs'\n");
#endif
  state_f = 1;
  state = getMode();
  if (state == 0) {
    state = getPower();
  } else {
    state_f = 1;
#if (SX1272_debug_mode > 1)
    printf("** Error getting mode **\n");
#endif
  }
  if (state == 0) {
    state = getChannel();
  } else {
    state_f = 1;
#if (SX1272_debug_mode > 1)
    printf("** Error getting power **\n");
#endif
  }
  if (state == 0) {
    state = getCRC();
  } else {
    state_f = 1;
#if (SX1272_debug_mode > 1)
    printf("** Error getting channel **\n");
#endif
  }
  if (state == 0) {
    state = getHeader();
  } else {
    state_f = 1;
#if (SX1272_debug_mode > 1)
    printf("** Error getting CRC **\n");
#endif
  }
  if (state == 0) {
    state = getPreambleLength();
  } else {
    state_f = 1;
#if (SX1272_debug_mode > 1)
    printf("** Error getting header **\n");
#endif
  }
  if (state == 0) {
    state = getPayloadLength();
  } else {
    state_f = 1;
#if (SX1272_debug_mode > 1)
    printf("** Error getting preamble length **\n");
#endif
  }
  if (state == 0) {
    state = getNodeAddress();
  } else {
    state_f = 1;
#if (SX1272_debug_mode > 1)
    printf("** Error getting payload length **\n");
#endif
  }
  if (state == 0) {
    state = getMaxCurrent();
  } else {
    state_f = 1;
#if (SX1272_debug_mode > 1)
    printf("** Error getting node address **\n");
#endif
  }
  if (state == 0) {
    state_f = getTemp();
  } else {
    state_f = 1;
#if (SX1272_debug_mode > 1)
    printf("** Error getting maximum current supply **\n");
#endif
  }
  if (state_f != 0) {
#if (SX1272_debug_mode > 1)
    printf("** Error getting temperature **\n");
    printf("\n");
#endif
  }
  return state_f;
}
uint8_t SX1272::truncPayload(uint16_t length16) {
  uint8_t state = 2;
  state = 1;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'truncPayload'\n");
#endif
  if (length16 > MAX_PAYLOAD) {
    _payloadlength = MAX_PAYLOAD;
  } else {
    _payloadlength = (length16 & 0xFF);
  }
  state = 0;
  return state;
}
uint8_t SX1272::setACK() {
  uint8_t state = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setACK'\n");
#endif
  if (_limitToA) {
    if (getRemainingToA() - getToA(ACK_LENGTH) < 0) {
      printf("## not enough ToA for ACK at ");
      printf("%d\n", millis());
      return SX1272_ERROR_TOA;
    }
  }
  clearFlags();
  if (_modem == LORA) {
    writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
  } else {
    writeRegister(REG_OP_MODE, FSK_STANDBY_MODE);
  }
  state = setPacketLength(ACK_LENGTH);
  if (state == 0) {
    ACK.dst = packet_received.src;
    ACK.type = PKT_TYPE_ACK;
    ACK.src = packet_received.dst;
    ACK.packnum = packet_received.packnum;
    ACK.length = 2;
    ACK.data[0] = _reception;
    ACK.data[1] = readRegister(REG_PKT_SNR_VALUE);
    writeRegister(REG_FIFO_ADDR_PTR, 0x80);
    state = 1;
    writeRegister(REG_FIFO, ACK.dst);
    writeRegister(REG_FIFO, ACK.type);
    writeRegister(REG_FIFO, ACK.src);
    writeRegister(REG_FIFO, ACK.packnum);
    writeRegister(REG_FIFO, ACK.length);
    writeRegister(REG_FIFO, ACK.data[0]);
    writeRegister(REG_FIFO, ACK.data[1]);
    printf("## ACK set and written in FIFO ##\n");
    printf("## ACK to send:\n");
    printf("Destination: ");
    printf("%d\n", ACK.dst);
    printf("Source: ");
    printf("%d\n", ACK.src);
    printf("ACK number: ");
    printf("%d\n", ACK.packnum);
    printf("ACK length: ");
    printf("%d\n", ACK.length);
    printf("ACK payload: ");
    printf("%d\n", ACK.data[0]);
    printf("ACK SNR last rcv pkt: ");
    printf("%d\n", _SNR);
    printf(" ##\n");
    printf("\n");
    state = 0;
    _reception = CORRECT_PACKET;
    delay(500);
  }
  return state;
}
uint8_t SX1272::receive() {
  uint8_t state = 1;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'receive'\n");
#endif
  memset(&packet_received, 0x00, sizeof(packet_received));
  packet_received.data = packet_data;
  writeRegister(REG_PA_RAMP, 0x08);
  writeRegister(REG_LNA, LNA_MAX_GAIN);
  writeRegister(REG_FIFO_ADDR_PTR, 0x00);
  if (_spreadingFactor == SF_10 || _spreadingFactor == SF_11 || _spreadingFactor == SF_12) {
    writeRegister(REG_SYMB_TIMEOUT_LSB, 0x05);
  } else {
    writeRegister(REG_SYMB_TIMEOUT_LSB, 0x08);
  }
  writeRegister(REG_FIFO_RX_BYTE_ADDR, 0x00);
  if (_modem == LORA) {
    state = setPacketLength(MAX_LENGTH);
    writeRegister(REG_OP_MODE, LORA_RX_MODE);
#if (SX1272_debug_mode > 1)
    printf("## Receiving LoRa mode activated with success ##\n");
    printf("\n");
#endif
  } else {
    state = setPacketLength();
    writeRegister(REG_OP_MODE, FSK_RX_MODE);
#if (SX1272_debug_mode > 1)
    printf("## Receiving FSK mode activated with success ##\n");
    printf("\n");
#endif
  }
  return state;
}
uint8_t SX1272::receivePacketMAXTimeout() { return receivePacketTimeout(MAX_TIMEOUT); }
uint8_t SX1272::receivePacketTimeout() {
  setTimeout();
  return receivePacketTimeout(_sendTime);
}
#ifdef W_REQUESTED_ACK
uint8_t SX1272::receivePacketTimeout(uint16_t wait) {
  uint8_t state = 2;
  uint8_t state_f = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'receivePacketTimeout'\n");
#endif
  state = receive();
  if (state == 0) {
    if (availableData(wait)) {
      state = getPacket();
#if (SX1272_debug_mode > 0)
      printf("getPacket() gives state=%d\n", state);
#endif
    } else {
      state = 1;
      state_f = 3;
    }
  } else {
    state = 1;
    state_f = 1;
  }
  if ((state == 0) || (state == 3) || (state == 5)) {
    if (_reception == INCORRECT_PACKET) {
      state_f = 4;
    } else if (_reception == INCORRECT_PACKET_TYPE) {
      state_f = 5;
    } else {
      state_f = 0;
      getSNR();
      getRSSIpacket();
    }
    if (state == 5 && state_f == 0) {
      state = setACK();
      if (state == 0) {
        uint8_t saved_send_cad_number = _send_cad_number;
        bool saved_extendedIFS = _extendedIFS;
        bool saved_enableCarrierSense = _enableCarrierSense;
        _enableCarrierSense = true;
        _extendedIFS = false;
        _send_cad_number = 3;
        CarrierSense();
        _enableCarrierSense = saved_enableCarrierSense;
        _extendedIFS = saved_extendedIFS;
        _send_cad_number = saved_send_cad_number;
        state = sendWithTimeout();
        if (state == 0) {
          state_f = 0;
#if (SX1272_debug_mode > 1)
          printf("This last packet was an ACK, so ...\n");
          printf("ACK successfully sent\n");
          printf("\n");
#endif
        } else {
          state_f = 1;
        }
      } else {
        state_f = 1;
      }
    }
  } else {
  }
  return state_f;
}
#else
uint8_t SX1272::receivePacketTimeout(uint16_t wait) {
  uint8_t state = 2;
  uint8_t state_f = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'receivePacketTimeout'\n");
#endif
  state = receive();
  if (state == 0) {
    if (availableData(wait)) {
      state_f = getPacket();
    } else {
      state_f = 1;
    }
  } else {
    state_f = state;
  }
  return state_f;
}
#endif
uint8_t SX1272::receivePacketMAXTimeoutACK() { return receivePacketTimeoutACK(MAX_TIMEOUT); }
uint8_t SX1272::receivePacketTimeoutACK() {
  setTimeout();
  return receivePacketTimeoutACK(_sendTime);
}
uint8_t SX1272::receivePacketTimeoutACK(uint16_t wait) {}
uint8_t SX1272::receiveAll() { return receiveAll(MAX_TIMEOUT); }
uint8_t SX1272::receiveAll(uint16_t wait) {
  uint8_t state = 2;
  byte config1;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'receiveAll'\n");
#endif
  if (_modem == FSK) {
    writeRegister(REG_OP_MODE, FSK_STANDBY_MODE);
    config1 = readRegister(REG_PACKET_CONFIG1);
    config1 = config1 & 0B11111001;
    writeRegister(REG_PACKET_CONFIG1, config1);
  }
#if (SX1272_debug_mode > 1)
  printf("## Address filtering desactivated ##\n");
  printf("\n");
#endif
  state = receive();
  if (state == 0) {
    state = getPacket(wait);
  }
  return state;
}
boolean SX1272::availableData() { return availableData(MAX_TIMEOUT); }
boolean SX1272::availableData(uint16_t wait) {
  byte value;
  byte header = 0;
  boolean forme = false;
  boolean _hreceived = false;
  unsigned long exitTime;
#if (SX1272_debug_mode > 0)
  printf("\n");
  printf("Starting 'availableData'\n");
#endif
  exitTime = millis() + (unsigned long)wait;
  if (_modem == LORA) {
    value = readRegister(REG_IRQ_FLAGS);
    while ((bitRead(value, 4) == 0) && (millis() < exitTime)) {
      value = readRegister(REG_IRQ_FLAGS);
      delay(1);
    }
    if (bitRead(value, 4) == 1) {
#if (SX1272_debug_mode > 0)
      printf("## Valid Header received in LoRa mode ##\n");
#endif
      _hreceived = true;
#ifdef W_NET_KEY
      while ((header < 3) && (millis() < exitTime))
#else
      while ((header == 0) && (millis() < exitTime))
#endif
      {
        header = readRegister(REG_FIFO_RX_BYTE_ADDR);
      }
      if (header != 0) {
#ifdef W_NET_KEY
        if (_requestACK == 0) {
          _the_net_key_0 = readRegister(REG_FIFO);
          _the_net_key_1 = readRegister(REG_FIFO);
        }
#endif
        _destination = readRegister(REG_FIFO);
      }
    } else {
      forme = false;
      _hreceived = false;
#if (SX1272_debug_mode > 0)
      printf("** The timeout has expired **\n");
      printf("\n");
#endif
    }
  } else {
    value = readRegister(REG_IRQ_FLAGS2);
    while ((bitRead(value, 2) == 0) && (millis() < exitTime)) {
      value = readRegister(REG_IRQ_FLAGS2);
      delay(1);
    }
    if (bitRead(value, 2) == 1) {
      _hreceived = true;
#if (SX1272_debug_mode > 0)
      printf("## Valid Preamble detected in FSK mode ##\n");
#endif
      _destination = readRegister(REG_FIFO);
    } else {
      forme = false;
      _hreceived = false;
#if (SX1272_debug_mode > 0)
      printf("** The timeout has expired **\n");
      printf("\n");
#endif
    }
  }
  if (_hreceived) {
#if (SX1272_debug_mode > 0)
    printf("## Checking destination ##\n");
#endif
#ifdef W_NET_KEY
    forme = true;
    if (_requestACK == 0)
      if (_the_net_key_0 != _my_netkey[0] || _the_net_key_1 != _my_netkey[1]) {
        printf("## Wrong net key ##\n");
        forme = false;
      } else {
        printf("## Good net key ##\n");
      }
    if (forme && ((_destination == _nodeAddress) || (_destination == BROADCAST_0)))
#else
    if ((_destination == _nodeAddress) || (_destination == BROADCAST_0) || _rawFormat)
#endif
    {
      forme = true;
#if (SX1272_debug_mode > 0)
      printf("## Packet received is for me ##\n");
#endif
    } else {
      forme = false;
#if (SX1272_debug_mode > 0)
      printf("## Packet received is not for me ##\n");
      printf("\n");
#endif
    }
  }
  if (_hreceived == false || forme == false) {
    if (_modem == LORA) {
      writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
    } else {
      writeRegister(REG_OP_MODE, FSK_STANDBY_MODE);
    }
  }
  return forme;
}
uint8_t SX1272::getPacketMAXTimeout() { return getPacket(MAX_TIMEOUT); }
int8_t SX1272::getPacket() { return getPacket(MAX_TIMEOUT); }
int8_t SX1272::getPacket(uint16_t wait) {
  uint8_t state = 2;
  byte value = 0x00;
  unsigned long exitTime;
  boolean p_received = false;
#if (SX1272_debug_mode > 0)
  printf("\n");
  printf("Starting 'getPacket'\n");
#endif
  exitTime = millis() + (unsigned long)wait;
  if (_modem == LORA) {
    value = readRegister(REG_IRQ_FLAGS);
    while ((bitRead(value, 6) == 0) && (millis() < exitTime)) {
      value = readRegister(REG_IRQ_FLAGS);
    }
    if ((bitRead(value, 6) == 1)) {
#if (SX1272_debug_mode > 0)
      printf("## Packet received in LoRa mode ##\n");
#endif
      if (bitRead(readRegister(REG_HOP_CHANNEL), 6)) {
        if ((bitRead(value, 5) == 0)) {
          p_received = true;
          _reception = CORRECT_PACKET;
#if (SX1272_debug_mode > 0)
          printf("** The CRC is correct **\n");
#endif
        } else {
          _reception = INCORRECT_PACKET;
          state = 3;
#if (SX1272_debug_mode > 0)
          printf("** The CRC is incorrect **\n");
#endif
        }
      } else {
        p_received = true;
        _reception = CORRECT_PACKET;
#if (SX1272_debug_mode > 0)
        printf("## Packet supposed to be correct as CrcOnPayload is off at transmitter ##\n");
#endif
      }
    }
    writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
  } else {
    value = readRegister(REG_IRQ_FLAGS2);
    while ((bitRead(value, 2) == 0) && (millis() < exitTime)) {
      value = readRegister(REG_IRQ_FLAGS2);
    }
    if (bitRead(value, 2) == 1) {
      if (bitRead(value, 1) == 1) {
        _reception = CORRECT_PACKET;
        p_received = true;
#if (SX1272_debug_mode > 0)
        printf("## Packet correctly received in FSK mode ##\n");
#endif
      } else {
        _reception = INCORRECT_PACKET;
        state = 3;
        p_received = false;
#if (SX1272_debug_mode > 0)
        printf("## Packet incorrectly received in FSK mode ##\n");
#endif
      }
    } else {
#if (SX1272_debug_mode > 0)
      printf("** The timeout has expired **\n");
      printf("\n");
#endif
    }
    writeRegister(REG_OP_MODE, FSK_STANDBY_MODE);
  }
  if (p_received) {
    if (_modem == LORA) {
      writeRegister(REG_FIFO_ADDR_PTR, 0x00);
#ifdef W_NET_KEY
      packet_received.netkey[0] = readRegister(REG_FIFO);
      packet_received.netkey[1] = readRegister(REG_FIFO);
#endif
      if (!_rawFormat)
        packet_received.dst = readRegister(REG_FIFO);
      else
        packet_received.dst = 0;
    } else {
      value = readRegister(REG_PACKET_CONFIG1);
      if ((bitRead(value, 2) == 0) && (bitRead(value, 1) == 0)) {
        packet_received.dst = readRegister(REG_FIFO);
      } else {
        packet_received.dst = _destination;
      }
    }
    if (!_rawFormat) {
      packet_received.type = readRegister(REG_FIFO);
      if (((packet_received.type & PKT_TYPE_MASK) != PKT_TYPE_DATA) && ((packet_received.type & PKT_TYPE_MASK) != PKT_TYPE_ACK)) {
        _reception = INCORRECT_PACKET_TYPE;
        state = 3;
#if (SX1272_debug_mode > 0)
        printf("** The packet type is incorrect **\n");
#endif
      } else {
        packet_received.src = readRegister(REG_FIFO);
        packet_received.packnum = readRegister(REG_FIFO);
      }
    } else {
      packet_received.type = 0;
      packet_received.src = 0;
      packet_received.packnum = 0;
    }
    if (_reception == CORRECT_PACKET) {
      packet_received.length = readRegister(REG_RX_NB_BYTES);
      if (_modem == LORA) {
        if (_rawFormat) {
          _payloadlength = packet_received.length;
        } else
          _payloadlength = packet_received.length - OFFSET_PAYLOADLENGTH;
      }
      if (packet_received.length > (MAX_LENGTH + 1)) {
#if (SX1272_debug_mode > 0)
        printf("Corrupted packet, length must be less than 256\n");
#endif
      } else {
        for (unsigned int i = 0; i < _payloadlength; i++) {
          packet_received.data[i] = readRegister(REG_FIFO);
        }
#if (SX1272_debug_mode > 0)
        printf("## Packet received:\n");
        printf("Destination: ");
        printf("%d\n", packet_received.dst);
        printf("Type: ");
        printf("%d\n", packet_received.type);
        printf("Source: ");
        printf("%d\n", packet_received.src);
        printf("Packet number: ");
        printf("%d\n", packet_received.packnum);
        printf("Packet length: ");
        printf("%d\n", packet_received.length);
        printf("Data: ");
        for (unsigned int i = 0; i < _payloadlength; i++) {
          printf("%c", packet_received.data[i]);
        }
        printf("\n");
        printf(" ##\n");
        printf("\n");
#endif
        state = 0;
#ifdef W_REQUESTED_ACK
        if (packet_received.type & PKT_FLAG_ACK_REQ) {
          state = 5;
          _requestACK_indicator = 1;
        } else
          _requestACK_indicator = 0;
#endif
      }
    }
  } else {
    if ((_reception == INCORRECT_PACKET) && (_retries < _maxRetries)) {
      _retries++;
#if (SX1272_debug_mode > 0)
      printf("## Retrying to send the last packet ##\n");
      printf("\n");
#endif
    }
  }
  if (_modem == LORA) {
    writeRegister(REG_FIFO_ADDR_PTR, 0x00);
  }
  clearFlags();
  if (wait > MAX_WAIT) {
    state = -1;
#if (SX1272_debug_mode > 0)
    printf("** The timeout must be smaller than 12.5 seconds **\n");
    printf("\n");
#endif
  }
  return state;
}
int8_t SX1272::setDestination(uint8_t dest) {
  int8_t state = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setDestination'\n");
#endif
  state = 1;
  _destination = dest;
  packet_sent.dst = dest;
  packet_sent.src = _nodeAddress;
  packet_sent.packnum = _packetNumber;
  _packetNumber++;
  state = 0;
#if (SX1272_debug_mode > 1)
  printf("## Destination ");
  printf("%X", _destination);
  printf(" successfully set ##\n");
  printf("## Source ");
  printf("%d", packet_sent.src);
  printf(" successfully set ##\n");
  printf("## Packet number ");
  printf("%d", packet_sent.packnum);
  printf(" successfully set ##\n");
  printf("\n");
#endif
  return state;
}
uint8_t SX1272::setTimeout() {
  uint8_t state = 2;
  uint16_t delay;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setTimeout'\n");
#endif
  state = 1;
  _sendTime = MAX_TIMEOUT;
#if (SX1272_debug_mode > 1)
  printf("Timeout to send/receive is: ");
  printf("%d", _sendTime);
  printf("\n");
#endif
  state = 0;
  return state;
}
uint8_t SX1272::setPayload(uint8_t *payload) {
  uint8_t state = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setPayload'\n");
#endif
  state = 1;
  if ((_modem == FSK) && (_payloadlength > MAX_PAYLOAD_FSK)) {
    _payloadlength = MAX_PAYLOAD_FSK;
    state = 1;
#if (SX1272_debug_mode > 1)
    printf("In FSK, payload length must be less than 60 bytes.\n");
    printf("\n");
#endif
  }
  for (unsigned int i = 0; i < _payloadlength; i++) {
    packet_sent.data[i] = payload[i];
  }
  state = setPacketLength();
  return state;
}
uint8_t SX1272::setPacket(uint8_t dest, uint8_t *payload) {
  int8_t state = 2;
  byte st0;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setPacket'\n");
#endif
  if (_limitToA) {
    uint16_t length16 = _payloadlength;
    if (!_rawFormat)
      length16 = length16 + OFFSET_PAYLOADLENGTH;
    if (getRemainingToA() - getToA(length16) < 0) {
      printf("## not enough ToA at ");
      printf("%d\n", millis());
      return SX1272_ERROR_TOA;
    }
  }
  st0 = readRegister(REG_OP_MODE);
  clearFlags();
  if (_modem == LORA) {
    writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
  } else {
    writeRegister(REG_OP_MODE, FSK_STANDBY_MODE);
  }
  _reception = CORRECT_PACKET;
  if (_retries == 0) {
    state = setDestination(dest);
    if (state == 0) {
      state = setPayload(payload);
    }
  } else {
    if (_retries == 1) {
      packet_sent.length++;
    }
    state = setPacketLength();
    packet_sent.retry = _retries;
#if (SX1272_debug_mode > 0)
    printf("** Retrying to send last packet ");
    printf("%d", _retries);
    printf(" time **\n");
#endif
  }
  packet_sent.type |= PKT_TYPE_DATA;
#ifdef W_REQUESTED_ACK
  if (_requestACK)
    packet_sent.type |= PKT_FLAG_ACK_REQ;
#endif
  writeRegister(REG_FIFO_ADDR_PTR, 0x80);
  if (state == 0) {
    state = 1;
#ifdef W_NET_KEY
    packet_sent.netkey[0] = _my_netkey[0];
    packet_sent.netkey[1] = _my_netkey[1];
    writeRegister(REG_FIFO, packet_sent.netkey[0]);
    writeRegister(REG_FIFO, packet_sent.netkey[1]);
#endif
    writeRegister(REG_FIFO, packet_sent.dst);
    writeRegister(REG_FIFO, packet_sent.type);
    writeRegister(REG_FIFO, packet_sent.src);
    writeRegister(REG_FIFO, packet_sent.packnum);
    for (unsigned int i = 0; i < _payloadlength; i++) {
      writeRegister(REG_FIFO, packet_sent.data[i]);
    }
    state = 0;
#if (SX1272_debug_mode > 0)
    printf("## Packet set and written in FIFO ##\n");
    printf("## Packet to send:	\n");
    printf("Destination: ");
    printf("%d\n", packet_sent.dst);
    printf("Type: ");
    printf("%d\n", packet_sent.type);
    printf("Source: ");
    printf("%d\n", packet_sent.src);
    printf("Packet number: ");
    printf("%d\n", packet_sent.packnum);
    printf("Packet length: ");
    printf("%d\n", packet_sent.length);
    printf("Data: ");
    for (unsigned int i = 0; i < _payloadlength; i++) {
      printf("%c", packet_sent.data[i]);
    }
    printf("\n");
    printf(" ##\n");
    printf("\n");
#endif
  }
  writeRegister(REG_OP_MODE, st0);
  return state;
}
uint8_t SX1272::sendWithMAXTimeout() { return sendWithTimeout(MAX_TIMEOUT); }
uint8_t SX1272::sendWithTimeout() {
  setTimeout();
  return sendWithTimeout(_sendTime);
}
uint8_t SX1272::sendWithTimeout(uint16_t wait) {
  uint8_t state = 2;
  byte value = 0x00;
  unsigned long exitTime;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'sendWithTimeout'\n");
#endif
  exitTime = millis() + (unsigned long)wait;
  if (_modem == LORA) {
    clearFlags();
    writeRegister(REG_OP_MODE, LORA_TX_MODE);
    value = readRegister(REG_IRQ_FLAGS);
    while ((bitRead(value, 3) == 0) && (millis() < exitTime)) {
      value = readRegister(REG_IRQ_FLAGS);
    }
    state = 1;
  } else {
    writeRegister(REG_OP_MODE, FSK_TX_MODE);
    value = readRegister(REG_IRQ_FLAGS2);
    while ((bitRead(value, 3) == 0) && (millis() < exitTime)) {
      value = readRegister(REG_IRQ_FLAGS2);
    }
    state = 1;
  }
  if (bitRead(value, 3) == 1) {
    state = 0;
#if (SX1272_debug_mode > 1)
    printf("## Packet successfully sent ##\n");
    printf("\n");
#endif
  } else {
    if (state == 1) {
#if (SX1272_debug_mode > 1)
      printf("** Timeout has expired **\n");
      printf("\n");
#endif
    } else {
#if (SX1272_debug_mode > 1)
      printf("** There has been an error and packet has not been sent **\n");
      printf("\n");
#endif
    }
  }
  clearFlags();
  return state;
}
uint8_t SX1272::sendPacketMAXTimeout(uint8_t dest, uint8_t *payload, uint16_t length16) { return sendPacketTimeout(dest, payload, length16, MAX_TIMEOUT); }
uint8_t SX1272::sendPacketTimeout(uint8_t dest, uint8_t *payload, uint16_t length16) {
  uint8_t state = 2;
  uint8_t state_f = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'sendPacketTimeout'\n");
#endif
  state = truncPayload(length16);
  if (state == 0) {
    state_f = setPacket(dest, payload);
  } else {
    state_f = state;
  }
  if (state_f == 0) {
    state_f = sendWithTimeout();
  }
  return state_f;
}
uint8_t SX1272::sendPacketTimeout(uint8_t dest, uint8_t *payload, uint16_t length16, uint16_t wait) {
  uint8_t state = 2;
  uint8_t state_f = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'sendPacketTimeout'\n");
#endif
  state = truncPayload(length16);
  if (state == 0) {
    state_f = setPacket(dest, payload);
  } else {
    state_f = state;
  }
  if (state_f == 0) {
    state_f = sendWithTimeout(wait);
  }
  return state_f;
}
uint8_t SX1272::sendPacketMAXTimeoutACK(uint8_t dest, uint8_t *payload, uint16_t length16) { return sendPacketTimeoutACK(dest, payload, length16, MAX_TIMEOUT); }
uint8_t SX1272::sendPacketTimeoutACK(uint8_t dest, uint8_t *payload, uint16_t length16) {
  uint8_t state = 2;
  uint8_t state_f = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'sendPacketTimeoutACK'\n");
#endif
#ifdef W_REQUESTED_ACK
  _requestACK = 1;
#endif
  state = sendPacketTimeout(dest, payload, length16);
  if (state == 0) {
    state = receive();
  } else {
    state_f = state;
  }
  if (state == 0) {
    printf("wait for ACK\n");
    if (availableData()) {
      state_f = getACK();
    } else {
      state_f = SX1272_ERROR_ACK;
      printf("no ACK\n");
    }
  } else {
    state_f = state;
  }
#ifdef W_REQUESTED_ACK
  _requestACK = 0;
#endif
  return state_f;
}
uint8_t SX1272::sendPacketTimeoutACK(uint8_t dest, uint8_t *payload, uint16_t length16, uint16_t wait) {
  uint8_t state = 2;
  uint8_t state_f = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'sendPacketTimeoutACK'\n");
#endif
#ifdef W_REQUESTED_ACK
  _requestACK = 1;
#endif
  state = sendPacketTimeout(dest, payload, length16, wait);
  if (state == 0) {
    state = receive();
  } else {
    state_f = 1;
  }
  if (state == 0) {
    printf("wait for ACK\n");
    if (availableData()) {
      state_f = getACK();
    } else {
      state_f = SX1272_ERROR_ACK;
      printf("no ACK\n");
    }
  } else {
    state_f = 1;
  }
#ifdef W_REQUESTED_ACK
  _requestACK = 0;
#endif
  return state_f;
}
uint8_t SX1272::getACK() { return getACK(MAX_TIMEOUT); }
uint8_t SX1272::getACK(uint16_t wait) {
  uint8_t state = 2;
  byte value = 0x00;
  unsigned long exitTime;
  boolean a_received = false;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getACK'\n");
#endif
  exitTime = millis() + (unsigned long)wait;
  if (_modem == LORA) {
    value = readRegister(REG_IRQ_FLAGS);
    while ((bitRead(value, 6) == 0) && (millis() < exitTime)) {
      value = readRegister(REG_IRQ_FLAGS);
    }
    if (bitRead(value, 6) == 1) {
      a_received = true;
    }
    writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
  } else {
    value = readRegister(REG_IRQ_FLAGS2);
    while ((bitRead(value, 2) == 0) && (millis() < exitTime)) {
      value = readRegister(REG_IRQ_FLAGS2);
    }
    if (bitRead(value, 2) == 1) {
      a_received = true;
    }
    writeRegister(REG_OP_MODE, FSK_STANDBY_MODE);
  }
  if (a_received) {
    ACK.dst = _destination;
    ACK.type = readRegister(REG_FIFO);
    ACK.src = readRegister(REG_FIFO);
    ACK.packnum = readRegister(REG_FIFO);
    ACK.length = readRegister(REG_FIFO);
    ACK.data[0] = readRegister(REG_FIFO);
    ACK.data[1] = readRegister(REG_FIFO);
    if (ACK.type == PKT_TYPE_ACK) {
      if (ACK.dst == packet_sent.src) {
        if (ACK.src == packet_sent.dst) {
          if (ACK.packnum == packet_sent.packnum) {
            if (ACK.length == 2) {
              if (ACK.data[0] == CORRECT_PACKET) {
                state = 0;
                printf("## ACK received:\n");
                printf("Destination: ");
                printf("%d\n", ACK.dst);
                printf("Source: ");
                printf("%d\n", ACK.src);
                printf("ACK number: ");
                printf("%d\n", ACK.packnum);
                printf("ACK length: ");
                printf("%d\n", ACK.length);
                printf("ACK payload: ");
                printf("%d\n", ACK.data[0]);
                printf("ACK SNR of rcv pkt at gw: ");
                value = ACK.data[1];
                if (value & 0x80) {
                  value = ((~value + 1) & 0xFF) >> 2;
                  _rcv_snr_in_ack = -value;
                } else {
                  _rcv_snr_in_ack = (value & 0xFF) >> 2;
                }
                printf("%d\n", _rcv_snr_in_ack);
                printf(" ##\n");
                printf("\n");
              } else {
                state = 1;
#if (SX1272_debug_mode > 0)
                printf("** N-ACK received **\n");
                printf("\n");
#endif
              }
            } else {
              state = 1;
#if (SX1272_debug_mode > 0)
              printf("** ACK length incorrectly received **\n");
              printf("\n");
#endif
            }
          } else {
            state = 1;
#if (SX1272_debug_mode > 0)
            printf("** ACK number incorrectly received **\n");
            printf("\n");
#endif
          }
        } else {
          state = 1;
#if (SX1272_debug_mode > 0)
          printf("** ACK source incorrectly received **\n");
          printf("\n");
#endif
        }
      }
    } else {
      state = 1;
#if (SX1272_debug_mode > 0)
      printf("** ACK destination incorrectly received **\n");
      printf("\n");
#endif
    }
  } else {
    state = 1;
#if (SX1272_debug_mode > 0)
    printf("** ACK lost **\n");
    printf("\n");
#endif
  }
  clearFlags();
  return state;
}
uint8_t SX1272::getTemp() {
  byte st0;
  uint8_t state = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getTemp'\n");
#endif
  st0 = readRegister(REG_OP_MODE);
  if (_modem == LORA) {
    writeRegister(REG_OP_MODE, LORA_STANDBY_FSK_REGS_MODE);
  }
  state = 1;
  _temp = readRegister(REG_TEMP);
  if (_temp & 0x80) {
    _temp = ((~_temp + 1) & 0xFF);
  } else {
    _temp = (_temp & 0xFF);
  }
#if (SX1272_debug_mode > 1)
  printf("## Temperature is: ");
  printf("%d", _temp);
  printf(" ##\n");
  printf("\n");
#endif
  if (_modem == LORA) {
    writeRegister(REG_OP_MODE, st0);
  }
  state = 0;
  return state;
}
void SX1272::setPacketType(uint8_t type) {
  packet_sent.type = type;
  if (type & PKT_FLAG_ACK_REQ)
    _requestACK = 1;
}
uint8_t SX1272::doCAD(uint8_t counter) {
  uint8_t state = 2;
  byte value = 0x00;
  unsigned long startCAD, endCAD, startDoCad, endDoCad;
  unsigned long exitTime;
  uint16_t wait = 100;
  bool failedCAD = false;
  uint8_t retryCAD = 3;
  uint8_t save_counter;
  byte st0;
  st0 = readRegister(REG_OP_MODE);
#ifdef DEBUG_CAD
  printf("SX1272::Starting 'doCAD'\n");
#endif
  save_counter = counter;
  startDoCad = millis();
  if (_modem == LORA) {
    writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
    do {
      startCAD = millis();
      exitTime = millis() + (unsigned long)wait;
      clearFlags();
      writeRegister(REG_OP_MODE, LORA_CAD_MODE);
      value = readRegister(REG_IRQ_FLAGS);
      while ((bitRead(value, 2) == 0) && (millis() < exitTime)) {
        value = readRegister(REG_IRQ_FLAGS);
      }
      state = 1;
      endCAD = millis();
      if (bitRead(value, 2) == 1) {
        state = 0;
#ifdef DEBUG_CAD
        printf("SX1272::CAD duration ");
        printf("%d\n", endCAD - startCAD);
        printd("SX1272::CAD successfully performed\n");
#endif
        value = readRegister(REG_IRQ_FLAGS);
        if (bitRead(value, 0) == 1) {
          failedCAD = true;
#ifdef DEBUG_CAD
          printf("SX1272::CAD exits after ");
          printf("%d\n", save_counter - counter);
#endif
        }
        counter--;
      } else {
#ifdef DEBUG_CAD
                                                                printf("SX1272::CAD duration "));
                                                                printf("%d\n", endCAD - startCAD);
#endif
                                                                if (state == 1) {
#ifdef DEBUG_CAD
                                                                  printf("SX1272::Timeout has expired\n");
#endif
                                                                } else {
#ifdef DEBUG_CAD
                                                                  printf("SX1272::Error and CAD has not been performed\n");
#endif
                                                                }
                                                                retryCAD--;
                                                                if (!retryCAD)
                                                                  failedCAD = true;
      }
    } while (counter && !failedCAD);
  }
  writeRegister(REG_OP_MODE, st0);
  endDoCad = millis();
  clearFlags();
#ifdef DEBUG_CAD
  printf("SX1272::doCAD duration ");
  printf("%d\n", endDoCad - startDoCad);
#endif
  if (failedCAD)
    return 2;
  return state;
}
uint16_t SX1272::getToA(uint8_t pl) {
  uint8_t DE = 0;
  uint32_t airTime = 0;
  double bw = 0.0;
  bw = (_bandwidth == BW_125) ? 125e3 : ((_bandwidth == BW_250) ? 250e3 : 500e3);
#ifdef DEBUG_GETTOA
  printf("SX1272::bw is ");
  printf("%d\n", bw);
  printf("SX1272::SF is ");
  printf("%d\n", _spreadingFactor);
#endif
  double rs = bw / (1 << _spreadingFactor);
  double ts = 1 / rs;
  double tPreamble = ((_preamblelength + 4) + 4.25) * ts;
#ifdef DEBUG_GETTOA
  printf("SX1272::ts is ");
  printf("%f\n", ts);
  printf("SX1272::tPreamble is ");
  printf("%f\n", tPreamble);
#endif
  if ((_bandwidth == BW_125) && _spreadingFactor == 12)
    DE = 1;
  double tmp = (8 * pl - 4 * _spreadingFactor + 28 + 16 - 20 * _header) / (double)(4 * (_spreadingFactor - 2 * DE));
#ifdef DEBUG_GETTOA
  printf("SX1272::tmp is ");
  printf("%f\n", tmp);
#endif
  tmp = ceil(tmp) * (_codingRate + 4);
  double nPayload = 8 + ((tmp > 0) ? tmp : 0);
#ifdef DEBUG_GETTOA
  printf("SX1272::nPayload is ");
  printf("%d\n", nPayload);
#endif
  double tPayload = nPayload * ts;
  double tOnAir = tPreamble + tPayload;
  airTime = floor(tOnAir * 1e6 + 0.999);
#ifdef DEBUG_GETTOA
  printf("SX1272::airTime is ");
  printf("%d\n", airTime);
#endif
  return ceil(airTime / 1000) + 1;
}
void SX1272::CarrierSense(uint8_t cs) {
  if (cs == 1)
    CarrierSense1();
  if (cs == 2)
    CarrierSense2();
  if (cs == 3)
    CarrierSense3();
}
void SX1272::CarrierSense1() {
  int e;
  bool carrierSenseRetry = false;
  uint8_t retries = 3;
  uint8_t DIFSretries = 8;
  printf("--> CS1\n");
  if (_send_cad_number && _enableCarrierSense) {
    do {
      DIFSretries = 8;
      do {
        _startDoCad = millis();
        e = doCAD(_send_cad_number);
        _endDoCad = millis();
        printf("--> CAD ");
        printf("%d\n", _endDoCad - _startDoCad);
        if (!e) {
          printf("OK1\n");
          if (_extendedIFS) {
            uint8_t w = rand() % 8 + 1;
            printf("--> wait for ");
            printf("%d", w);
            printf(" CAD = ");
            printf("%d\n", sx1272_CAD_value[_loraMode] * w);
            delay(sx1272_CAD_value[_loraMode] * w);
            _startDoCad = millis();
            e = doCAD(_send_cad_number);
            _endDoCad = millis();
            printf("--> CAD ");
            printf("%d\n", _endDoCad - _startDoCad);
            if (!e)
              printf("OK2\n");
            else
              printf("#2\n");
          }
        } else {
          printf("#1\n");
          uint8_t w = rand() % 8 + 1;
          printf("--> wait for ");
          printf("%d", w);
          printf(" DIFS=3SIFS= ");
          printf("%d\n", sx1272_SIFS_value[_loraMode] * 3 * w);
          delay(sx1272_SIFS_value[_loraMode] * 3 * w);
          printf("--> retry\n");
        }
      } while (e && --DIFSretries);
      if (_RSSIonSend) {
        e = getRSSI();
        uint8_t rssi_retry_count = 8;
        if (!e) {
          do {
            getRSSI();
            printf("--> RSSI ");
            printf("%d\n", _RSSI);
            rssi_retry_count--;
            delay(1);
          } while (_RSSI > -90 && rssi_retry_count);
        } else
          printf("--> RSSI error\n");
        if (!rssi_retry_count)
          carrierSenseRetry = true;
        else
          carrierSenseRetry = false;
      }
    } while (carrierSenseRetry && --retries);
  }
}
void SX1272::CarrierSense2() {
  int e;
  bool carrierSenseRetry = false;
  uint8_t foundBusyDuringDIFSafterBusyState = 0;
  uint8_t retries = 3;
  uint8_t DIFSretries = 8;
  uint8_t n_collision = 0;
  uint8_t W = 2;
  uint32_t max_toa = sx1272.getToA(MAX_LENGTH);
  printf("--> CS2\n");
  if (_send_cad_number && _enableCarrierSense) {
    do {
      DIFSretries = 8;
      do {
        if (foundBusyDuringDIFSafterBusyState > 1 && foundBusyDuringDIFSafterBusyState < 5)
          W = W * 2;
        _startDoCad = millis();
        e = sx1272.doCAD(_send_cad_number);
        _endDoCad = millis();
        printf("--> DIFS ");
        printf("%ld\n", _endDoCad - _startDoCad);
        if (!e) {
          if (n_collision) {
            printf("--> count for ");
            uint8_t w = rand() % (W * _send_cad_number) + 1;
            printf("%d\n", w);
            int busyCount = 0;
            bool nowBusy = false;
            do {
              if (nowBusy)
                e = sx1272.doCAD(_send_cad_number);
              else
                e = sx1272.doCAD(1);
              if (nowBusy && e) {
                printf("#");
                busyCount++;
              } else if (nowBusy && !e) {
                printf("|");
                nowBusy = false;
              } else if (!e) {
                w--;
                printf("-");
              } else {
                printf("*");
                nowBusy = true;
                busyCount++;
              }
            } while (w);
            printf("\n--> found busy during ");
            printf("%d\n", busyCount);
          } else {
            printf("OK1\n");
            if (_extendedIFS) {
              uint8_t w = rand() % 8 + 1;
              printf("--> extended wait for ");
              printf("%d\n", w);
              printf(" CAD = ");
              printf("%d\n", sx1272_CAD_value[_loraMode] * w);
              delay(sx1272_CAD_value[_loraMode] * w);
              _startDoCad = millis();
              e = sx1272.doCAD(_send_cad_number);
              _endDoCad = millis();
              printf("--> CAD ");
              printf("%ld\n", _endDoCad - _startDoCad);
              if (!e)
                printf("OK2\n");
              else
                printf("#2\n");
            }
          }
        } else {
          n_collision++;
          foundBusyDuringDIFSafterBusyState++;
          printf("###");
          printf("%d\n", n_collision);
          printf("--> CAD until clear\n");
          int busyCount = 0;
          _startDoCad = millis();
          do {
            e = sx1272.doCAD(1);
            if (e) {
              printf("R");
              busyCount++;
            }
          } while (e && (millis() - _startDoCad < 2 * max_toa));
          _endDoCad = millis();
          printf("\n--> found busy during ");
          printf("%d\n", busyCount);
          printf("--> wait duration ");
          printf("%ld\n", _endDoCad - _startDoCad);
          printf("--> retry\n");
          e = 1;
        }
      } while (e && --DIFSretries);
      if (_RSSIonSend) {
        e = getRSSI();
        uint8_t rssi_retry_count = 8;
        if (!e) {
          do {
            getRSSI();
            printf("--> RSSI ");
            printf("%d\n", _RSSI);
            rssi_retry_count--;
            delay(1);
          } while (_RSSI > -90 && rssi_retry_count);
        } else
          printf("--> RSSI error\n");
        if (!rssi_retry_count)
          carrierSenseRetry = true;
        else
          carrierSenseRetry = false;
      }
    } while (carrierSenseRetry && --retries);
  }
}
void SX1272::CarrierSense3() {
  int e;
  bool carrierSenseRetry = false;
  uint8_t n_collision = 0;
  uint8_t retries = 3;
  uint8_t n_cad = 9;
  uint32_t max_toa = sx1272.getToA(MAX_LENGTH);
  if (_send_cad_number && _enableCarrierSense) {
    do {
      printf("--> CAD for MaxToa=");
      printf("%ld\n", max_toa);
      for (int i = 0; i < n_cad; i++) {
        _startDoCad = millis();
        e = sx1272.doCAD(1);
        _endDoCad = millis();
        if (!e) {
          printf("%ld", _endDoCad);
          printf(" 0 ");
          printf("%d\n", sx1272._RSSI);
          printf(" ");
          printf("%ld\n", _endDoCad - _startDoCad);
        } else
          continue;
        delay(max_toa / (n_cad - 1) - (millis() - _startDoCad));
      }
      if (e) {
        n_collision++;
        printf("###");
        printf("%d\n", n_collision);
        printf("Channel busy. Wait for MaxToA=");
        printf("%ld\n", max_toa);
        delay(max_toa);
        printf("--> retry\n");
        carrierSenseRetry = true;
      } else
        carrierSenseRetry = false;
    } while (carrierSenseRetry && --retries);
  }
}
int8_t SX1272::getSyncWord() {
  int8_t state = 2;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'getSyncWord'\n");
#endif
  if (_modem == FSK) {
    state = -1;
#if (SX1272_debug_mode > 1)
    printf("** FSK mode hasn't sync word **\n");
#endif
  } else {
    _syncWord = readRegister(REG_SYNC_WORD);
    state = 0;
#if (SX1272_debug_mode > 1)
    printf("## Sync word is ");
    printf("%X", _syncWord);
    printf(" ##\n");
#endif
  }
  return state;
}
int8_t SX1272::setSyncWord(uint8_t sw) {
  byte st0;
  int8_t state = 2;
  byte config1;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setSyncWord'\n");
#endif
  st0 = readRegister(REG_OP_MODE);
  if (_modem == FSK) {
#if (SX1272_debug_mode > 1)
    printf("## Notice that FSK hasn't sync word parameter, ");
    printf("so you are configuring it in LoRa mode ##\n");
#endif
    state = setLORA();
  }
  writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
  writeRegister(REG_SYNC_WORD, sw);
  delay(100);
  config1 = readRegister(REG_SYNC_WORD);
  if (config1 == sw) {
    state = 0;
    _syncWord = sw;
#if (SX1272_debug_mode > 1)
    printf("## Sync Word ");
    printf("%X\n", sw);
    printf(" has been successfully set ##\n");
#endif
  } else {
    state = 1;
#if (SX1272_debug_mode > 1)
    printf("** There has been an error while configuring Sync Word parameter **\n");
#endif
  }
  writeRegister(REG_OP_MODE, st0);
  delay(100);
  return state;
}
int8_t SX1272::setSleepMode() {
  int8_t state = 2;
  byte value;
  writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
  delay(100);
  writeRegister(REG_OP_MODE, LORA_SLEEP_MODE);
  value = readRegister(REG_OP_MODE);
  if (value == LORA_SLEEP_MODE)
    state = 0;
  else
    state = 1;
  return state;
}
int8_t SX1272::setPowerDBM(uint8_t dbm) {
  byte st0;
  int8_t state = 2;
  byte value = 0x00;
  byte RegPaDacReg = (_board == SX1272Chip) ? 0x5A : 0x4D;
#if (SX1272_debug_mode > 1)
  printf("\n");
  printf("Starting 'setPowerDBM'\n");
#endif
  st0 = readRegister(REG_OP_MODE);
  if (_modem == LORA) {
    writeRegister(REG_OP_MODE, LORA_STANDBY_MODE);
  } else {
    writeRegister(REG_OP_MODE, FSK_STANDBY_MODE);
  }
  if (dbm == 20) {
    return setPower('X');
  }
  if (dbm > 14)
    return state;
  writeRegister(RegPaDacReg, 0x84);
  if (dbm > 10)
    setMaxCurrent(0x10);
  else
    setMaxCurrent(0x0B);
  if (_board == SX1272Chip) {
    if (_needPABOOST) {
      value = dbm - 2;
      value = value | 0B10000000;
    } else
      value = dbm + 1;
    writeRegister(REG_PA_CONFIG, value);
  } else {
    uint8_t pmax = 15;
    if (_needPABOOST) {
      value = dbm - 17 + 15;
      value = value | 0B10000000;
    } else
      value = dbm - pmax + 15;
    value = value | 0B01110000;
    writeRegister(REG_PA_CONFIG, value);
  }
  _power = value;
  value = readRegister(REG_PA_CONFIG);
  if (value == _power) {
    state = 0;
#if (SX1272_debug_mode > 1)
    printf("## Output power has been successfully set ##\n");
    printf("\n");
#endif
  } else {
    state = 1;
  }
  writeRegister(REG_OP_MODE, st0);
  delay(100);
  return state;
}
long SX1272::limitToA() {
  if (_limitToA == false) {
    _startToAcycle = millis();
    _remainingToA = MAX_DUTY_CYCLE_PER_HOUR;
    _endToAcycle = _startToAcycle + DUTYCYCLE_DURATION;
  }
  _limitToA = true;
  return getRemainingToA();
}
long SX1272::getRemainingToA() {
  if (_limitToA == false)
    return MAX_DUTY_CYCLE_PER_HOUR;
  if ((millis() > _endToAcycle)) {
    _startToAcycle = _endToAcycle;
    _remainingToA = MAX_DUTY_CYCLE_PER_HOUR;
    _endToAcycle = _startToAcycle + DUTYCYCLE_DURATION;
    printf("## new cycle for ToA ##\n");
    printf("cycle begins at ");
    printf("%ld", _startToAcycle);
    printf(" cycle ends at ");
    printf("%ld", _endToAcycle);
    printf(" remaining ToA is ");
    printf("%ld\n", _remainingToA);
  }
  return _remainingToA;
}
long SX1272::removeToA(uint16_t toa) {
  getRemainingToA();
  if (_limitToA) {
    _remainingToA -= toa;
  }
  return _remainingToA;
}
SX1272 sx1272 = SX1272();

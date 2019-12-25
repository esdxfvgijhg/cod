#include <SPI.h>	
#include "SX1272.h"

#define ETSI_EUROPE_REGULATION
//#define FCC_US_REGULATION
//#define SENEGAL_REGULATION

// uncomment if your radio is an HopeRF RFM92W, HopeRF RFM95W, Modtronix inAir9B, NiceRF1276 or you known from the circuit diagram that output use the PABOOST line instead of the RFO line
#define PABOOST

#define BAND868
//#define BAND900
//#define BAND433

#ifdef ETSI_EUROPE_REGULATION
#define MAX_DBM 14
#elif defined SENEGAL_REGULATION
#define MAX_DBM 10
#elif defined FCC_US_REGULATION
#define MAX_DBM 14
#endif

#ifdef BAND868
#ifdef SENEGAL_REGULATION
const uint32_t DEFAULT_CHANNEL=CH_04_868;
#else
const uint32_t DEFAULT_CHANNEL=CH_10_868;
#endif
#elif defined BAND900
const uint32_t DEFAULT_CHANNEL=CH_05_900;
#elif defined BAND433
const uint32_t DEFAULT_CHANNEL=CH_00_433;
#endif

#define LORAMODE	1
#define node_addr 8
#define DEFAULT_DEST_ADDR 1

// we wrapped Serial.println to support the Arduino Zero or M0
#if defined __SAMD21G18A__ && not defined ARDUINO_SAMD_FEATHER_M0
#define PRINTLN									 SerialUSB.println("")
#define PRINT_CSTSTR(fmt,param)	 SerialUSB.print(F(param))
#define PRINT_STR(fmt,param)			SerialUSB.print(param)
#define PRINT_VALUE(fmt,param)		SerialUSB.print(param)
#define FLUSHOUTPUT							 SerialUSB.flush();
#else
#define PRINTLN									 Serial.println("")
#define PRINT_CSTSTR(fmt,param)	 Serial.print(F(param))
#define PRINT_STR(fmt,param)			Serial.print(param)
#define PRINT_VALUE(fmt,param)		Serial.print(param)
#define FLUSHOUTPUT							 Serial.flush();
#endif

uint8_t message[100];

int loraMode=LORAMODE;

void setup(){
	int e;
		// Open serial communications and wait for port to open:
	#if defined __SAMD21G18A__ && not defined ARDUINO_SAMD_FEATHER_M0 
		SerialUSB.begin(38400);
	#else
		Serial.begin(38400);	
	#endif 

	// Print a start message
	PRINT_CSTSTR("%s","Simple LoRa ping-pong with the gateway\n");	

	#ifdef ARDUINO_AVR_PRO
		PRINT_CSTSTR("%s","Arduino Pro Mini detected\n");	
	#endif
	#ifdef ARDUINO_AVR_NANO
		PRINT_CSTSTR("%s","Arduino Nano detected\n");	 
	#endif
	#ifdef ARDUINO_AVR_MINI
		PRINT_CSTSTR("%s","Arduino MINI/Nexus detected\n");	
	#endif
	#ifdef ARDUINO_AVR_MEGA2560
		PRINT_CSTSTR("%s","Arduino Mega2560 detected\n");	
	#endif
	#ifdef ARDUINO_SAM_DUE
		PRINT_CSTSTR("%s","Arduino Due detected\n");	
	#endif
	#ifdef __MK66FX1M0__
		PRINT_CSTSTR("%s","Teensy36 MK66FX1M0 detected\n");
	#endif
	#ifdef __MK64FX512__
		PRINT_CSTSTR("%s","Teensy35 MK64FX512 detected\n");
	#endif
	#ifdef __MK20DX256__
		PRINT_CSTSTR("%s","Teensy31/32 MK20DX256 detected\n");
	#endif
	#ifdef __MKL26Z64__
		PRINT_CSTSTR("%s","TeensyLC MKL26Z64 detected\n");
	#endif
	#if defined ARDUINO_SAMD_ZERO && not defined ARDUINO_SAMD_FEATHER_M0
		PRINT_CSTSTR("%s","Arduino M0/Zero detected\n");
	#endif
	#ifdef ARDUINO_AVR_FEATHER32U4 
		PRINT_CSTSTR("%s","Adafruit Feather32U4 detected\n"); 
	#endif
	#ifdef	ARDUINO_SAMD_FEATHER_M0
		PRINT_CSTSTR("%s","Adafruit FeatherM0 detected\n");
	#endif

	// See http://www.nongnu.org/avr-libc/user-manual/using_tools.html
	#ifdef __AVR_ATmega328P__
		PRINT_CSTSTR("%s","ATmega328P detected\n");
	#endif 
	#ifdef __AVR_ATmega32U4__
		PRINT_CSTSTR("%s","ATmega32U4 detected\n");
	#endif 
	#ifdef __AVR_ATmega2560__
		PRINT_CSTSTR("%s","ATmega2560 detected\n");
	#endif 
	#ifdef __SAMD21G18A__ 
		PRINT_CSTSTR("%s","SAMD21G18A ARM Cortex-M0+ detected\n");
	#endif
	#ifdef __SAM3X8E__ 
		PRINT_CSTSTR("%s","SAM3X8E ARM Cortex-M3 detected\n");
	#endif

	// Power ON the module
	sx1272.ON();
	
	// Set transmission mode and print the result
	e = sx1272.setMode(loraMode);
	PRINT_CSTSTR("%s","Setting Mode: state ");
	PRINT_VALUE("%d", e);
	PRINTLN;

	// enable carrier sense
	sx1272._enableCarrierSense=true;
		
	// Select frequency channel
	e = sx1272.setChannel(DEFAULT_CHANNEL);
	PRINT_CSTSTR("%s","Setting Channel: state ");
	PRINT_VALUE("%d", e);
	PRINTLN;
	
	// Select amplifier line; PABOOST or RFO
#ifdef PABOOST
	sx1272._needPABOOST=true;
	// previous way for setting output power
	// powerLevel='x';
#else
	// previous way for setting output power
	// powerLevel='M';	
#endif

	// previous way for setting output power
	// e = sx1272.setPower(powerLevel); 

	e = sx1272.setPowerDBM((uint8_t)MAX_DBM); 
	PRINT_CSTSTR("%s","Setting Power: state ");
	PRINT_VALUE("%d", e);
	PRINTLN;
	
	// Set the node address and print the result
	e = sx1272.setNodeAddress(node_addr);
	PRINT_CSTSTR("%s","Setting node addr: state ");
	PRINT_VALUE("%d", e);
	PRINTLN;
	
	// Print a success message
	PRINT_CSTSTR("%s","SX1272 successfully configured\n");

	delay(500);
}

void loop(void){
	uint8_t r_size;
	int e;

	sx1272.CarrierSense();
	sx1272.setPacketType(PKT_TYPE_DATA);

	while (1) {
		r_size=sprintf((char*)message, "Ping");
		PRINT_CSTSTR("%s","Sending Ping");	
		PRINTLN;
		
		//e = sx1272.sendPacketTimeoutACK(DEFAULT_DEST_ADDR, message, r_size);
		e = sx1272.sendPacketTimeout(DEFAULT_DEST_ADDR, message, r_size); //without ack
					
		PRINT_CSTSTR("%s","Packet sent, state ");
		PRINT_VALUE("%d", e);
		PRINTLN;
		
		if (e==3)
				PRINT_CSTSTR("%s","No Pong from gw!");
		if (e==0) {
				PRINT_CSTSTR("%s","Pong received from gateway!");
				PRINTLN;				
				sprintf((char*)message,"SNR at gw=%d	 ", sx1272._rcv_snr_in_ack);
				PRINT_STR("%s", (char*)message); 
				PRINTLN;
				
				sx1272.getSNR();
				sx1272.getRSSIpacket();
				sprintf((char*)message,"From gw=%d,%d", sx1272._SNR, sx1272._RSSIpacket);
				PRINT_STR("%s", (char*)message);
				PRINTLN;
		}
		PRINTLN;
		delay(10000);
	}
}

/*
 * basic.cpp
 *
 *  Created on: 13 sept. 2019
 *      Author: meghdp01
 */


#include "mbed.h"
#include "../SX1276Lib/registers/sx1276Regs-LoRa.h"
#include "../SX1276Lib/sx1276/sx1276-inAir.h"

Serial      pc(USBTX, USBRX);   //Use default TX and RX. Available via USB Com port when using PGM-NUCLEO programmer
//DigitalOut led(LED1);

int main()
{

	pc.printf("bah bah, man injam\r\n");
}



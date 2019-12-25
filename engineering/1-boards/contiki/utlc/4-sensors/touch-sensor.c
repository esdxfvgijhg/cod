/*
 * Copyright (c) 2012, Texas Instruments Incorporated - http://www.ti.com/
 * Copyright (c) 2015, Zolertia - http://www.zolertia.com
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */
/*---------------------------------------------------------------------------*/
/**
 * \addtogroup zoul
 * @{
 *
 * \defgroup zoul-examples Zoul examples
 * @{
 *
 * \defgroup zoul-demo Zoul demo application
 *
 *   Example project demonstrating the Zoul module on the RE-Mote and Firefly
 *   platforms.
 *
 * - Boot sequence: LEDs flashing (Red, then yellow, finally green)
 *
 * - etimer/clock : Every LOOP_INTERVAL clock ticks (LOOP_PERIOD secs) the LED
 *                  defined as LEDS_PERIODIC will turn on
 * - rtimer       : Exactly LEDS_OFF_HYSTERISIS rtimer ticks later,
 *                  LEDS_PERIODIC will turn back off
 * - ADC sensors  : On-chip VDD / 3, temperature, and Phidget sensor
 *                  values are printed over UART periodically.
 * - UART         : Every LOOP_INTERVAL the Remote will print something over
 *                  the UART. Receiving an entire line of text over UART (ending
 *                  in \\r) will cause LEDS_SERIAL_IN to toggle
 * - Radio comms  : BTN_USER sends a rime broadcast. Reception of a rime
 *                  packet will toggle LEDs defined as LEDS_RF_RX
 * - Button       : Keeping the button pressed will print a counter that
 *                  increments every BUTTON_PRESS_EVENT_INTERVAL ticks
 *
 * @{
 *
 * \file
 *     Example demonstrating the Zoul module on the RE-Mote & Firefly platforms
 * 
 * * -----------------------------------------------------------------
 * 
 * Touch sensor developement for IoT-UTLC project by Jérémy Petit
 * jeremy.petit2@outlook.fr
 * and ECE Paris students
 *
 */
/*---------------------------------------------------------------------------*/
#include "contiki.h"
#include "lib/random.h"
#include "cpu.h"
#include "sys/etimer.h"
#include "sys/rtimer.h"
#include "dev/leds.h"
#include "dev/button-sensor.h"
#include "dev/adc-zoul.h"
#include "dev/zoul-sensors.h"
#include "net/ip/uip.h"
#include "net/ipv6/uip-ds6.h"
#include "net/ip/uip-udp-packet.h"
#include "../example.h"

#include <stdio.h>
#include <stdint.h>
#include <string.h>

#define DEBUG 1
#if DEBUG
#include <stdio.h>
#define PRINTF(...) printf(__VA_ARGS__)
#define PRINT6ADDR(addr) PRINTF("[%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x]", ((uint8_t *)addr)[0], ((uint8_t *)addr)[1], ((uint8_t *)addr)[2], ((uint8_t *)addr)[3], ((uint8_t *)addr)[4], ((uint8_t *)addr)[5], ((uint8_t *)addr)[6], ((uint8_t *)addr)[7], ((uint8_t *)addr)[8], ((uint8_t *)addr)[9], ((uint8_t *)addr)[10], ((uint8_t *)addr)[11], ((uint8_t *)addr)[12], ((uint8_t *)addr)[13], ((uint8_t *)addr)[14], ((uint8_t *)addr)[15])
#define PRINTLLADDR(lladdr) PRINTF("[%02x:%02x:%02x:%02x:%02x:%02x]", (lladdr)->addr[0], (lladdr)->addr[1], (lladdr)->addr[2], (lladdr)->addr[3], (lladdr)->addr[4], (lladdr)->addr[5])
#else
#define PRINTF(...)
#define PRINT6ADDR(addr)
#define PRINTLLADDR(addr)
#endif
/*---------------------------------------------------------------------------*/
#define LOOP_PERIOD 1
#define LOOP_INTERVAL (CLOCK_SECOND * LOOP_PERIOD)

#define BUTTON_PRESS_EVENT_INTERVAL (CLOCK_SECOND)
int emergency_state = 0;
/*---------------------------------------------------------------------------*/
/* Timer */
static struct etimer et;
static struct etimer tim;
/*---------------------------------------------------------------------------*/
/* The structure used in the Simple UDP library to create an UDP connection */
static struct uip_udp_conn *client_conn;

/* This is the server IPv6 address */
static uip_ipaddr_t server_ipaddr;

/* Keeps account of the number of messages sent */
static uint16_t counter = 0;
/*---------------------------------------------------------------------------*/
/* Create a structure and pointer to store the data to be sent as payload */
static struct my_msg_t msg;
static struct my_msg_t *msgPtr = &msg;
/*---------------------------------------------------------------------------*/
PROCESS(touch_sensor_process, "Touch Sensor process");
AUTOSTART_PROCESSES(&touch_sensor_process);
/*---------------------------------------------------------------------------*/
static void
send_packet_sensor(void)
{
  uint16_t aux;
  counter++;

  msg.id = 0x6; /* Set traffic light/sensor ID */
  msg.counter = counter;
  msg.value1 = 2; /* Set traffic light state */
  msg.value2 = 2; /* Set QoS */
  msg.value3 = 0; /* Set Confirmation */

  aux = vdd3_sensor.value(CC2538_SENSORS_VALUE_TYPE_CONVERTED);
  msg.battery = (uint16_t)aux;

  /* Print the sensor data */
  printf("ID: %u, Value: %d,QoS: %d, batt: %u, counter: %u\n",
         msg.id, msg.value1, msg.value2, msg.battery, msg.counter);

  /* Convert to network byte order as expected by the UDP Server application */
  msg.counter = UIP_HTONS(msg.counter);
  msg.value1 = UIP_HTONS(msg.value1);
  msg.value2 = UIP_HTONS(msg.value2);
  msg.value3 = UIP_HTONS(msg.value3);
  msg.battery = UIP_HTONS(msg.battery);

  PRINTF("Send readings to %u'\n",
         server_ipaddr.u8[sizeof(server_ipaddr.u8) - 1]);

  uip_udp_packet_sendto(client_conn, msgPtr, sizeof(msg),
                        &server_ipaddr, UIP_HTONS(UDP_SERVER_PORT));
}

/*---------------------------------------------------------------------------*/

PROCESS_THREAD(touch_sensor_process, ev, data)
{

  PROCESS_BEGIN();

  /* Disable the radio duty cycle and keep the radio on */
  NETSTACK_MAC.off(1);

  /* Set the server address here */
  uip_ip6addr(&server_ipaddr, 0xaaaa, 0, 0, 0, 0, 0, 0, 1);

  printf("Server address: ");
  PRINT6ADDR(&server_ipaddr);
  printf("\n");

  /* Configure the ADC ports */
  adc_zoul.configure(SENSORS_HW_INIT, ZOUL_SENSORS_ADC_ALL);

  printf("Touch Sensor application\n");

  client_conn = udp_new(NULL, UIP_HTONS(UDP_SERVER_PORT), NULL);

  if (client_conn == NULL)
  {
    PRINTF("No UDP connection available, exiting the process!\n");
    PROCESS_EXIT();
  }

  /* This function binds a UDP connection to a specified local port */
  udp_bind(client_conn, UIP_HTONS(UDP_CLIENT_PORT));

  PRINTF("Created a connection with the server ");
  PRINT6ADDR(&client_conn->ripaddr);
  PRINTF(" local/remote port %u/%u\n", UIP_HTONS(client_conn->lport),
         UIP_HTONS(client_conn->rport));

  etimer_set(&et, LOOP_INTERVAL);

  while (1)
  {

    PROCESS_YIELD();
    /* Every second */
    if (ev == PROCESS_EVENT_TIMER)
    {
      /* For quick debugging*/
      printf("Value: %u\n", adc_zoul.value(ZOUL_SENSORS_ADC1));
      /* If a touch is detected */
      if (adc_zoul.value(ZOUL_SENSORS_ADC1) > 20000)
      {
        /* We turn on the red light and send an udp message to ubidots */
        leds_off(LEDS_ALL);
        leds_on(LEDS_RED);
        printf("Sending message\n");
        /*Sending message through udp to server */
        send_packet_sensor();

        /* Put a hold to avoid repetitive pushing */
        // Pause for 10 seconds
        leds_off(LEDS_ALL);
        leds_on(LEDS_BLUE);
        
        printf("Pause\n");

        etimer_set(&tim, 10 * CLOCK_SECOND);
        PROCESS_WAIT_EVENT_UNTIL(etimer_expired(&tim));
      }
      /*If nothing happen*/
      else
      {
        /* We turn the blue led on */
        leds_off(LEDS_ALL);
        leds_on(LEDS_BLUE);
      }
    }

    etimer_set(&et, LOOP_INTERVAL);
  }

  PROCESS_END();
}
/*---------------------------------------------------------------------------*/
/**
 * @}
 * @}
 * @}
 */

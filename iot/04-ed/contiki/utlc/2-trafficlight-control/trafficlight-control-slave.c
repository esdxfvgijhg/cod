/*
 * Copyright (c) 2016, Zolertia - http://www.zolertia.com
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
 * 3. Neither the name of the Institute nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE INSTITUTE AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE INSTITUTE OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 * This file is part of the Contiki operating system.
 *
 */
/*---------------------------------------------------------------------------*/
#include "contiki.h"
#include "lib/random.h"
#include "net/ip/uip.h"
#include "net/ipv6/uip-ds6.h"
#include "net/ip/uip-udp-packet.h"
#include "sys/ctimer.h"
#include "sys/timer.h"
#include "../example.h"
#include <stdio.h>
#include <string.h>

#if CONTIKI_TARGET_ZOUL
#include "dev/adc-zoul.h"
#include "dev/zoul-sensors.h"
#else /* Default is Z1 */
#include "dev/adxl345.h"
#include "dev/battery-sensor.h"
#include "dev/i2cmaster.h"
#include "dev/tmp102.h"
#endif

#include "dev/leds.h"
#include "dev/button-sensor.h"
/*---------------------------------------------------------------------------*/
/* Enables printing debug output from the IP/IPv6 libraries */
#define DEBUG DEBUG_PRINT
#include "net/ip/uip-debug.h"
/*---------------------------------------------------------------------------*/
/* Default is to send a packet every 60 seconds */
#define SEND_INTERVAL (60 * CLOCK_SECOND)
/*---------------------------------------------------------------------------*/
/* Variable used to send only once with user button*/
int i = 0;
/*---------------------------------------------------------------------------*/
/* The structure used in the Simple UDP library to create an UDP connection */
static struct uip_udp_conn *client_conn;

/* This is the server IPv6 address */
static uip_ipaddr_t server_ipaddr;

/* Keeps account of the number of messages sent */
static uint16_t counter = 0;

/* Keeps account of the number of false messages received */
static uint16_t wrong_data_ctr = 0;

/* Keep global track of trafficlight state */
static uint16_t my_state;

/* Flag to reset Re-mote etimer */
static int RESET = 0;
/* Flag to pause Re-mote etimer */
static int PAUSE = 0;

static int TT = 0;

static struct etimer periodic;

static struct etimer tim;
/*---------------------------------------------------------------------------*/
/* Create a structure and pointer to store the data to be sent as payload */
static struct my_msg_t msg;
static struct my_msg_t *msgPtr = &msg;

typedef struct
{
  int data;
  int qos;
  int option;
} MSG_RCV;

/* Create a structure to store the data received */
static MSG_RCV *rcv;

struct latency_structure{ // Structure to save the time when the message was send
 
   rtimer_clock_t timestamp;// Time when the message was send
 
};

struct latency_structure *msg_lat;
/*---------------------------------------------------------------------------*/
PROCESS(udp_client_process, "Trafficlight control process");
AUTOSTART_PROCESSES(&udp_client_process);

/*---------------------------------------------------------------------------*/
static void
state_trafficlight(int value)
{
  if (value > 2)
    printf("Err value: %u", value);
  switch (value)
  {
  case 0:
    leds_off(LEDS_ALL);
    leds_on(LEDS_RED);
    break;
  case 1:
    leds_off(LEDS_ALL);
    leds_on(LEDS_BLUE);
    break;
  case 2:
    leds_off(LEDS_ALL);
    leds_on(LEDS_GREEN);
    break;
  default:
    leds_off(LEDS_ALL);
    leds_on(LEDS_PURPLE);
    break;
  }
}

/*---------------------------------------------------------------------------*/
/* Whenever we receive a packet from another node (or the server), this callback
 * is invoked.  We use the "uip_newdata()" to check if there is data for
 * us
 */
static void
tcpip_handler(void)
{
  char *str;
  rcv = malloc(sizeof(MSG_RCV));
  if (uip_newdata())
  {
    /* Get the buffer pointer */
    rcv = uip_appdata;
    printf("Test des valeurs : data:%u qos:%u option:%u\n", rcv->data, rcv->qos, rcv->option);

    if (my_state != rcv->data) /* New state */
    {
      printf("New value %u != %u \n", my_state, rcv->data);

      if (rcv->data == 0)
      {
        state_trafficlight(1);
        printf("Switch to yellow \n");
      }
      printf("Data given: %u \n", rcv->data);
      PAUSE = 1;
      my_state = rcv->data;

    }
    else
    {
      printf("%u == %u \n", my_state, rcv->data);
    }
    if (rcv->option) {
        // Send confirmation of the new state
        msg.id = 0x3;
        msg.counter = counter;
        msg.value1 = my_state;
        msg.value2 = 1; /* Set QoS */
        msg.value3 = 1; /* Set Confirmation */

        /* Convert to network byte order as expected by the UDP Server application */
        uint16_t tmpval = msg.value1;
        msg.counter = UIP_HTONS(msg.counter);
        msg.value1 = UIP_HTONS(msg.value1);
        msg.value2 = UIP_HTONS(msg.value2);
        msg.value3 = UIP_HTONS(msg.value3);

        PRINTF("Send readings to %u'\n",
              server_ipaddr.u8[sizeof(server_ipaddr.u8) - 1]);

        uip_udp_packet_sendto(client_conn, msgPtr, sizeof(msg),
                              &server_ipaddr, UIP_HTONS(UDP_SERVER_PORT));

        msg.value1 = tmpval;

    }
    if (rcv->data > 2000 && rcv->qos > 200 && rcv->option > 200)
    { //Buffer overflow detected
      wrong_data_ctr++;
      printf("Wwong data, possible overflow\n");
      if (wrong_data_ctr > 10)
        sys_ctrl_reset();
    }
  }
}

/*---------------------------------------------------------------------------*/
static void
send_packet_event(void)
{
  uint16_t aux;
  counter++;

  msg.id = 0x3; /* Set traffic light/sensor ID */
  msg.counter = counter;
  // if (my_state == 0)  /* Set traffic light state */
  //   msg.value1 = 2;
  // else
  //   msg.value1 = 0;
  msg.value1 = 42;
  msg.value2 = 0; /* Set QoS */
  msg.value3 = 0; /* Set Confirmation */

  aux = vdd3_sensor.value(CC2538_SENSORS_VALUE_TYPE_CONVERTED);
  msg.battery = (uint16_t)aux;
  // msg.confirmation = 0x0;

  /* Print the sensor data */
  printf("ID: %u, Counter : %u, Value: %d, QoS: %d, Conf: %d, batt: %u\n",
         msg.id, msg.counter, msg.value1, msg.value2, msg.value3, msg.battery);

  /* Convert to network byte order as expected by the UDP Server application */
  uint16_t tmpval = msg.value1;
  msg.counter = UIP_HTONS(msg.counter);
  msg.value1 = UIP_HTONS(msg.value1);
  msg.value2 = UIP_HTONS(msg.value2);
  msg.value3 = UIP_HTONS(msg.value3);
  msg.battery = UIP_HTONS(msg.battery);

  PRINTF("Send readings to %u'\n",
         server_ipaddr.u8[sizeof(server_ipaddr.u8) - 1]);

  uip_udp_packet_sendto(client_conn, msgPtr, sizeof(msg),
                        &server_ipaddr, UIP_HTONS(UDP_SERVER_PORT));

  /* Trick for the model purpose */
  msg.value1 = tmpval;
}
/*---------------------------------------------------------------------------*/
static void
send_packet_sensor(void)
{
  uint16_t aux;
  counter++;

  msg.id = 0x3; /* Set traffic light/sensor ID */
  msg.counter = counter;
  // if (my_state == 0)  /* Set traffic light state */
  //   msg.value1 = 2;
  // else
  //   msg.value1 = 0;
  msg.value1 = 42;
  msg.value2 = 1; /* Set QoS */
  msg.value3 = 1; /* Set Confirmation */

  aux = vdd3_sensor.value(CC2538_SENSORS_VALUE_TYPE_CONVERTED);
  msg.battery = (uint16_t)aux;
  // msg.confirmation = 0x0;

  /* Print the sensor data */
  printf("ID: %u, Counter : %u, Value: %d, QoS: %d, Conf: %d, batt: %u\n",
         msg.id, msg.counter, msg.value1, msg.value2, msg.value3, msg.battery);

  /* Convert to network byte order as expected by the UDP Server application */
  uint16_t tmpval = msg.value1;
  msg.counter = UIP_HTONS(msg.counter);
  msg.value1 = UIP_HTONS(msg.value1);
  msg.value2 = UIP_HTONS(msg.value2);
  msg.value3 = UIP_HTONS(msg.value3);
  msg.battery = UIP_HTONS(msg.battery);

  PRINTF("Send readings to %u'\n",
         server_ipaddr.u8[sizeof(server_ipaddr.u8) - 1]);

  uip_udp_packet_sendto(client_conn, msgPtr, sizeof(msg),
                        &server_ipaddr, UIP_HTONS(UDP_SERVER_PORT));

  /* Trick for the model purpose */
  msg.value1 = tmpval;
}
/*---------------------------------------------------------------------------*/
static void
print_local_addresses(void)
{
  int i;
  uint8_t state;

  PRINTF("Client IPv6 addresses:\n");
  for (i = 0; i < UIP_DS6_ADDR_NB; i++)
  {
    state = uip_ds6_if.addr_list[i].state;
    if (uip_ds6_if.addr_list[i].isused &&
        (state == ADDR_TENTATIVE || state == ADDR_PREFERRED))
    {
      PRINT6ADDR(&uip_ds6_if.addr_list[i].ipaddr);
      PRINTF("\n");
      /* hack to make address "final" */
      if (state == ADDR_TENTATIVE)
      {
        uip_ds6_if.addr_list[i].state = ADDR_PREFERRED;
      }
    }
  }
}
/*---------------------------------------------------------------------------*/
/* This is a hack to set ourselves the global address, use for testing */
static void
set_global_address(void)
{
  uip_ipaddr_t ipaddr;

  /* The choice of server address determines its 6LoWPAN header compression.
 * (Our address will be compressed Mode 3 since it is derived from our link-local address)
 * Obviously the choice made here must also be selected in udp-server.c.
 *
 * For correct Wireshark decoding using a sniffer, add the /64 prefix to the 6LowPAN protocol preferences,
 * e.g. set Context 0 to fd00::.  At present Wireshark copies Context/128 and then overwrites it.
 * (Setting Context 0 to fd00::1111:2222:3333:4444 will report a 16 bit compressed address of fd00::1111:22ff:fe33:xxxx)
 *
 * Note the IPCMV6 checksum verification depends on the correct uncompressed addresses.
 */

  /* Replace '0xaaaa' by 'fd00' if local */
  uip_ip6addr(&ipaddr, 0xaaaa, 0, 0, 0, 0, 0, 0, 1);
  uip_ds6_set_addr_iid(&ipaddr, &uip_lladdr);
  uip_ds6_addr_add(&ipaddr, 0, ADDR_AUTOCONF);
}
/*---------------------------------------------------------------------------*/
PROCESS_THREAD(udp_client_process, ev, data)
{

  PROCESS_BEGIN();

  PROCESS_PAUSE();

  /* Remove the comment to set the global address ourselves, as it is it will
   * obtain the IPv6 prefix from the DODAG root and create its IPv6 global
   * address
   */
  //set_global_address();

  printf("UDP client process started\n");

  /* Set the server address here */
  uip_ip6addr(&server_ipaddr, 0xaaaa, 0, 0, 0, 0, 0, 0, 1);

  printf("Server address: ");
  PRINT6ADDR(&server_ipaddr);
  printf("\n");

  /* Print the node's addresses */
  print_local_addresses();

  /* Activate the sensors */
#if CONTIKI_TARGET_ZOUL
  adc_zoul.configure(SENSORS_HW_INIT, ZOUL_SENSORS_ADC_ALL);
#else /* Default is Z1 */
  SENSORS_ACTIVATE(adxl345);
  SENSORS_ACTIVATE(tmp102);
  SENSORS_ACTIVATE(battery_sensor);
#endif

  SENSORS_ACTIVATE(button_sensor);
  leds_on(LEDS_GREEN); //Traffic lights 2 & 4 start at green, 1 & 3 at red
  my_state = 2;

  /* Create a new connection with remote host.  When a connection is created
   * with udp_new(), it gets a local port number assigned automatically.
   * The "UIP_HTONS()" macro converts to network byte order.
   * The IP address of the remote host and the pointer to the data are not used
   * so those are set to NULL
   */
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

  //etimer_set(&periodic, SEND_INTERVAL);

  while (1)
  {
    PROCESS_YIELD();

    /* Incoming events from the TCP/IP module */
    if (ev == tcpip_event)
    {
      tcpip_handler();
    }
    i = i + 1;

    if (PAUSE)
    {
      printf("Pause\n");
      etimer_set(&tim, 3 * CLOCK_SECOND);
      PROCESS_WAIT_EVENT_UNTIL(etimer_expired(&tim));
      PAUSE = 0;
      TT = 1;
      state_trafficlight(my_state);
    }
    /* Send data to the server */
    /* QoS 0: Non-priority data sent every minutes with 30s shift for data sent to server every 30s */
    if (ev == PROCESS_EVENT_TIMER)
    {
      if(PAUSE==1 || TT == 1){
        PAUSE=0;
        TT=0;
      }
    }

    /* QoS 2: Priority data when pressing the user button */
    if (ev == sensors_event && data == &button_sensor)
    {
      if (i % 2 == 0)
      {
        send_packet_sensor();
      }
    }
  }

  PROCESS_END();
}
/*---------------------------------------------------------------------------*/

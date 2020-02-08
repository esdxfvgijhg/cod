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
#include "example.h"

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
send_packet_sensor(void){
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
	printf("ID: %u, Value: %d,QoS: %d, batt: %u, counter: %u\n", msg.id, msg.value1, msg.value2, msg.battery, msg.counter);

	/* Convert to network byte order as expected by the UDP Server application */
	msg.counter = UIP_HTONS(msg.counter);
	msg.value1 = UIP_HTONS(msg.value1);
	msg.value2 = UIP_HTONS(msg.value2);
	msg.value3 = UIP_HTONS(msg.value3);
	msg.battery = UIP_HTONS(msg.battery);

	PRINTF("Send readings to %u'\n", server_ipaddr.u8[sizeof(server_ipaddr.u8) - 1]);
	uip_udp_packet_sendto(client_conn, msgPtr, sizeof(msg), &server_ipaddr, UIP_HTONS(UDP_SERVER_PORT));
}

/*---------------------------------------------------------------------------*/

PROCESS_THREAD(touch_sensor_process, ev, data){

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

	if (client_conn == NULL){
		PRINTF("No UDP connection available, exiting the process!\n");
		PROCESS_EXIT();
	}

	/* This function binds a UDP connection to a specified local port */
	udp_bind(client_conn, UIP_HTONS(UDP_CLIENT_PORT));
	PRINTF("Created a connection with the server ");
	PRINT6ADDR(&client_conn->ripaddr);
	PRINTF(" local/remote port %u/%u\n", UIP_HTONS(client_conn->lport), UIP_HTONS(client_conn->rport));
	etimer_set(&et, LOOP_INTERVAL);

	while (1){
		PROCESS_YIELD();
		/* Every second */
		if (ev == PROCESS_EVENT_TIMER){
			/* For quick debugging*/
			printf("Value: %u\n", adc_zoul.value(ZOUL_SENSORS_ADC1));
			/* If a touch is detected */
			if (adc_zoul.value(ZOUL_SENSORS_ADC1) > 20000){
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
			else{
				/* We turn the blue led on */
				leds_off(LEDS_ALL);
				leds_on(LEDS_BLUE);
			}
		}

		etimer_set(&et, LOOP_INTERVAL);
	}

	PROCESS_END();
}


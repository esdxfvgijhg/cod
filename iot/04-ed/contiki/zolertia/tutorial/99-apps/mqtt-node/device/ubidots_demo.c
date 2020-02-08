/*
 * Copyright (c) 2016, Antonio Lignan - antonio.lignan@gmail.com
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
#include "sys/etimer.h"
#include "dev/adc-zoul.h"
#include "dev/dht22.h"
#include "dev/tsl256x.h"
#include "dev/relay.h"
#include "ubidots_demo.h"
#include "mqtt-res.h"

#include <stdio.h>
#include <string.h>
#include <strings.h>
#include <stdlib.h>
/*---------------------------------------------------------------------------*/
#if DEBUG_APP
#define PRINTF(...) printf(__VA_ARGS__)
#else
#define PRINTF(...)
#endif
/*---------------------------------------------------------------------------*/
sensor_values_t ubidots_demo_sensors;
command_values_t ubidots_demo_commands;
/*---------------------------------------------------------------------------*/
process_event_t ubidots_demo_sensors_data_event;
process_event_t ubidots_demo_sensors_alarm_event;
/*---------------------------------------------------------------------------*/
static uint8_t detect_sensor = 0;
/*---------------------------------------------------------------------------*/
PROCESS(ubidots_demo_sensors_process, "Ubidots sensor process");
/*---------------------------------------------------------------------------*/
static int
activate_actuator(int arg)
{
  if(!arg) {
    relay.value(RELAY_ON);
  } else {
    relay.value(RELAY_OFF);
  }
  process_poll(&ubidots_demo_sensors_process);
  return 0;
}
/*---------------------------------------------------------------------------*/
static void
poll_sensors(void)
{
  ubidots_demo_sensors.sensor[ANALOG_SENSOR_SOIL_MOIST].value = adc_zoul.value(ZOUL_SENSORS_ADC3);
  if(!detect_sensor) {
    if(!tsl256x.configure(TSL256X_ACTIVE, 1)) {
      ubidots_demo_sensors.sensor[DIGITAL_SENSOR_LIGHT].value = tsl256x.value(TSL256X_VAL_READ);
    } else {
      ubidots_demo_sensors.sensor[DIGITAL_SENSOR_LIGHT].value = DEFAULT_WRONG_VALUE;
      detect_sensor = 1;
    }
  } else {
    dht22.configure(SENSORS_ACTIVE, 1);
    int temperature, humidity;
    dht22_read_all(&temperature, &humidity);
    ubidots_demo_sensors.sensor[DIGITAL_SENSOR_TEMP].value = temperature;
    ubidots_demo_sensors.sensor[DIGITAL_SENSOR_HUMD].value = humidity;
  }

  mqtt_sensor_check(&ubidots_demo_sensors, ubidots_demo_sensors_alarm_event,
                    ubidots_demo_sensors_data_event);
}
/*---------------------------------------------------------------------------*/
PROCESS_THREAD(ubidots_demo_sensors_process, ev, data)
{
  static struct etimer et;

  /* This is where our process start */
  PROCESS_BEGIN();

  /* Load sensor defaults */
  ubidots_demo_sensors.num = 0;

  /* Configure the ADC ports */
  adc_zoul.configure(SENSORS_HW_INIT, ZOUL_SENSORS_ADC3);

  /* Register digital sensors */
  mqtt_sensor_register(&ubidots_demo_sensors, ANALOG_SENSOR_SOIL_MOIST,
                       DEFAULT_WRONG_VALUE, DEFAULT_PUBLISH_EVENT_SOIL_MOIST,
                       NULL, DEFAULT_SUBSCRIBE_CFG_MOISTTHR, DEFAULT_CC2538_SOIL_MOIST_MIN,
                       DEFAULT_CC2538_SOIL_MOIST_MAX, DEFAULT_SOIL_MOIST_THRESH,
                       DEFAULT_SOIL_MOIST_THRESL, 100);

  mqtt_sensor_register(&ubidots_demo_sensors, DIGITAL_SENSOR_TEMP,
                       DEFAULT_WRONG_VALUE, DEFAULT_PUBLISH_EVENT_TEMP,
                       NULL, DEFAULT_SUBSCRIBE_CFG_TEMPTHR,
                       DEFAULT_DHT22_TEMP_MIN, DEFAULT_DHT22_TEMP_MAX,
                       DEFAULT_DHT22_TEMP_THRESH, DEFAULT_DHT22_TEMP_THRESL, 10);

  mqtt_sensor_register(&ubidots_demo_sensors, DIGITAL_SENSOR_HUMD,
                       DEFAULT_WRONG_VALUE, DEFAULT_PUBLISH_EVENT_HUMD,
                       NULL, DEFAULT_SUBSCRIBE_CFG_HUMDTHR,
                       DEFAULT_DHT22_HUMD_MIN, DEFAULT_DHT22_HUMD_MAX,
                       DEFAULT_DHT22_HUMD_THRESH, DEFAULT_DHT22_HUMD_THRESL, 10);

  mqtt_sensor_register(&ubidots_demo_sensors, DIGITAL_SENSOR_LIGHT,
                       DEFAULT_WRONG_VALUE, DEFAULT_PUBLISH_EVENT_LIGHT,
                       NULL, DEFAULT_SUBSCRIBE_CFG_LIGHTHR,
                       DEFAULT_TSL2561_LIGHT_MIN, DEFAULT_TSL2561_LIGHT_MAX,
                       DEFAULT_TSL2561_LIGHT_THRESH, DEFAULT_TSL2561_LIGHT_THRESL, 0);

  /* Sanity check */
  if(ubidots_demo_sensors.num != DEFAULT_SENSORS_NUM) {
    printf("Ubidots sensors: error! number of sensors mismatch\n");
    PROCESS_EXIT();
  }

  /* Load commands default */
  ubidots_demo_commands.num = 1;
  memcpy(ubidots_demo_commands.command[UBIDOTS_DEMO_COMMAND].command_name,
         DEFAULT_COMMAND_EVENT_RELAY, strlen(DEFAULT_COMMAND_EVENT_RELAY));
  ubidots_demo_commands.command[UBIDOTS_DEMO_COMMAND].cmd = activate_actuator;

  if(ubidots_demo_commands.num != DEFAULT_COMMANDS_NUM) {
    printf("Ubidots sensors: error! number of commands mismatch\n");
    PROCESS_EXIT();
  }

  /* Get an event ID for our events */
  ubidots_demo_sensors_data_event = process_alloc_event();
  ubidots_demo_sensors_alarm_event = process_alloc_event();

  /* Activate Relay for GPIO activation */
  SENSORS_ACTIVATE(relay);
  activate_actuator(0);

  /* Start the periodic process */
  etimer_set(&et, DEFAULT_SAMPLING_INTERVAL);

  while(1) {

    PROCESS_YIELD();

    if(ev == PROCESS_EVENT_TIMER && data == &et) {
      poll_sensors();
      etimer_reset(&et);
    } else if(ev == sensors_stop_event) {
      PRINTF("Ubidots: sensor readings paused\n");
      etimer_stop(&et);
    } else if(ev == sensors_restart_event) {
      PRINTF("Ubidots: sensor readings enabled\n");
      etimer_reset(&et);
    }
  }

  PROCESS_END();
}
/*---------------------------------------------------------------------------*/
/** @} */

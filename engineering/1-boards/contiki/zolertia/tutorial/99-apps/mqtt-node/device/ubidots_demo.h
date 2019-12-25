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
 */
/*---------------------------------------------------------------------------*/
#ifndef UBIDOTS_DEMO_H_
#define UBIDOTS_DEMO_H_
/*---------------------------------------------------------------------------*/
#include "mqtt-sensors.h"
/*---------------------------------------------------------------------------*/
enum {
  ANALOG_SENSOR_SOIL_MOIST = 0,
  DIGITAL_SENSOR_TEMP,
  DIGITAL_SENSOR_HUMD,
  DIGITAL_SENSOR_LIGHT,
};
enum {
	UBIDOTS_DEMO_COMMAND = 0,
};
/*---------------------------------------------------------------------------*/
/* Sensor process events */
extern process_event_t ubidots_demo_sensors_data_event;
extern process_event_t ubidots_demo_sensors_alarm_event;
/*---------------------------------------------------------------------------*/
extern sensor_values_t ubidots_demo_sensors;
/*---------------------------------------------------------------------------*/
extern command_values_t ubidots_demo_commands;
/*---------------------------------------------------------------------------*/
/* PUBLISH strings */
#define DEFAULT_PUBLISH_EVENT_SOIL_MOIST      "soil_moisture"
#define DEFAULT_PUBLISH_ALARM_SOIL_MOIST      "alarm_soil_moisture"
#define DEFAULT_PUBLISH_EVENT_TEMP            "temperature"
#define DEFAULT_PUBLISH_ALARM_TEMP            "alarm_emperature"
#define DEFAULT_PUBLISH_EVENT_HUMD            "humidity"
#define DEFAULT_PUBLISH_ALARM_HUMD            "alarm_humidity"
#define DEFAULT_PUBLISH_EVENT_LIGHT           "light"
#define DEFAULT_PUBLISH_ALARM_LIGHT           "alarm_light"

/* SUBSCRIBE strings */
#define DEFAULT_SUBSCRIBE_CFG_MOISTTHR        "moisture_thresh"
#define DEFAULT_SUBSCRIBE_CFG_TEMPTHR         "temperature_thresh"
#define DEFAULT_SUBSCRIBE_CFG_HUMDTHR         "humidity_thresh"
#define DEFAULT_SUBSCRIBE_CFG_LIGHTHR         "light_thresh"

/* Minimum and maximum values for the sensors */
#define DEFAULT_CC2538_SOIL_MOIST_MIN         0
#define DEFAULT_CC2538_SOIL_MOIST_MAX         15000

#define DEFAULT_DHT22_TEMP_MIN                (-200)
#define DEFAULT_DHT22_TEMP_MAX                1200
#define DEFAULT_DHT22_HUMD_MIN                0
#define DEFAULT_DHT22_HUMD_MAX                1000

#define DEFAULT_TSL2561_LIGHT_MIN             0
#define DEFAULT_TSL2561_LIGHT_MAX             30000

#define DEFAULT_WRONG_VALUE                   (-300)

/* Default sensor state and thresholds (not checking for alarms) */

#define DEFAULT_SOIL_MOIST_THRESH             DEFAULT_CC2538_SOIL_MOIST_MAX
#define DEFAULT_DHT22_TEMP_THRESH             DEFAULT_DHT22_TEMP_MAX
#define DEFAULT_DHT22_HUMD_THRESH             DEFAULT_DHT22_HUMD_MAX
#define DEFAULT_TSL2561_LIGHT_THRESH          DEFAULT_TSL2561_LIGHT_MAX

#define DEFAULT_SOIL_MOIST_THRESL             DEFAULT_CC2538_SOIL_MOIST_MIN
#define DEFAULT_DHT22_TEMP_THRESL             DEFAULT_DHT22_TEMP_MIN
#define DEFAULT_DHT22_HUMD_THRESL             DEFAULT_DHT22_HUMD_MIN 
#define DEFAULT_TSL2561_LIGHT_THRESL          DEFAULT_TSL2561_LIGHT_MIN

/* commando string: open and close relay*/
#define DEFAULT_COMMAND_EVENT_RELAY           "/relay_toggle/lv"
#define DEFAULT_CMD_STRING                    DEFAULT_COMMAND_EVENT_RELAY

#define DEFAULT_CONF_ALARM_TIME               80
/*---------------------------------------------------------------------------*/
#endif /* UBIDOTS_DEMO_H_ */
/** @} */


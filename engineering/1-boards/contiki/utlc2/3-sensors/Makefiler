DEFINES+=PROJECT_CONF_H=\"project-conf.h\"

CONTIKI_PROJECT = touch-sensor

CONTIKI_TARGET_SOURCEFILES += tsl256x.c sht25.c bmpx8x.c motion-sensor.c
CONTIKI_TARGET_SOURCEFILES += adc-sensors.c weather-meter.c grove-gyro.c
CONTIKI_TARGET_SOURCEFILES += rgb-bl-lcd.c pm10-sensor.c iaq.c zonik.c relay.c
CONTIKI_TARGET_SOURCEFILES += dht22.c servo.c ac-dimmer.c bme280-arch.c

MODULES += /dev/bme280

all: $(CONTIKI_PROJECT)

CONTIKI=$(shell targetos)/contiki

#CONTIKI_WITH_RIME = 1
CONTIKI_WITH_IPV6 = 1
include $(CONTIKI)/Makefile.include

CFLAGS += -DPROJECT_CONF_H=\"project-conf.h\"

CONTIKI_PROJECT = avr_radio_power
APPS+=powertrace
all: $(CONTIKI_PROJECT)

CONTIKI=$(shell targetos)/contiki
CONTIKI_WITH_RIME = 1
include $(CONTIKI)/Makefile.include

DEFINES+=PROJECT_CONF_H=\"project-conf.h\"

all: mqtt-demo

CONTIKI_WITH_IPV6 = 1
CONTIKI_WITH_RPL = 0

APPS += mqtt

CONTIKI=$(shell targetos)/contiki
include $(CONTIKI)/Makefile.include

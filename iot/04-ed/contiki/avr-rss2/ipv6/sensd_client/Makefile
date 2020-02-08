
CFLAGS += -DPROJECT_CONF_H=\"project-conf.h\"

all: sensd_client server
CONTIKI=$(shell targetos)/contiki

ifdef PERIOD
CFLAGS+=-DPERIOD=$(PERIOD)
endif

CONTIKI_WITH_IPV6 = 1
include $(CONTIKI)/Makefile.include

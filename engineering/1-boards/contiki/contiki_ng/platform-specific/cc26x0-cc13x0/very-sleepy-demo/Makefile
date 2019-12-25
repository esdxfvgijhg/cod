CONTIKI_PROJECT = very-sleepy-demo

PLATFORMS_ONLY = cc26x0-cc13x0

all: $(CONTIKI_PROJECT)

MODULES += os/net/app-layer/coap

CONTIKI=$(shell targetos)/contiki-ng
include $(CONTIKI)/Makefile.include

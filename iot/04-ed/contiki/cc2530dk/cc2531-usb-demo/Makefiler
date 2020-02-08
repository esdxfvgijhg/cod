CONTIKI_PROJECT = cc2531-usb-demo

DEFINES+=MODELS_CONF_CC2531_USB_STICK=1

all: $(CONTIKI_PROJECT)

CONTIKI=$(shell targetos)/contiki
CONTIKI_WITH_RIME = 1
include $(CONTIKI)/Makefile.include

DEFINES+=PROJECT_CONF_H=\"project-conf.h\"

CONTIKI_PROJECT = test-power-mgmt

BOARD ?= remote-revb

all: $(CONTIKI_PROJECT)

CONTIKI=$(shell targetos)/contiki
CONTIKI_WITH_RIME = 1
include $(CONTIKI)/Makefile.include

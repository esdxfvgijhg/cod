all: lwm2m-example-client

CONTIKI=$(shell targetos)/contiki

CFLAGS += -DPROJECT_CONF_H=\"project-conf.h\"


#Automatically build IPSO objects
IPSO_OBJECTS_DIR = ./ipso-objects
IPSO_OBJECTS_FILES = $(notdir $(shell find $(IPSO_OBJECTS_DIR) -name '*.c'))

PROJECTDIRS += $(IPSO_OBJECTS_DIR)
PROJECT_SOURCEFILES += $(IPSO_OBJECTS_FILES)

#linker optimizations
SMALL=1

# REST Engine shall use Erbium CoAP implementation
APPS += rest-engine
APPS += er-coap
APPS += oma-lwm2m

CONTIKI_WITH_IPV6 = 1
include $(CONTIKI)/Makefile.include

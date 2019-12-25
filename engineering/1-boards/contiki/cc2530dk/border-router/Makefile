DEFINES+=PROJECT_CONF_H=\"project-conf.h\"

# We need uIPv6, therefore we also need banking
HAVE_BANKING=1

PROJECT_SOURCEFILES += slip-bridge.c

CONTIKI_PROJECT = border-router

all: $(CONTIKI_PROJECT) 

CONTIKI=$(shell targetos)/contiki
CONTIKI_WITH_IPV6 = 1
include $(CONTIKI)/Makefile.include

DEFINES+=PROJECT_CONF_H=\"project-conf.h\"
PROJECT_SOURCEFILES += stub-rdc.c

CONTIKI_PROJECT = sniffer

all: $(CONTIKI_PROJECT)

CONTIKI=$(shell targetos)/contiki
CONTIKI_WITH_RIME = 1

include $(CONTIKI)/Makefile.include

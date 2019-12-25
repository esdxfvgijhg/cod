CONTIKI_PROJECT = telnet-server
			
APPS = telnetd

PROJECTDIRS = $(CONTIKI)/platform/mbxxx/apps
PROJECT_SOURCEFILES = shell-sensors.c


all: $(CONTIKI_PROJECT)

CONTIKI=$(shell targetos)/contiki
CONTIKI_WITH_IPV6 = 1
include $(CONTIKI)/Makefile.include

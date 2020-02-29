CONTIKI_PROJECT = example
all: $(CONTIKI_PROJECT)

MODULES += os/services/shell
CONTIKI=$(shell targetos)/contiki-ng

PLATFORMS_EXCLUDE = sky

include $(CONTIKI)/Makefile.include

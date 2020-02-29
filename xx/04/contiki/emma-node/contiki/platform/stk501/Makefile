# $$

all: contiki-stk501-main.out loadable_prg.ko
upload: contiki-stk501-main.eep contiki-stk501-main.u

CONTIKI=$(shell targetos)/contiki
TARGET=stk501
APPS=codeprop

include $(CONTIKI)/Makefile.include

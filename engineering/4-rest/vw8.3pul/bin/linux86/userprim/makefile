########################################################################
#
# Makefile for linking user primitives for i386 Linux 2.x and up
#
# Copyright (C) 1999-2016 Cincom Systems, Inc.  All rights reserved.
#
########################################################################
#
# The name of resultant VM executable
WHO=visualUser

# Name(s) of User Primitive files
USER=validate.o

# Floating point processor options
FPOPTION=

# omit optimization for debugging
COPTS=-mieee-fp -fsigned-char -g -O2
#COPTS=-mieee-fp -fsigned-char -g

TOPTION=-pthread -D_REENTRANT -D_LIBC_REENTRANT

# define -DUNSAFE here if you want to live dangerously
SAFETY=

CFLAGS=$(COPTION) $(FPOPTION) $(TOPTION) $(SAFETY)

BASEOBJS=visual.o customize.o
LIBS=-export-dynamic -L/usr/X11R6/lib -lpthread -ldl -lX11 -lm -lz

$(WHO):	$(BASEOBJS) $(USER)
	$(CC) $(CFLAGS) -o $(WHO) $(BASEOBJS) $(USER) $(LIBS)

$(USER):  userprim.h
customize.o:	userprim.h

userprim.h: up_defs.h up_unsafe.h
up_unsafe.h: unsafe_oops.h

SPLASH=splash-bits-4.h
SPLASH_INC=.

x11Splash.o: x11Splash.c $(SPLASH_INC)/$(SPLASH)
	$(CC) -c -I$(SPLASH_INC) -DSPLASH_H=\"$(SPLASH)\" -fpic x11Splash.c

herald.so: x11Splash.o
	ld -o herald.so -shared x11Splash.o

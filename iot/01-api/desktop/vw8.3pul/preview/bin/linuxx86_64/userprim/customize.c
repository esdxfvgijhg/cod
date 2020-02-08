/*
 * Modify this file if you want a different herald string or resource
 * class name (where applicable).  Any private command line options must
 * be removed before calling oeMain().
 *
 * Copyright (C) 1999-2016 Cincom Systems, Inc.  All rights reserved.
 *
 */
#include "userprim.h"

char *versionString = "VisualWorks(R) 8.3, w/user primitives";

char *resourceClassName = "St80"; /* class name used to look up X resources */

# if OE_IS_UNICODE
#	define oechar_t wchar_t
#	define oemain_func wmain
# else
#	define oechar_t char
#	define oemain_func main
# endif
int
oemain_func(int argc, oechar_t *argv[])
{
#if LOADABLE_GUI
	extern unsigned int guiSubsystemLinked;
	if (guiSubsystemLinked)
		showHerald = TRUE;
#endif
	return oeMain(argc, argv, 0);
}

/*
 * UPInitLinkRegistry
 *
 * All statically linked procedures accessible to
 * the Objectkit Smalltalk C Programming kit
 * must be defined in this function using
 * UPRegisterSymbolAndHandle(char *, void *).
 */
void
UPInitLinkRegistry()
{
	return;
}

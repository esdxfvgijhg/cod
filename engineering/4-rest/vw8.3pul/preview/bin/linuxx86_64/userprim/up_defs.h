/************************************************************************
 *
 * Typedefs, constants and declaration macros
 * for VisualWorks(R) User-defined Primitives API
 *
 * Copyright (C) 1999-2016 Cincom Systems, Inc.  All rights reserved.
 *
 ************************************************************************/

#ifndef TRUE
# define TRUE 1
# define FALSE 0
#endif
#ifndef NULL
# define NULL 0
#endif

/*The inclusive range  of valid user primitives */
#define MINUSERPRIMITIVES 10000
#define MAXUSERPRIMITIVES 65535			/* avoid #'s >19,999 */
/* The maximum number of arguments that a user primitive may have */
#define MAXARGSUSERPRIMITIVE 15
#define _UP_FAIL -1
#define _UP_SUCCEED 1

/* default to VW32, but insist on consistent definitions if defined */
#if VW32
# if VW64
#	error "cannot be both VW32 and VW64"
# endif
#elif VW64
#else
# define VW32 1
#endif

/* ==================== type definitions ========================== */

/* upHandle defined elsewhere, treat as opaque */
typedef char          upBool;			/* at least 0 and 1 */
typedef unsigned char upByte;			/* at least -128 ... 127 */
/* upInt must be exactly 32 bits in the 32-bit system, and exactly 64-bits
 * in the 64-bit system.
 */
#if _WIN64
typedef __int64       upInt;
#else
typedef long          upInt;			/* exactly 32/64 bits long */
#endif
typedef float         upFloat;			/* ieee single precision */
typedef double        upDouble;			/* ieee double precision */
typedef char          upChar;			/* at least 1 ... 127 */

typedef void (*upFunct)();


/* ==================== Failure codes  ========================== */

		/* code 0 indicates no current error */

#define UPECrange (-1)
        /* C argument out of range, probably not large enough data. */

#define UPESrange (-2)
        /* Smalltalk-80 argument out of range */

#define UPEnonOop  (-3)
        /* upHandle argument was non-upHandle. */

#define UPEwrongClass  (-4)
        /* upHandle argument incorrect type */

#define UPEargCheckFailed (-5)
        /* declared arg wrong type */

#define UPEintNotSmallInteger  (-6)
        /* C int was not a SmallInteger */

#define UPEobjectTooSmall (-7)
        /* C data structure too small. */

#define UPEconversionTooSmall (-8)
        /* Smalltalk datum too small to be represented in C. */

#define UPEconversionTooBig (-9)
        /* Smalltalk datum too big to be represented in C. */

#define UPEallocationFailed (-10)
        /* Smalltalk object memory allocation failed */

#define UPEargCountMatch (-11)
        /* The argument count for this user primitive doesn't match
           the registered argument count */

#define UPEprimitiveNotInstalled (-12)
        /* The user primitive is not installed */

#define UPEtooManyArguments (-13)
        /* Too many arguments */

#define UPEnoReturnValue (-14)
	    /* The user primitive returned with no value */

#define UPEassertFail (-15)
		/* The primitive invoked an assertion failure */

#define UPEstoreFailure (-16)
		/* The primitive peformed a store which could not be "remembered" */

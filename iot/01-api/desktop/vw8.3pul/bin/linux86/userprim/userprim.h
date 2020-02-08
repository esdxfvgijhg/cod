/************************************************************************
 *
 * Definition of VisualWorks(R) User-defined Primitives API
 *
 * Copyright (C) 1999-2016 Cincom Systems, Inc.  All rights reserved.
 *
 ************************************************************************/

#if defined(c_plusplus) || defined(__cplusplus)
extern "C" {
#endif

#include "up_defs.h"

/* system oop registry indices */
/* From: sysOop32.h & sysOop64.h */
#define nilOopX 0
#define trueOopX 1
#define falseOopX 2
#if VW32
# define smallIntegerClassX 7
# define characterClassX 8
# define floatClassX 9
# define pointClassX 10
# define arrayClassX 12
# define semaphoreClassX 13
# define byteStringClassX 19
# define largePositiveIntegerClassX 20
# define largeNegativeIntegerClassX 28
# define byteSymbolClassX 22
# define byteArrayClassX 24
# define twoByteStringClassX 29
# define twoByteSymbolClassX 30
# define doubleClassX 32
#else
# define smallIntegerClassX 4
# define characterClassX 6
# define arrayClassX 15
# define semaphoreClassX 16
# define byteStringClassX 17
# define largePositiveIntegerClassX 18
# define largeNegativeIntegerClassX 19
# define byteSymbolClassX 21
# define byteArrayClassX 22
# define twoByteStringClassX 23
# define twoByteSymbolClassX 24
# define doubleClassX 25
# define pointClassX 27
# define floatClassX 28
#endif


/* ====================== main entrance ========================== */
extern int
oeMain(int, char**, char**);

#ifdef UNSAFE
/* =====================================================================
 * WARNING -- If you compile your primitives with -DUNSAFE you will get
 * an equivalent user-primitive support API which will run somewhat
 * faster but bugs in your primitives can crash the resulting VM (rather
 * than fail), and worse some bugs can silently corrupt the VI.  You
 * should test your primitive code VERY carefully before compiling with
 * -DUNSAFE and using the resulting VM's on VI's you care about.
 * Finally, VMs built with -DUNSAFE and their derived VI's will not be
 * handled by Cincom technical support.
 * =====================================================================
 */
#  include "up_unsafe.h"

#else /* ndef(UNSAFE) */

typedef struct _otEntryS *_oop;
typedef _oop upHandle;


/*
 * UPaddPrimitive( primNumber, primFunc, numArgs ) --
 * Add primFunc with numArgs number of arguments as a user primitive.
 */
extern upBool UPaddPrimitive(upInt, upFunct, upInt);

/*
 * UPnil() --
 * Return Smalltalk nil.
 */
extern upHandle UPnil(void);

/*
 * UPreturnHandle( aUpHandle ) --
 * Primitive return this object.
 */
extern void
UPreturnHandle(upHandle);

/*
 * UPreturnNil() --
 * Primitive return nil.
 */
extern void
UPreturnNil(void);

/*
 * UPreturnTrue() --
 * Primitive return True.
 */
extern void
UPreturnTrue(void);

/*
 * UPreturnFalse() --
 * Primitive return False.
 */
extern void
UPreturnFalse(void);

/*
 * UPSTtoCbool( aUpHandle ) --
 * Convert this Smalltalk Boolean to a upBool [e.g. either TRUE or FALSE].
 */
extern upBool
UPSTtoCbool(upHandle);

/*
 * UPSTtoCint( aUpHandle ) --
 * Convert this Smalltalk SmallInteger to a C upInt.
 */
extern upInt
UPSTtoCint(upHandle);

/*
 * UPSTtoCchar( aUpHandle ) --
 * Convert this Smalltalk Character to a C character.
 */
extern upChar
UPSTtoCchar(upHandle);

/*
 * UPSTtoCfloat( aUpHandle ) --
 * Convert this Smalltalk Float to a C Float.
 */
extern upFloat
UPSTtoCfloat(upHandle);

/*
 * UPCtoSTbool( aUpBool ) --
 * Convert aUpBool to a Smalltalk Boolean.
 */
extern upHandle
UPCtoSTbool(upBool);

/*
 * UPCtoSTint( aUpInt ) --
 * Convert aUpInt to a Smalltalk Integer.
 * We can only represent -[2^29] ... [2^29 - 1] (signed 30 bits).
 */
extern upHandle
UPCtoSTint(upInt);

/*
 * UPCtoSTchar( aUpChar ) --
 * Convert aUpChar to a Smalltalk Character.
 */
extern upHandle
UPCtoSTchar(upChar);

/*
 * UPinstVarSize( aUpHandle ) --
 * Return the number of this object's instance variables.
 */
extern upInt
UPinstVarSize(upHandle);

/*
 * UPindexVarSize( aUpHandle ) --
 * Return the size of this object in number of indexed variables.
 */
extern upInt
UPindexVarSize(upHandle);


/*
 * UPbasicAt( arrayUpHandle, index ) --
 * Return the upHandle at the one based index of arrayUpHandle.
 */
extern upHandle
UPbasicAt(upHandle, upInt);

/*
 * UPinstVarAt( aUpHandle, index ) --
 * Return the value of the one based index'th instance variable.
 */
extern upHandle
UPinstVarAt(upHandle, upInt);

/*
 * UPbyteAt( aUpHandle, index ) --
 * Return the byte at the one based index from aUpHandle which
 * should be a ByteArray or String.
 */
extern upByte
UPbyteAt(upHandle, upInt);

/*
 * UPintegerAt( aUpHandle, index ) --
 * Return the upInteger at the one based index from aUpHandle which
 * should be a Array.
 */
extern upInt
UPintegerAt(upHandle, upInt);

/*
 * UPfloatAt( aUpHandle, index ) --
 * Return the upFloat at the one based index from aUpHandle which
 * should be a Array.
 */
extern upFloat
UPfloatAt(upHandle, upInt);

/*
 * UPbasicAtPut( arrayUpHandle, index, upHandleToBePut ) --
 * Put upHandleToBePut into the arrayUpHandle at the one based index.
 */
extern void /* was upHandle */
UPbasicAtPut(upHandle, upInt, upHandle);

/*
 * UPinstVarAtPut( aUpHandle, index, upHandleToBePut ) --
 * Put upHandleToBePut into the one based index'th instance variable.
 */
extern void /* was upHandle */
UPinstVarAtPut(upHandle, upInt, upHandle);

/*
 * UPbyteAtPut( aUpHandle, index, aUpByte ) --
 * Put the byte at the one based index in the ByteArray or String indicated
 * by aUpHandle.
 */
extern void /* was upByte */
UPbyteAtPut(upHandle, upInt, upByte);

/*
 * UPintegerAtPut( aUpHandle, index, aUpInt ) --
 * Put the integer at the one based index in the Array indicated
 * by aUpHandle.
 */
extern void /* was upInt */
UPintegerAtPut(upHandle, upInt, upInt);

/*
 * UPisCharacter( aUpHandle ) --
 * is aUpHandle a Character?
 */
extern upBool
UPisCharacter(upHandle);

/*
 * UPisInteger( aUpHandle ) --
 * is aUpHandle a SmallInteger?
 */
extern upBool
UPisInteger(upHandle);

/*
 * UPisByteArray( aUpHandle ) --
 * is aUpHandle a ByteArray?
 */
extern upBool
UPisByteArray(upHandle);

/*
 * UPisBoolean( aUpHandle ) --
 * Is aUpHandle a Boolean?
 */
extern upBool
UPisBoolean(upHandle);

/*
 * UPisFloat( aUpHandle ) --
 * Is aUpHandle a Float?
 */
extern upBool
UPisFloat(upHandle);

/*
 * UPisDouble(aUpHandle) --
 * Is the handle a Smalltalk Double?
 */
extern upBool
UPisDouble(upHandle);

/*
 * UPisByteLike( aUpHandle ) --
 * Does aUpHandle have ByteArray accessing semantics?
 */
extern upBool
UPisByteLike(upHandle);

#endif
/* end of #ifdef(UNSAFE) */

/*
 * Message based callback API:
 */
extern upHandle
UPSendMessageMany(upHandle, upHandle, upHandle, upHandle *, upHandle);

extern upHandle
UPSendMessage0(upHandle, upHandle, upHandle *, upHandle);

extern upHandle
UPSendMessage1(upHandle, upHandle, upHandle, upHandle *, upHandle);

extern upHandle
UPSendMessage2(upHandle, upHandle, upHandle, upHandle, upHandle *, upHandle);

extern upHandle
UPSendMessage3(upHandle, upHandle, upHandle, upHandle, upHandle, upHandle *, upHandle);

/*
 * For C-oriented callbacks (char * instead of selector,
 * arguments passed in C-Array instead of Smalltalk Array).
 */
extern upHandle
UPCSendMessageMany(upHandle, char *, upHandle *, long, upHandle *, upHandle);

extern upHandle
UPCSendMessage0(upHandle, char *, upHandle *, upHandle);

extern upHandle
UPCSendMessage1(upHandle, char *, upHandle, upHandle *, upHandle);

extern upHandle
UPCSendMessage2(upHandle, char *, upHandle, upHandle, upHandle *, upHandle);

extern upHandle
UPCSendMessage3(upHandle, char *, upHandle, upHandle, upHandle, upHandle *, upHandle);

/*
 * Static link registration:
 */

extern void
UPRegisterSymbolAndHandle(char *, void *);


/* doubles and allocation entrypoints have no UNSAFE implementation */

/*
 * UPstringSize( aUpHandle ) --
 * Return the size of this string object in number of characters.
 */
extern upInt
UPstringSize(upHandle);

/*
 * UPisString( aUpHandle ) --
 * is aUpHandle a String that can be stored into?
 */
extern upBool
UPisString(upHandle);

/*
 * UPisReadOnlyString( aUpHandle ) --
 * is aUpHandle a String that is readable but possibly not stored into?
 */
extern upBool
UPisReadOnlyString(upHandle);

/*
 * UPdoubleAt( aUpHandle, index ) --
 * Return the upDouble at the one based index from aUpHandle which
 * should be a Array.
 */
extern upDouble
UPdoubleAt(upHandle, upInt);

/*
 * UPSTtoCdouble(aUpHandle) --
 * Convert a Smalltalk Double to a upDouble.
 */
extern upDouble
UPSTtoCdouble(upHandle);

/*
 * UPCtoSTfloat(aUpFloat) --
 * Convert aUpFloat to a Smalltalk Float.
 */
extern upHandle
UPCtoSTfloat(upFloat);

/*
 * UPCtoSTdouble(aUpDouble) --
 * Convert aUpDouble to a Smalltalk Double.
 */
extern upHandle
UPCtoSTdouble(upDouble);

/*
 * UPfloatAtPut(aUpHandle, index, aUpFloat) --
 * Put the Float at the one based index in the Array indicated
 * by aUpHandle.
 */
extern void /* was upFloat */
UPfloatAtPut(upHandle, upInt, upFloat);

/*
 * UPallocString(anUpChar, numElements) --
 * Allocate a Smalltalk String of size numElements and initialize
 * all its elements to anUpChar.
 */
extern upHandle
UPallocString(upChar, upInt);

/*
 * UPallocByteArray(anUpByte, numElements) --
 * Allocate a Smalltalk ByteArray of size numElements and initialize
 * all the elements to anUpByte.
 */
extern upHandle
UPallocByteArray(upByte, upInt);

/*
 * UPallocArray(anUpHandle, numElements) --
 * Allocate an Array of size numElements, and initialize all the elements
 * to anUpHandle.
 */
extern upHandle
UPallocArray(upHandle, upInt);

/*
 * UPcopySTtoCstring(aUpHandle, aUpString, aCount, startingAt) --
 * Copy up to aCount elements from the Smalltalk String aUpHandle beginning
 * with the one based index startingAt into the C string aUpString.
 * Return the number of elements actually copied.
 */
extern upInt
UPcopySTtoCstring(upHandle, upChar *, upInt, upInt);

/*
 * UPcopySTtoCbytes(aUpHandle, aUpBytes, aCount, startingAt) --
 * Copy up to aCount elements from the Smalltalk ByteArray aUpHandle beginning
 * with the one based index startingAt into the C byte array aUpBytes.
 * Return the number of elements actually copied.
 */
extern upInt
UPcopySTtoCbytes(upHandle, upByte *, upInt, upInt);

/*
 * UPcopySTtoCintArray(aUpHandle, aUpIntArray, aCount, startingAt) --
 * Copy up to aCount elements from the Smalltalk Array aUpHandle beginning
 * with the one based index startingAt into the C array aUpIntArray.
 * Return the number of elements actually copied.
 */
extern upInt
UPcopySTtoCintArray(upHandle, upInt *, upInt, upInt);

/*
 * UPcopySTtoCfloatArray(aUpHandle, aUpFloatArray, aCount, startingAt) --
 * Copy up to aCount elements from the Smalltalk Array aUpHandle beginning
 * with the one based index startingAt into the C float array aUpFloatArray.
 * Return the number of elements actually copied.
 */
extern upInt
UPcopySTtoCfloatArray(upHandle, upFloat *, upInt, upInt);

/*
 * UPcopyCtoSTstring(aUpHandle, aUpString, aCount, startingAt) --
 * Copy up to aCount elements from the C string aUpString into the
 * Smalltalk String aUpHandle beginning with the one based index
 * startingAt. Return the the number of elements copied.
 */
extern upInt
UPcopyCtoSTstring(upHandle, upChar *, upInt, upInt);

/*
 * UPcopyCtoSTbytes(aUpHandle, aUpBytes, aCount, startingAt) --
 * Copy up to aCount elements from the C byte array aUpBytes into the
 * Smalltalk ByteArray aUpHandle beginning with the one based index
 * startingAt. Return the the number of elements copied.
 */
extern upInt
UPcopyCtoSTbytes(upHandle, upByte *, upInt, upInt);

/*
 * UPcopyCtoSTintArray(aUpHandle, aUpIntArray, aCount, startingAt) --
 * Copy up to aCount elements from the C array aUpIntArray into the
 * Smalltalk Array aUpHandle beginning with the one based index
 * startingAt. Return the the number of elements copied.
 */
extern upInt
UPcopyCtoSTintArray(upHandle, upInt *, upInt, upInt);

/*
 * UPcopyCtoSTfloatArray(aUpHandle, aUpFloatArray, aCount, startingAt) --
 * Copy up to aCount elements from the C float array aUpFloatArray into the
 * Smalltalk Array aUpHandle beginning with the one based index
 * startingAt. Return the the number of elements copied.
 */
extern upInt
UPcopyCtoSTfloatArray(upHandle, upFloat *, upInt, upInt);

/* UPisArrayOf<something> have no UNSAFE implementations */

/*
 * UPisArrayOfInteger(arryHandle) --
 * Is aUpHandle a Array of Integers?
 */
extern upBool
UPisArrayOfInteger(upHandle);

/*
 * UPisArrayOfFloat(aUpHandle) --
 * Is aUpHandle a Array of Floats?
 */
extern upBool
UPisArrayOfFloat(upHandle);

/* UPmustBe<something> have no UNSAFE implementations */
/*
 * UPmustBe<something>(handle) --
 * Same as the UPis<something> routines except fail if it isn't.
 */
extern void
UPmustBeCharacter(upHandle);
extern void
UPmustBeInteger(upHandle);
extern void
UPmustBeString(upHandle);
extern void
UPmustBeByteArray(upHandle);
extern void
UPmustBeArrayOfInteger(upHandle);
extern void
UPmustBeArrayOfFloat(upHandle);
extern void
UPmustBeBoolean(upHandle);
extern void
UPmustBeFloat(upHandle);
extern void
UPmustBeByteLike(upHandle);

/*
 * UPfail(errorCode) --
 * fail primitive (can be called anywhere, courtesy of longjmp).
 */
extern void
UPfail(upInt);

/*
 * UPinstallErrorHandler() --
 * Install function as error handler to catch errors in support routines.
 * Passing ((upFunct)NULL) as arg removes handler.
 * Returns previously installed handler.
 */
extern upFunct
UPinstallErrorHandler(upFunct);


/*
 * ===========================
 * new (post v2.5) API entries
 * ===========================
 */

#ifndef UNSAFE

/*
 * UPisImmediate(aUpHandle) --
 * Is aUpHandle an immediate object?
 */
extern upBool
UPisImmediate(upHandle);

/*
 * UPregisteredHandleAt( anUpInt ) --
 * Return a handle from the registry.
 */
extern upHandle
UPregisteredHandleAt(upInt);

/*
 * UPclass(handle)
 * Return the class of the given object.
 */
extern upHandle
UPclass(upHandle);

#endif
/* end of #ifndef UNSAFE */

/*
 * UPregisteredHandleAtPut(index, handle) --
 * Put a handle at the given slot in the registry.
 */
extern void
UPregisteredHandleAtPut(upInt, upHandle);

/*
 * UPallocRegistrySlot() --
 * Allocate a slot in the registry, return slot number.
 */
extern upInt
UPallocRegistrySlot(void);

/*
 * UPallocFsObject(classHandle) --
 * allocate a fixed-size object of the given class, return handle
 * to the instance.
 */
extern upHandle
UPallocFsObject(upHandle);

/*
 * UPallocVsObject(classHandle, size) --
 * Allocate a variable-size object of the given class and the given
 * number of elements, return handle to the instance.
 */
extern upHandle
UPallocVsObject(upHandle, upInt);

/*
 * UPclassType(classHandle) --
 * Given a handle to a class, return an integer indicating if the class
 * has fixed size instances, variable size instances, or not-a-class.
 */
#define UPnotAClass 0
#define UPfixedSizeClass 1
#define UPvariableSizeClass 2
extern upInt
UPclassType(upHandle);

/*
 * UPsignalSemaphore(semHandle) --
 * Given a handle to a semaphore, signal the semaphore.
 */
extern void
UPsignalSemaphore(upHandle);

/*
 * UPpostInterrupt() --
 * Post an interrupt request (causes VI code break-out and a call
 * to poll-handler.
 */
extern void
UPpostInterrupt(void);

/*
 * UPinstallPollHandler(pollFunc) --
 * Register a poll function (called when interrupt posted).
 */
extern void
UPinstallPollHandler(upFunct);

/*
 * UPstartLongPrimitive(int) -- UPfinishLongPrimitive() --
 * Notify the VM that this primitive may take an int milliseconds to run.
 * This pair of functions should be used for ALL primitives that might take
 * 500 milliseconds or more to run.
 * If the function UPstartLongPrimitive is called then UPfinishLongPrimitive
 * must be called before the primitive returns.  UPstartLongPrimitive may be
 * called more than once but each call must be balanced with a call to
 * UPfinishLongPrimitive.
 */
extern void
UPstartLongPrimitive(upInt);
extern void
UPfinishLongPrimitive(void);

/*
 * UPisKindOf(objUpHandle, classUpHandle) --
 * Given a handle on an object and a class, return a boolean indicating
 * whether the instance belongs to that class or its superclasses.
 */
extern upBool
UPisKindOf(upHandle, upHandle);

#if defined(c_plusplus) || defined(__cplusplus)
}       /* end of C declarations */
#endif

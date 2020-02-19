/*
 * Validation tests for VisualWorks(R) User-defined primitives
 *
 * Copyright (C) 1999-2016 Cincom Systems, Inc.  All rights reserved.
 *
 */

#include <string.h>

#include "userprim.h"

void
TstUPCtoSTbool(rcvr)
  upHandle rcvr;
{
	UPreturnHandle(UPCtoSTbool(TRUE));
}

void
TstUPCtoSTchar(rcvr)
  upHandle rcvr;
{
	UPreturnHandle(UPCtoSTchar('c'));
}

void
TstUPCtoSTfloat(rcvr)
  upHandle rcvr;
{
	UPreturnHandle(UPCtoSTfloat(3.14f));
}

void
TstUPCtoSTint(rcvr)
  upHandle rcvr;
{
	UPreturnHandle(UPCtoSTint((upInt)42));
}

void
TstUPSTtoCbool(rcvr, arg)
  upHandle rcvr, arg;
{
	upBool x = UPSTtoCbool(arg);
	UPreturnHandle(UPCtoSTbool(x));
}

void
TstUPSTtoCchar(rcvr, arg)
  upHandle rcvr, arg;
{
	upChar x = UPSTtoCchar(arg);
	UPreturnHandle(UPCtoSTchar(x));
}

void
TstUPSTtoCfloat(rcvr, arg)
  upHandle rcvr, arg;
{
	upFloat x = UPSTtoCfloat(arg);
	UPreturnHandle(UPCtoSTfloat(x));
}

void
TstUPSTtoCint(rcvr, arg)
  upHandle rcvr, arg;
{
	upInt x = UPSTtoCint(arg);
	UPreturnHandle(UPCtoSTint(x));
}

void
TstUPbasicAt(rcvr, arrayUpHandle, index)
  upHandle rcvr, arrayUpHandle, index;
{
	upInt x = UPSTtoCint(index);
	UPreturnHandle(UPbasicAt(arrayUpHandle, x));
}

void
TstUPbasicAtPut(rcvr, arrayUpHandle, index, upHandleToBePut)
  upHandle rcvr, arrayUpHandle, index, upHandleToBePut;
{
	upHandle old;
	upInt x = UPSTtoCint(index);

	old = UPbasicAt(arrayUpHandle, x);
	UPbasicAtPut(arrayUpHandle, x, upHandleToBePut);
	UPreturnHandle(old);
}

void
TstUPbyteAt(rcvr, arg, index)
  upHandle rcvr, arg, index;
{
	upInt x = UPSTtoCint(index);
	UPreturnHandle(UPCtoSTint((upInt)UPbyteAt(arg, x)));
}

void
TstUPbyteAtPut(rcvr, arg, index, aUpByte)
  upHandle rcvr, arg, index, aUpByte;
{
	upInt i;
	upInt old;

	i = UPSTtoCint(index);
	old = UPbyteAt(arg, i);
	UPbyteAtPut(arg, i, (upByte)UPSTtoCint(aUpByte));
	UPreturnHandle(UPCtoSTint(old));
}

void
TstUPcopyCtoSTintArray(rcvr, arg, aCount, startingAt)
  upHandle rcvr, arg, aCount, startingAt;
{
	static upInt aUpIntPointer[3] = {1, 2, 3};
	upInt count = UPSTtoCint(aCount),
		  start = UPSTtoCint(startingAt);

	UPreturnHandle(UPCtoSTint(UPcopyCtoSTintArray(arg, aUpIntPointer,
												  count,
												  start)));
}

void
TstUPcopyCtoSTbytes(rcvr, arg, aCount, startingAt)
  upHandle rcvr, arg, aCount, startingAt;
{
	static upByte aUpBytes[3] = {0xFF, 2, 0xFD};
	upInt count = UPSTtoCint(aCount),
		  start = UPSTtoCint(startingAt);

	UPreturnHandle(UPCtoSTint(UPcopyCtoSTbytes(arg, aUpBytes,
											   count,
											   start)));
}

void
TstUPcopyCtoSTfloatArray(rcvr, arg, aCount, startingAt)
  upHandle rcvr, arg, aCount, startingAt;
{
	static upFloat aUpFloatPointer[3] = {-1.0, 2.0, -3.0};
	upInt count = UPSTtoCint(aCount),
		  start = UPSTtoCint(startingAt);

	UPreturnHandle(UPCtoSTint(UPcopyCtoSTfloatArray(arg, aUpFloatPointer,
													count,
													start)));
}

void
TstUPcopyCtoSTstring(rcvr, arg, aCount, startingAt)
  upHandle rcvr, arg, aCount, startingAt;
{
	upInt count = UPSTtoCint(aCount),
		  start = UPSTtoCint(startingAt);

	UPreturnHandle(UPCtoSTint(UPcopyCtoSTstring(arg, "abc",
												count,
												start)));
}

void
TstUPcopySTtoCbytes(rcvr, arg, aCount, startingAt)
  upHandle rcvr, arg, aCount, startingAt;
{
	char aUpBytes[20];
	static upByte proto[6] = { 2, 2, 2, 2, 2, 2};
	upHandle myBA;
	upInt count = UPSTtoCint(aCount),
		  start = UPSTtoCint(startingAt);

	memset(aUpBytes, 0, 20);
	memcpy(aUpBytes, (char *)proto, sizeof(proto));
	(void)UPcopySTtoCbytes(arg, (upByte *)&aUpBytes[start - 1], count, 1L);
	myBA = UPallocByteArray((upByte)0, (upInt)sizeof(proto));
	(void)UPcopyCtoSTbytes(myBA, (upByte *)aUpBytes, (upInt)sizeof(proto), 1L);
	UPreturnHandle(myBA);
}

void
TstUPcopySTtoCfloatArray(rcvr, arg, aCount, startingAt)
  upHandle rcvr, arg, aCount, startingAt;
{
	upFloat aUpFloats[20];
	static upFloat proto[6] = { 2.0, 2.0, 2.0, 2.0, 2.0, 2.0};
	int sz;
	upHandle myA;
	upInt count = UPSTtoCint(aCount),
		  start = UPSTtoCint(startingAt);

	memcpy((char *)aUpFloats, (char *)proto, sizeof(proto));
	(void)UPcopySTtoCfloatArray(arg, &aUpFloats[start - 1], count, 1L);
	sz = sizeof(proto) / sizeof(float);
	myA = UPallocArray(UPCtoSTfloat(0.0), (upInt)sz);
	(void)UPcopyCtoSTfloatArray(myA, aUpFloats, (upInt)sz, 1L);
	UPreturnHandle(myA);
}

void
TstUPcopySTtoCintArray(rcvr, arg, aCount, startingAt)
  upHandle rcvr, arg, aCount, startingAt;
{
	upInt aUpInts[20];
	static upInt proto[6] = { 2, 2, 2, 2, 2, 2};
	upHandle myA;
	upInt count = UPSTtoCint(aCount),
		  start = UPSTtoCint(startingAt);
	int sz;

	memcpy( (char *)aUpInts, (char *)proto, sizeof(proto));
	(void)UPcopySTtoCintArray(arg, &aUpInts[start - 1],	count, 1L);
	sz = sizeof(proto) / sizeof(int);
	myA = UPallocArray(UPCtoSTint(0L), (upInt)sz);
	(void)UPcopyCtoSTintArray(myA, aUpInts, (upInt)sz, 1L);
	UPreturnHandle(myA);
}

void
TstUPcopySTtoCstring(rcvr, arg, aCount, startingAt)
  upHandle rcvr, arg, aCount, startingAt;
{
	upHandle myA;
	char aUpString[20];
	upInt count = UPSTtoCint(aCount),
		  start = UPSTtoCint(startingAt);

	strcpy(aUpString, "bbbbbb");
	(void)UPcopySTtoCstring(arg, &aUpString[start - 1], count, 1L);
	myA = UPallocString(' ', (upInt)strlen(aUpString));
	(void)UPcopyCtoSTstring(myA, aUpString, (upInt)strlen(aUpString), 1L);
	UPreturnHandle(myA);
}


void
TstUPfloatAt(rcvr, arg, index)
  upHandle rcvr, arg, index;
{
	upInt x = UPSTtoCint(index);
	UPreturnHandle(UPCtoSTfloat(UPfloatAt(arg, x)));
}

void
TstUPintegerAt(rcvr, arg, index)
  upHandle rcvr, arg, index;
{
	upInt x = UPSTtoCint(index);
	x = UPintegerAt(arg, x);
	UPreturnHandle(UPCtoSTint(x));
}

void
TstUPfloatAtPut(rcvr, arg, index, aFloat)
  upHandle rcvr, arg, index, aFloat;
{
	upInt i;
	upHandle old;

	i = (int)UPSTtoCint(index);
	old = UPbasicAt(arg, i);
	UPfloatAtPut(arg, i, UPSTtoCfloat(aFloat));
	UPreturnHandle(old);
}

void
TstUPindexVarSize(rcvr, arg)
  upHandle rcvr, arg;
{
	upInt x = UPindexVarSize(arg);
	UPreturnHandle(UPCtoSTint(x));
}

void
TstUPinstVarAt(rcvr, arg, index)
  upHandle rcvr, arg, index;
{
	upInt x = UPSTtoCint(index);
	UPreturnHandle(UPinstVarAt(arg, x));
}

void
TstUPinstVarAtPut(rcvr, arg, index, upHandleToBePut)
  upHandle rcvr, arg, index, upHandleToBePut;
{
	upHandle old;

	old = UPinstVarAt(arg, (int)UPSTtoCint(index));
	UPinstVarAtPut(arg, (int)UPSTtoCint(index), upHandleToBePut);
	UPreturnHandle(old);
}

void
TstUPinstVarSize(rcvr, arg)
  upHandle rcvr, arg;
{
	upInt x = UPinstVarSize(arg);
	UPreturnHandle(UPCtoSTint(x));
}

void
TstUPintegerAtPut(rcvr, arg, index, aUpInt)
  upHandle rcvr, arg, index, aUpInt;
{
	upInt i;
	upHandle old;

	i = UPSTtoCint(index);
	old = UPbasicAt(arg, i);
	UPintegerAtPut(arg, i, UPSTtoCint(aUpInt));
	UPreturnHandle(old);
}

void
TstUPisArrayOfFloat(rcvr, arg)
  upHandle rcvr, arg;
{
	UPreturnHandle(UPCtoSTbool(UPisArrayOfFloat(arg)));
}

void
TstUPisArrayOfInteger(rcvr, arg)
  upHandle rcvr, arg;
{
	UPreturnHandle(UPCtoSTbool(UPisArrayOfInteger(arg)));
}

void
TstUPisBoolean(rcvr, arg)
  upHandle rcvr, arg;
{
	UPreturnHandle(UPCtoSTbool(UPisBoolean(arg)));
}

void
TstUPisByteArray(rcvr, arg)
  upHandle rcvr, arg;
{
	UPreturnHandle(UPCtoSTbool(UPisByteArray(arg)));
}

void
TstUPisCharacter(rcvr, arg)
  upHandle rcvr, arg;
{
	UPreturnHandle(UPCtoSTbool(UPisCharacter(arg)));
}

void
TstUPisFloat(rcvr, arg)
  upHandle rcvr, arg;
{
	UPreturnHandle(UPCtoSTbool(UPisFloat(arg)));
}

void
TstUPisInteger(rcvr, arg)
  upHandle rcvr, arg;
{
	UPreturnHandle(UPCtoSTbool(UPisInteger(arg)));
}

void
TstUPisString(rcvr, arg)
  upHandle rcvr, arg;
{
	UPreturnHandle(UPCtoSTbool(UPisString(arg)));
}

void
TstUPisByteLike(rcvr, arg)
  upHandle rcvr, arg;
{
	UPreturnHandle(UPCtoSTbool(UPisByteLike(arg)));
}

void
TstUPnil(rcvr)
  upHandle rcvr;
{
	UPreturnHandle(UPnil());
}

void
TstUPreturnFalse(rcvr)
  upHandle rcvr;
{
	UPreturnFalse();
}

void
TstUPreturnHandle(rcvr, arg)
  upHandle rcvr, arg;
{
	UPreturnHandle(arg);
}

void
TstUPreturnNil(rcvr)
  upHandle rcvr;
{
	UPreturnNil();
}

void
TstUPreturnTrue(rcvr)
  upHandle rcvr;
{
	UPreturnTrue();
}

static void
myHandler(code)
  upInt code;
{
	(void)UPinstallErrorHandler((upFunct)0);	/* remove handler */
	UPreturnHandle(UPCtoSTint(100));
}

void
TstUPerrorHandler(rcvr)
  upHandle rcvr;
{
	upHandle junk;

	(void)UPinstallErrorHandler(myHandler);
	junk = UPallocArray(UPCtoSTint(0), 2); /* two elements */
	UPfloatAtPut(junk, 10L, 1.0);		/* this should fail*/
	UPfail(101);						/* shouldn't get here */
}

void
TstUP32Arguments(rcvr,a01,a02,a03,a04,a05,a06,a07,a08,a09,
				 a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,
				 a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,
				 a30,a31,a32)
  upHandle rcvr,a01,a02,a03,a04,a05,a06,a07,a08,a09,
	a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,
	a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,
	a30,a31,a32;
{
	upHandle array;

	array = UPallocArray(UPnil(), 33L);
	UPbasicAtPut(array,33,rcvr);
	UPbasicAtPut(array,01,a01);
	UPbasicAtPut(array,02,a02);
	UPbasicAtPut(array,03,a03);
	UPbasicAtPut(array,04,a04);
	UPbasicAtPut(array,05,a05);
	UPbasicAtPut(array,06,a06);
	UPbasicAtPut(array,07,a07);
	UPbasicAtPut(array, 8,a08);
	UPbasicAtPut(array, 9,a09);
	UPbasicAtPut(array,10,a10);
	UPbasicAtPut(array,11,a11);
	UPbasicAtPut(array,12,a12);
	UPbasicAtPut(array,13,a13);
	UPbasicAtPut(array,14,a14);
	UPbasicAtPut(array,15,a15);
	UPbasicAtPut(array,16,a16);
	UPbasicAtPut(array,17,a17);
	UPbasicAtPut(array,18,a18);
	UPbasicAtPut(array,19,a19);
	UPbasicAtPut(array,20,a20);
	UPbasicAtPut(array,21,a21);
	UPbasicAtPut(array,22,a22);
	UPbasicAtPut(array,23,a23);
	UPbasicAtPut(array,24,a24);
	UPbasicAtPut(array,25,a25);
	UPbasicAtPut(array,26,a26);
	UPbasicAtPut(array,27,a27);
	UPbasicAtPut(array,28,a28);
	UPbasicAtPut(array,29,a29);
	UPbasicAtPut(array,30,a30);
	UPbasicAtPut(array,31,a31);
	UPbasicAtPut(array,32,a32);
	if (UPisInteger(a01))
		UPreturnHandle(array);
	else
		UPfail(1);
}

void
TstUPregHandleAt(rcvr, indx)
  upHandle rcvr;
  upHandle indx;
{
	upInt x = UPSTtoCint(indx);
	UPreturnHandle(UPregisteredHandleAt(x));
}


void
TstUPisImmediate(rcvr, arg)
  upHandle rcvr;
  upHandle arg;
{
	UPreturnHandle(UPCtoSTbool(UPisImmediate(arg)));
}

void
TstUPallocRegSlot(rcvr)
  upHandle rcvr;
{
	UPreturnHandle(UPCtoSTint(UPallocRegistrySlot()));
}

void
TstUPregHandleAtPut(rcvr, indx, val)
  upHandle rcvr;
  upHandle indx;
  upHandle val;
{
	upInt x = UPSTtoCint(indx);
	UPregisteredHandleAtPut(x, val);
	UPreturnHandle(UPregisteredHandleAt(x));
}

void
TstUPallocFs(rcvr, cls)
  upHandle rcvr;
  upHandle cls;
{
	UPreturnHandle(UPallocFsObject(cls));
}

void
TstUPallocVs(rcvr, cls, sz)
  upHandle rcvr;
  upHandle cls;
  upHandle sz;
{
	upInt size = UPSTtoCint(sz);
	UPreturnHandle(UPallocVsObject(cls, size));
}

void
TstUPclassType(rcvr, cls)
  upHandle rcvr;
  upHandle cls;
{
	UPreturnHandle(UPCtoSTint(UPclassType(cls)));
}

void
TstUPsignalSem(rcvr, sem)
  upHandle rcvr;
  upHandle sem;
{
	UPsignalSemaphore(sem);
	UPreturnHandle(sem);
}

static upInt mySlot = -1;

void
myPollHandler()
{
	if(mySlot > 0) {
		UPsignalSemaphore(UPregisteredHandleAt(mySlot));
		UPregisteredHandleAtPut(mySlot, UPnil());
	}
	UPinstallPollHandler((upFunct)0);
}

void
TstUPpostInt(rcvr, sem)
  upHandle rcvr;
  upHandle sem;
{
	mySlot = UPallocRegistrySlot();
	UPregisteredHandleAtPut(mySlot, sem);
	UPinstallPollHandler(myPollHandler);
	UPpostInterrupt();
	UPreturnHandle(rcvr);
}

void
TstUPisKindOf(rcvr, inst, cls)
  upHandle rcvr;
  upHandle inst;
  upHandle cls;
{
	UPreturnHandle(UPCtoSTbool(UPisKindOf(inst, cls)));
}

void
TstUPCtoSTdouble(rcvr)
  upHandle rcvr;
{
	UPreturnHandle(UPCtoSTdouble(3.14));
}

void
TstUPSTtoCdouble(rcvr, arg)
  upHandle rcvr, arg;
{
	upDouble d = UPSTtoCdouble(arg);
	UPreturnHandle(UPCtoSTdouble(d));
}

void
TstUPisDouble(rcvr, arg)
  upHandle rcvr, arg;
{
	UPreturnHandle(UPCtoSTbool(UPisDouble(arg)));
}

void
TstUPclass(rcvr, arg)
   upHandle rcvr, arg;
{
	UPreturnHandle(UPclass(arg));
}

void
sumByteArray(rcvr, ba)
	upHandle rcvr;
	register upHandle ba;
{
	register int sz, i;
	register int sum = 0;

	if(!UPisByteArray(ba))
		UPfail(UPEwrongClass);
	sz = UPindexVarSize(ba);
	for(i = 1; i <= sz; i++) {
		sum += UPbyteAt(ba, i);
	}
	UPreturnHandle(UPCtoSTint(sum));
}

void
zeroArray(rcvr, a)
	upHandle rcvr;
	register upHandle a;
{
	register int sz, i;
	register upHandle zero = UPCtoSTint(0);

	if(UPclass(a) != UPregisteredHandleAt(arrayClassX))
		UPfail(UPEwrongClass);
	sz = UPindexVarSize(a);
	for(i = 1; i <= sz; i++) {
		UPbasicAtPut(a, i, zero);
	}
	UPreturnHandle(rcvr);
}

char*
UPinstall()
{
    UPaddPrimitive(10001, TstUPCtoSTbool, 0);
    UPaddPrimitive(10002, TstUPCtoSTchar, 0);
    UPaddPrimitive(10003, TstUPCtoSTfloat, 0);
    UPaddPrimitive(10004, TstUPCtoSTint, 0);
    UPaddPrimitive(10005, TstUPSTtoCbool, 1);
    UPaddPrimitive(10006, TstUPSTtoCchar, 1);
    UPaddPrimitive(10007, TstUPSTtoCfloat, 1);
    UPaddPrimitive(10008, TstUPSTtoCint, 1);
/* 10009 - 10015 */
    UPaddPrimitive(10016, TstUPbasicAt, 2);
    UPaddPrimitive(10017, TstUPbasicAtPut, 3);
    UPaddPrimitive(10018, TstUPbyteAt, 2);
    UPaddPrimitive(10019, TstUPbyteAtPut, 3);
    UPaddPrimitive(10020, TstUPcopyCtoSTintArray, 3);
    UPaddPrimitive(10021, TstUPcopyCtoSTbytes, 3);
    UPaddPrimitive(10022, TstUPcopyCtoSTfloatArray, 3);
    UPaddPrimitive(10023, TstUPcopyCtoSTstring, 3);
    UPaddPrimitive(10024, TstUPcopySTtoCbytes, 3);
    UPaddPrimitive(10025, TstUPcopySTtoCfloatArray, 3);
    UPaddPrimitive(10026, TstUPcopySTtoCintArray, 3);
    UPaddPrimitive(10027, TstUPcopySTtoCstring, 3);
/* 10028 */
/* 10029 */
    UPaddPrimitive(10030, TstUPfloatAt, 2);
    UPaddPrimitive(10031, TstUPfloatAtPut, 3);
    UPaddPrimitive(10032, TstUPindexVarSize, 1);
    UPaddPrimitive(10033, TstUPinstVarAt, 2);
    UPaddPrimitive(10034, TstUPinstVarAtPut, 3);
    UPaddPrimitive(10035, TstUPinstVarSize, 1);
    UPaddPrimitive(10036, TstUPintegerAtPut, 3);
    UPaddPrimitive(10037, TstUPisArrayOfFloat, 1);
    UPaddPrimitive(10038, TstUPisArrayOfInteger, 1);
    UPaddPrimitive(10039, TstUPisBoolean, 1);
    UPaddPrimitive(10040, TstUPisByteArray, 1);
    UPaddPrimitive(10041, TstUPisCharacter, 1);
    UPaddPrimitive(10042, TstUPisFloat, 1);
    UPaddPrimitive(10043, TstUPisInteger, 1);
    UPaddPrimitive(10044, TstUPisString, 1);
    UPaddPrimitive(10045, TstUPnil, 0);
    UPaddPrimitive(10046, TstUPreturnFalse, 0);
    UPaddPrimitive(10047, TstUPreturnHandle, 1);
    UPaddPrimitive(10048, TstUPreturnNil, 0);
    UPaddPrimitive(10049, TstUPreturnTrue, 0);
    UPaddPrimitive(10050, TstUPerrorHandler, 0);
	UPaddPrimitive(10051, TstUPisByteLike, 1);
	UPaddPrimitive(10052, TstUP32Arguments, 32);
	UPaddPrimitive(10053, TstUPintegerAt, 2);
/* post-2.5 routine tests */
	UPaddPrimitive(10054, TstUPregHandleAt, 1);
	UPaddPrimitive(10055, TstUPregHandleAtPut, 2);
	UPaddPrimitive(10056, TstUPallocRegSlot, 0);
	UPaddPrimitive(10057, TstUPallocFs, 1);
	UPaddPrimitive(10058, TstUPallocVs, 2);
	UPaddPrimitive(10059, TstUPclassType, 1);
	UPaddPrimitive(10060, TstUPsignalSem, 1);
	UPaddPrimitive(10061, TstUPpostInt, 1);	/* installs poll-handler */
	UPaddPrimitive(10062, TstUPisKindOf, 2);
	UPaddPrimitive(10063, TstUPisDouble, 1);
	UPaddPrimitive(10064, TstUPCtoSTdouble, 0);
	UPaddPrimitive(10065, TstUPSTtoCdouble, 1);
	UPaddPrimitive(10066, TstUPclass, 1);
	UPaddPrimitive(10067, TstUPisImmediate, 1);

	/* performance tests */
	UPaddPrimitive(10100, sumByteArray, 1);
	UPaddPrimitive(10101, zeroArray, 1);
	return "Validation User Primitives";
}

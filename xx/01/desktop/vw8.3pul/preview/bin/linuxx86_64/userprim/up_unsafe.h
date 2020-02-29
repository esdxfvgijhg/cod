/*
 * Implementation of "unsafe" VisualWorks(R) User-defined Primitives API
 *
 * ======================================================================
 * WARNING -- If you compile your primitives with -DUNSAFE you will get
 * an equivalent user-primitive support API which will run somewhat
 * faster but bugs in your primitives can crash the resulting VM (rather
 * than fail), and worse some bugs can silently corrupt the VI.  You
 * should test your primitive code VERY carefully before compiling with
 * -DUNSAFE and using the resulting VM's on VI's you care about.
 *
 * ======================================================================
 *
 * Note:  This file defines a supported API for user-defined primitives.
 * Specific VM implementation details exposed by this code does *not*
 * represent a supported VM interface and hence will change from
 * release-to-release, and have hidden dependencies and restrictions which
 * may render them useless outside this context.  In other words, pretend
 * that you can't read this file!
 *
 * Copyright (C) 1999-2016 Cincom Systems, Inc.  All rights reserved.
 *
 ************************************************************************/

#include "unsafe_oops.h"
typedef _oop upHandle;					/* handles are real oops */

extern upBool UnsafeUPaddPrimitive(upInt, upFunct, upInt);

/* UPaddPrimitive( primNumber, primFunc, numArgs )
 * Add primFunc with numArgs number of arguments into the UserPrimTable */
#define UPaddPrimitive(pn, pf, na) UnsafeUPaddPrimitive(pn, pf, na)

/* answer the oop of nil */
#define UPnil() _sysOop(nilOopX)

/* Convert this Smalltalk Boolean to a upBool (e.g. either TRUE or FALSE) */
#define UPSTtoCbool(anOop) ((anOop) == _sysOop(trueOopX))

/* Convert this Smalltalk SmallInteger to a C upInt */
#define UPSTtoCint(anOop) _oopIntVal(anOop)

/* Convert this Smalltalk Character to a C character */
#define UPSTtoCchar(anOop) _oopCharVal(anOop)

/* Convert this Smalltalk Float to a C Float */
#define UPSTtoCfloat(anOop) (*_objDataPtr((anOop), float))

/* Convert the aUpBool into a Smalltalk Boolean */
#define UPCtoSTbool(aUpBool) \
	((aUpBool) ? _sysOop(trueOopX) : _sysOop(falseOopX))

/* Convert this aUpInt into a upHandle */
#define UPCtoSTint(aUpInt) _asSmallInt((aUpInt))

/* Convert this aUpInt into a Smalltalk Character */
#define UPCtoSTchar(aUpChar) _asChar(aUpChar)

/* answer the number of this object's instance variables */
#define UPinstVarSize(anOop) _numFixedFields(anOop)

/* answer the size of this object in number of indexed variables */
#define UPindexVarSize(anOop) \
	(_objHasPtrs(anOop) ?  _objVarOopSize(anOop) : _objDataSize(anOop))

/* answer the upHandle at index in variable-part of anOop (1-based) */
#define UPbasicAt(anOop, index) \
	(*(_objVarDataPtr(anOop) + (index) - 1))

/* return the value of the index'th instance variable (1-based) */
#define UPinstVarAt(anOop, index) \
	(*(_objDataPtr(anOop, _oop) + (index) - 1))

/* Return the byte at index in variable-byte object anOop (1-based) */
#define UPbyteAt(anOop, index) (*(_objDataPtr((anOop), upByte) + (index) - 1))

/* Return the upInt at index (1-based) in anOop, a variable-ptr object */
#define UPintegerAt(anOop, index) \
	_oopIntVal(*(_objVarDataPtr(anOop) + (index) - 1))

/* Return the upFloat at index (1-based) in anOop, a variable-ptr object */
#define UPfloatAt(anOop, index) \
	(*(_objDataPtr((*(_objDataPtr(anOop, _oop) + (index) - 1 + \
					_numFixedFields(anOop))), upFloat)))


/* put otherOop into the variable-ptr object anOop at index (1-based) */
#define UPbasicAtPut(anOop, index, otherOop) { \
	int offset = (index) + _numFixedFields(anOop) - 1; \
	_checkStoreOop(anOop, offset, otherOop); \
	*(_objDataPtr(anOop, _oop) + offset) = otherOop; }

/* put otherOop into the ptr object anOop at index'd IV (1-based) */
#define UPinstVarAtPut(anOop, index, otherOop) { \
	int offset = (index) - 1; \
	_checkStoreOop(anOop, offset, otherOop); \
	*(_objDataPtr(anOop, _oop) + offset) = otherOop; }


/* Put the byte at index (1-based) in the variable-byte object anOop */
#define UPbyteAtPut(anOop, index, aUpByte) \
	(*(_objDataPtr(anOop, upByte) + (index) - 1) = aUpByte)

/* Put aUpInt at index (1-based) in the variable-ptr object anOop !! */
#define UPSmallIntegerAtPut(anOop, index, aUpInt) \
	(*(_objVarDataPtr(anOop) + (index) - 1) = _asSmallInt(aUpInt))

/* is this a Character? */
#define UPisCharacter(anOop) (_oopIsChar((anOop)))

/* is this a SmallInteger? */
#define UPisSmallInteger(anOop) (_oopIsInt((anOop)))

/* is this a ByteArray? */
#define UPisByteArray(anOop) (_oopClass((anOop)) == _sysOop(byteArrayClassX))

/* Is this a Boolean? */
#define UPisBoolean(anOop) \
	((anOop) == _sysOop(trueOopX) || (anOop) == _sysOop(falseOopX))

/* Is this a Float? */
#define UPisFloat(anOop) (_oopClass((anOop)) == _sysOop(floatClassX))

/* Is this a Double? */
#define UPisDouble(anOop) (_oopClass((anOop)) == _sysOop(doubleClassX))

/* Is this byte-like? */
#define UPisByteLike(anOop) (_isByteLike(anOop))

/* return oop from registry at index */
#define UPregisteredHandleAt(index) _sysOop(index)

/* Is this an immediate? */
#define UPisImmediate(anOop) _oopIsImm(anOop)

/* return the class of an object */
#define UPclass(anOop) _oopClass(anOop)

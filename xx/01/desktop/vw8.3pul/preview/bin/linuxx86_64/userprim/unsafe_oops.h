/************************************************************************
 *
 * Oop & object-memory access macros for the "unsafe"
 * VisualWorks(R) User-defined Primitives API
 *
 * ======================================================================
 * WARNING -- If you compile your code with -DUNSAFE you will get
 * an equivalent User Primitive support API which will run somewhat
 * faster but bugs in your code can crash the resulting OE (rather
 * than fail), and worse some bugs can silently corrupt the VI.  You
 * should test your code VERY carefully before compiling with
 * -DUNSAFE and using the resulting OE's on VI's you care about.
 * Finally, OEs built with -DUNSAFE and their derived VI's will not be
 * handled by Cincom Systems technical support.
 * ======================================================================
 * Specific VM implementation details exposed by this code does NOT
 * represent a supported VM interface and hence will change from
 * release to release, and have hidden dependencies and restrictions which
 * may render them useless outside this context.  In other words, pretend
 * that you can't read this file!  YOU HAVE BEEN WARNED!
 * ======================================================================
 *
 * Copyright (C) 1999-2016 Cincom Systems, Inc.  All rights reserved.
 *
 ************************************************************************/

/*
 * arithmetic right-shift operator macro
 * ...need to redefine it if your C compiler doesn't implement the ">>"
 * operator as an arithmetic shift when applied to a signed operand
 * (the shift is guaranteed to be logical if the operand is unsigned).
 */
#define _arithRShift(val, count) ((val) >> (count))

/*
 * Oop-oriented typedefs
 * assumes sizeof(long) is same as length of sizeof(struct foo *)
 */
/* From: bits32.h */
typedef long _oopInt;
typedef long _oopSized;
typedef unsigned long _oopUInt;
typedef struct _otEntryS *_oop;
/* From: oop.h */
#if HPS64
struct _otEntryS {
    char *data;
    _oopUInt flagWord;
};
#else
struct _otEntryS {
    char *data;
    _oop class;
    _oopUInt flagWord;
};
#endif

/*
 * macros for treatment of oops as bit-strings
 */
/* From: oop.h */
#if HPS64
# error "not yet copied from oop[N].h"
#else
# define _oopBits(ooop) ((_oopUInt)(ooop))
# define _oopNum(ooop) ((_oopInt)(ooop))
# define _numTagBits 2
# define _tagBitsMask 3
# define _immBitMask 1
# define _intBitMask 2
# define _charTag 1
# define _intTag 3
# define _hasPtrsBitMask (0x80000000)
# define _inRtBitMask (1<<28)
# define _firstSizeBit 16
# define _sizeBits 11
# define _numSizeValuesReserved 32
# define _sizeOvflVal ((1<<_sizeBits)-(_numSizeValuesReserved+1))
# define _sizeFieldMask (((1<<_sizeBits)-1)<<_firstSizeBit)
#endif

/*
 * Behavior format macros
 * Note that the masks apply to the oopIntVal of the format word.
 */
/* From: class.h */
#define _classFixedFieldsMask ((1 << 8) - 1)
#define _classIndexableMask (1 << 12)
#define _classHasPtrsMask (1 << 14)
struct _classS {
    _oop superclass;					/* Behavior */
	_oop mdict;							/* MethodDictionary */
	_oop format;						/* SmallInteger, instance format */
};

/*
 * system oop registry and indicies
 */
extern _oop *sysOopRegistry;
#define _minReservedIndicies 32

/* ------------------------------------------------ */
/* From oop32bitsBA.h */
#define _bytesToOops(size) ((size) >> 2)
/* From oop.h */
#define _oopIsImm(anOop) ((_oopBits(anOop) & _immBitMask) != 0)
#define _oopIsInt(anOop) ((_oopBits(anOop) & _intBitMask) != 0)
#define _asSmallInt(value) ((_oop)(((value) << _numTagBits) + _intTag))
#define _oopIntVal(anOop) _arithRShift(_oopNum(anOop), _numTagBits)
#define _oopIsChar(anOop) ((_oopBits(anOop) & _tagBitsMask) == _charTag)
#define _asChar(value) ((_oop)(((_oopUInt)(value) << _numTagBits) + _charTag))
#define _oopCharVal(anOop) (_oopBits(anOop) >> _numTagBits)

/* From: class.h */
#define _numFixedFields(anOop) \
	(_oopIntVal(_objDataPtr(_objClass(anOop), struct _classS)->format) & \
	 	_classFixedFieldsMask)

/* From: oop.h */
#define _objDataPtr(anOop, theType) ((theType *)((anOop)->data))
#define _objHasPtrs(anOop) ((anOop)->flagWord & _hasPtrsBitMask)

/* From: oop[N].h */
#if HPS32
# define _objSizeField(anOop) /* private macro */ \
	(((anOop)->flagWord & _sizeFieldMask) >> _firstSizeBit)
# define _objDataSize(anOop) \
	((_objSizeField(anOop) < _sizeOvflVal) \
		? _objSizeField(anOop) \
        : *(_objDataPtr(anOop, _oopUInt) - 1))
#else
# error "not yet copied from oop[N].h"
#endif
#define _objVarDataPtr(anOop) \
    (_objDataPtr(anOop, _oop) + _numFixedFields(anOop))
#define _objVarOopSize(anOop) \
    (_bytesToOops(_objDataSize(anOop)) - _numFixedFields(anOop))

extern _oop oldNewSpaceBoundary;
/* From: oop.h */
#define _objInRt(ooop) (((ooop)->flagWord & _inRtBitMask) != 0)
/* From: mm.h */
#define _objIsNew(ooop) ((ooop) < oldNewSpaceBoundary)
/* From: mm.h */
extern upBool registerInRt(_oop);
extern void chStOldObjInNonNew(_oop, _oopInt, _oop);
#define _checkStoreOop(target, offset, ooop) { \
	if(_objIsNew(target)) ; \
	else if(_oopIsImm(ooop)) ; \
	else if(_objIsNew(ooop)) { \
		if (_objInRt(target)) ; \
		else if (!registerInRt(target)) { \
			UPfail(UPEstoreFailure); \
	    	/* NOTREACHED */ \
		} \
	} \
	else chStOldObjInNonNew(target, offset, ooop); }

/* From: oop.h */
#define _objClass(anOop) ((anOop)->class)
/* From: oop.h */
#define _oopClass(ooop) \
 (!_oopIsImm(ooop) ? _objClass(ooop): \
  (_oopIsInt(ooop) ? _sysOop(smallIntegerClassX) : _sysOop(characterClassX)))
/* From: oop.h */
#define _isByteLike(anOop) (!_oopIsImm(anOop) && !_objHasPtrs(anOop))
/* From: sysOop.h */
#define _sysOop(index)	sysOopRegistry[index]

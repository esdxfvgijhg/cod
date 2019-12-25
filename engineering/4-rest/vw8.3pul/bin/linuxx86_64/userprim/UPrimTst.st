<?xml version="1.0"?>

<st-source>
<time-stamp>From VisualWorks®, Release 5i.4 of November 12, 2001 on January 18, 2002 at 12:16:19 am</time-stamp>

<do-it>ChangeSet current addPatch: 'UPrimTst-VW7'</do-it>

<class>
<name>UserPrimitiveTests</name>
<environment>Examples</environment>
<super>Examples.UserPrimitives</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>User Primitives</category>
</class>

<comment>
<class-id>Examples.UserPrimitiveTests</class-id>
<body>I am a class to test the user primitive support routines.  I can only
run my tests if the Virtual Machine includes all my User Primitives
defined for this purpose.

To run my tests, do:

	"UserPrimitiveTests new run"

and watch the Transcript.  If an error occurs a Notifier will appear.
	@(#)UPrimTst.st	63.13</body>
</comment>

<methods>
<class-id>Examples.UserPrimitiveTests</class-id> <category>top level</category>

<body>run
	"UserPrimitiveTests new run"

	Transcript cr; show: 'Starting user-primitive tests...'; cr.

	#(runtstUPbasicAt runtstUPbasicAtPut runtstUPbyteAt
	runtstUPbyteAtPut runtstUPcopyCtoSTfloatArray
	runtstUPcopyCtoSTIntArray runtstUPcopyCtoSTstring
	runtstUPcopySTtoCfloatArray runtstUPcopySTtoCintArray
	runtstUPcopySTtoCbytes runtstUPcopySTtoCstring runtstUPCtoSTbool
	runtstUPCtoSTchar runtstUPCtoSTfloat runtstUPCtoSTint runtstUPfloatAt
	runtstUPintegerAt runtstUPfloatAtPut runtstUPindexVarSize
	runtstUPinstVarAt runtstUPinstVarAtPut runtstUPinstVarSize
	runtstUPintegerAtPut runtstUPisArrayOfFloat runtstUPisArrayOfInteger
	runtstUPisBoolean runtstUPisImmediate runtstUPisByteArray
	runtstUPisCharacter runtstUPisFloat runtstUPisInteger runtstUPisString
	runtstUPisByteLike runtstUPnil runtstUPreturnFalse
	runtstUPreturnHandle runtstUPreturnNil runtstUPreturnTrue
	runtstUPSTtoCchar runtstUPSTtoCfloat runtstUPSTtoCint
	runtstUP32Arguments runtstUPerrorHandler runtstUPregHandleAt
	runtstUPregHandleAtPut runtstUPallocFs runtstUPallocVs
	runtstUPclassType runtstUPsignalSem runtstUPpostInt runtstUPisKindOf
	runtstUPisDouble runtstUPCtoSTdouble runtstUPSTtoCdouble runtstUPclass
	runtstUPSTtoCbool) do:
		[:msg |
		Transcript show: msg printString.
		self perform: msg.
		Transcript cr].
	Transcript show: '...tests completed'</body>

<body>testPerformance
	"UserPrimitiveTests new testPerformance"
	| ba a time1 time2 rpt |
	rpt := 25.
	ba := ByteArray new: 2000 withAll: 99.
	a := Array new: 2000 withAll: 100.
	time1 := time2 := 0.
	rpt timesRepeat: [
		time1 := time1 + (Time millisecondsToRun: [self sumByteArray: ba])].
	rpt timesRepeat: [
		time2 := time2 + (Time millisecondsToRun: [self zeroArray: a])].
	Transcript cr; print: (time1 / rpt roundTo: 0.1); nextPutAll: ' ms for summing a '.
	Transcript print: ba size; nextPutAll: '-element ByteArray.'.
	Transcript cr; print: (time2 / rpt roundTo: 0.1); nextPutAll: ' ms for zeroing a '.
	Transcript print: a size; nextPutAll: '-element Array.'.
	Transcript endEntry</body>
</methods>

<methods>
<class-id>Examples.UserPrimitiveTests</class-id> <category>individual tests</category>

<body>runtstUP32Arguments
	| result1 result2 error array |
	array := Array new: 33.
	1 to: 32 do: [:i | array at: i put: i].
	array at: 33 put: self.

	[result1 := self tstUP32Arguments: 01 a02: 02 a03: 03 a04: 04 a05: 05 a06: 06 a07: 07 a08: 08
										a09: 09 a10: 10 a11: 11 a12: 12 a13: 13 a14: 14 a15: 15 a16: 16
										a17: 17 a18: 18 a19: 19 a20: 20 a21: 21 a22: 22 a23: 23 a24: 24
										a25: 25 a26: 26 a27: 27 a28: 28 a29: 29 a30: 30 a31: 31 a32: 32]
		on: self class errorSignal
		do: [:ex| error := ex parameter].
	(result1 size = 33 and: [result1 = array and: [error == nil]])
		ifFalse: [self message: 'tstUP32Arguments one failed'].

	array at: 1 put: $a.

	[result2 := self tstUP32Arguments: $a a02: 02 a03: 03 a04: 04 a05: 05 a06: 06 a07: 07 a08: 08
										a09: 09 a10: 10 a11: 11 a12: 12 a13: 13 a14: 14 a15: 15 a16: 16
										a17: 17 a18: 18 a19: 19 a20: 20 a21: 21 a22: 22 a23: 23 a24: 24
										a25: 25 a26: 26 a27: 27 a28: 28 a29: 29 a30: 30 a31: 31 a32: 32]
		on: self class errorSignal
		do: [:ex| error := ex parameter].
	(result2 == nil and: [error = 1])
		ifFalse: [self message: 'tstUP32Arguments two failed']</body>

<body>runtstUPallocFs
	| result |
	result := self tstUPallocFs: Point.
	(result class == Point)
		ifFalse: [self message: 'runtstUPallocFs failed']</body>

<body>runtstUPallocVs
	| result |
	result := self tstUPallocVs: Array size: 10.
	(result class == Array and: [result size = 10])
		ifFalse: [self message: 'runtstUPallocVs failed']</body>

<body>runtstUPbasicAt
	| result |
	result := self tstUPbasicAt: #(1 20 3 ) with: 2.
	result == 20 ifFalse: [self message: 'tstUPbasicAt: anArray with: anIndex failed']</body>

<body>runtstUPbasicAtPut
	| result anArray |
	anArray := Array with: #foo with: #bar with: #who.
	result := self
				tstUPbasicAtPut: anArray
				with: 2
				with: #who.
	(result = #bar and: [anArray = #(foo who who )])
		ifFalse: [self message: 'tstUPbasicAtPut: anArray with: anIndex with: toBePut failed']</body>

<body>runtstUPbyteAt
	| result aByteArray |
	aByteArray := ByteArray new: 3.
	aByteArray at: 1 put: 8.
	aByteArray at: 2 put: 16.
	aByteArray at: 3 put: 24.
	result := self tstUPbyteAt: aByteArray with: 2.
	result == 16 ifFalse: [self message: 'tstUPbyteAt: aByteArray with: anIndex failed']</body>

<body>runtstUPbyteAtPut
	| result aByteArray |
	aByteArray := ByteArray new: 3.
	aByteArray at: 1 put: 8.
	aByteArray at: 2 put: 16.
	aByteArray at: 3 put: 24.
	result := self
				tstUPbyteAtPut: aByteArray
				with: 2
				with: 20.
	(result = 16 and: [(aByteArray at: 1)
			== 8 and: [(aByteArray at: 2)
				== 20 and: [(aByteArray at: 3)
					== 24]]])
		ifFalse: [self message: 'tstUPbyteAt: aByteArray with: anIndex failed']</body>

<body>runtstUPclass
	| result |
	result := self tstUPclass: 0@0.
	(result == Point)
		ifFalse: [self message: 'runtstUPclass failed']</body>

<body>runtstUPclassType
	| result1 result2 result3 |
	result1 := self tstUPclassType: 1.
	(result1 = 0)
		ifFalse: [self message: 'runtstUPclassType 1 failed'].
	result2 := self tstUPclassType: Object.
	(result2 = 1)
		ifFalse: [self message: 'runtstUPclassType 2 failed'].
	result3 := self tstUPclassType: Array.
	(result3 = 2)
		ifFalse: [self message: 'runtstUPclassType 3 failed']</body>

<body>runtstUPcopyCtoSTfloatArray
	"Test new runtstUPcopyCtoSTfloatArray"

	| result anArray |
	anArray := #(2.0 2.0 2.0 2.0 2.0 2.0 ) copy.
	result := self
				tstUPcopyCtoSTfloatArray: anArray
				with: 3
				with: 4.
	(result = 3 and: [anArray = #(2.0 2.0 2.0 -1.0 2.0 -3.0 )])
		ifFalse: [self message: 'tstUPcopyCtoSTfloatArray 1 failed'].
	anArray := #(2.0 2.0 2.0 2.0 2.0 2.0 ) copy.
	result := self
				tstUPcopyCtoSTfloatArray: anArray
				with: 3
				with: 1.
	(result = 3 and: [anArray = #(-1.0 2.0 -3.0 2.0 2.0 2.0 )])
		ifFalse: [self message: 'tstUPcopyCtoSTfloatArray 2 failed'].
	anArray := #(2.0 2.0 2.0 2.0 2.0 2.0 ) copy.
	result := self
				tstUPcopyCtoSTfloatArray: anArray
				with: 1
				with: 6.
	(result = 1 and: [anArray = #(2.0 2.0 2.0 2.0 2.0 -1.0 )])
		ifFalse: [self message: 'tstUPcopyCtoSTfloatArray 3 failed']</body>

<body>runtstUPcopyCtoSTIntArray
	"Test new runtstUPcopyCtoSTIntArray"

	| result anArray |
	anArray := #(2 2 2 2 2 2 ) copy.
	result := self tstUPcopyCtoSTIntArray: anArray with: 3 with: 4.
	(result = 3 and: [anArray = #(2 2 2 1 2 3 )])
		 ifFalse: [self message: 'tstUPcopyCtoSTIntArray 1 failed'].
	anArray := #(2 2 2 2 2 2 ) copy.
	result := self tstUPcopyCtoSTIntArray: anArray with: 3 with: 1.
	(result = 3 and: [anArray = #(1 2 3 2 2 2)])
		 ifFalse: [self message: 'tstUPcopyCtoSTIntArray 2 failed'].
	anArray := #(2 2 2 2 2 2 ) copy.
	result := self tstUPcopyCtoSTIntArray: anArray with: 1 with: 6.
	(result = 1 and: [anArray = #(2 2 2 2 2 1)])
		 ifFalse: [self message: 'tstUPcopyCtoSTIntArray 3 failed'].</body>

<body>runtstUPcopyCtoSTstring
	| result anArray |
	anArray := 'bbbbbb' copy.
	result := self tstUPcopyCtoSTstring: anArray with: 3 with: 4.
	(result = 3 and: [anArray = 'bbbabc'])
		 ifFalse: [self message: 'tstUPcopyCtoSTstring 1 failed'].
	anArray := 'bbbbbb' copy.
	result := self tstUPcopyCtoSTstring: anArray with: 3 with: 1.
	(result = 3 and: [anArray = 'abcbbb'])
		 ifFalse: [self message: 'tstUPcopyCtoSTstring 2 failed'].
	anArray := 'bbbbbb' copy.
	result := self tstUPcopyCtoSTstring: anArray with: 1 with: 6.
	(result = 1 and: [anArray = 'bbbbba'])
		 ifFalse: [self message: 'tstUPcopyCtoSTstring 3 failed']</body>

<body>runtstUPcopySTtoCbytes
	| result proto |
	proto := ByteArray with: 1 with: 2 with: 3.
	result := self tstUPcopySTtoCbytes: proto with: 3 with: 4.
	result = #[2 2 2 1 2 3]
		 ifFalse: [self message: 'tstUPcopySTtoCbytes 1 failed'].
	result := self tstUPcopySTtoCbytes: proto with: 3 with: 1.
	result = #[1 2 3 2 2 2]
		 ifFalse: [self message: 'tstUPcopySTtoCbytes 2 failed'].
	result := self tstUPcopySTtoCbytes: proto with: 1 with: 6.
	result = #[2 2 2 2 2 1]
		 ifFalse: [self message: 'tstUPcopySTtoCbytes 3 failed']</body>

<body>runtstUPcopySTtoCfloatArray
	"Test new runtstUPcopySTtoCfloatArray"
	| result proto |
	proto := Array with: 1.0 with: 2.0 with: 3.0.
	result := self tstUPcopySTtoCfloatArray: proto with: 3 with: 4.
	result asArray = #(2.0 2.0 2.0 1.0 2.0 3.0 )
		 ifFalse: [self message: 'tstUPcopySTtoCfloatArray 1 failed'].

	result := self tstUPcopySTtoCfloatArray: proto with: 3 with: 1.
	result asArray = #(1.0 2.0 3.0 2.0 2.0 2.0 )
		 ifFalse: [self message: 'tstUPcopySTtoCfloatArray 2 failed'].

	result := self tstUPcopySTtoCfloatArray: proto with: 1 with: 6.
	result asArray = #(2.0 2.0 2.0 2.0 2.0 1.0 )
		 ifFalse: [self message: 'tstUPcopySTtoCfloatArray 3 failed']</body>

<body>runtstUPcopySTtoCintArray
	| result proto |
	proto := Array with: 1 with: 2 with: 3.
	result := self tstUPcopySTtoCintArray: proto with: 3 with: 4.
	result asArray = #(2 2 2 1 2 3 )
		 ifFalse: [self message: 'tstUPcopySTtoCintArray 1 failed'].
	result := self tstUPcopySTtoCintArray: proto with: 3 with: 1.
	result asArray = #(1 2 3 2 2 2 )
		 ifFalse: [self message: 'tstUPcopySTtoCintArray 2 failed'].
	result := self tstUPcopySTtoCintArray: proto with: 1 with: 6.
	result asArray = #(2 2 2 2 2 1 )
		 ifFalse: [self message: 'tstUPcopySTtoCintArray 3 failed']</body>

<body>runtstUPcopySTtoCstring
	| result |
	result := self tstUPcopySTtoCstring: 'abc' with: 3 with: 4.
	result = 'bbbabc'
		 ifFalse: [self message: 'tstUPcopySTtoCstring 1 failed'].
	result := self tstUPcopySTtoCstring: 'abc' with: 3 with: 1.
	result = 'abcbbb'
		 ifFalse: [self message: 'tstUPcopySTtoCstring 2 failed'].
	result := self tstUPcopySTtoCstring: 'abc' with: 1 with: 6.
	result = 'bbbbba'
		 ifFalse: [self message: 'tstUPcopySTtoCstring 3 failed']</body>

<body>runtstUPCtoSTbool
	| result |
	result := self tstUPCtoSTbool.
	result ifFalse: [self message: 'tstUPCtoSTbool failed']</body>

<body>runtstUPCtoSTchar
	| result |
	result := self tstUPCtoSTchar.
	result == $c ifFalse: [self message: 'tstUPCtoSTchar  failed']</body>

<body>runtstUPCtoSTdouble
	| result |
	result := self tstUPCtoSTdouble.
	(result class = Double and: [result asFloat = 3.14])
		ifFalse: [self message: 'runtstUPCtoSTdouble failed']</body>

<body>runtstUPCtoSTfloat
	| result |
	result := self tstUPCtoSTfloat.
	result = 3.14 ifFalse: [self message: 'tstUPCtoSTfloat  failed']</body>

<body>runtstUPCtoSTint
	| result |
	result := self tstUPCtoSTint.
	result == 42 ifFalse: [self message: 'tstUPCtoSTint  failed']</body>

<body>runtstUPerrorHandler
	| result |
	result := self tstUPerrorHandler.
	result ~= 100 ifTrue: [self message: 'tstUPerrorHandler failed']</body>

<body>runtstUPfloatAt
	| result |
	result := self tstUPfloatAt: #(1.0 2.0 3.0 ) with: 3.
	result = 3.0
		 ifFalse: [self message: 'tstUPfloatAt: anArray with: anIndex failed']</body>

<body>runtstUPfloatAtPut
	| result aFloatArray |
	aFloatArray := Array with: 8.0 with: 16.0 with: 24.0 .
	result := self tstUPfloatAtPut: aFloatArray with: 2 with: 20.0 .
	(result = 16.0
		 and: [(aFloatArray at: 1) = 8.0
		 and: [(aFloatArray at: 2) = 20.0
		 and: [(aFloatArray at: 3) = 24.0]]])
			ifFalse: [self message: 'tstUPfloatAtPut: aFloatArray with: anIndex failed']</body>

<body>runtstUPindexVarSize
	| result |
	result := self tstUPindexVarSize: self.
	result == self size
		 ifFalse: [self message: 'tstUPindexVarSize: anyObjectWithIndexVars failed 0'].
	result := self tstUPindexVarSize: #(enie meenie meenie moe ).
	result == 4
		 ifFalse: [self message: 'tstUPindexVarSize: anyObjectWithIndexVars failed 1'].
	result := self tstUPindexVarSize: (Array new: 5000).
	result == 5000
		 ifFalse: [self message: 'tstUPindexVarSize: anyObjectWithIndexVars failed 2']</body>

<body>runtstUPinstVarAt
	| result anAssoc |
	anAssoc := Association key: #foo value: #bar.
	result := self tstUPinstVarAt: anAssoc with: 1.
	result == #foo
		 ifFalse: [self message: 'tstUPinstVarAt: anArray with: anIndex 1 failed'].
	result := self tstUPinstVarAt: anAssoc with: 2.
	result == #bar
		 ifFalse: [self message: 'tstUPinstVarAt: anArray with: anIndex 2 failed']</body>

<body>runtstUPinstVarAtPut
	| result anAssoc |
	anAssoc := Association key: #foo value: #bar.
	result := self tstUPinstVarAtPut: anAssoc with: 2 with: #foo.
	(result == #bar
		 and: [anAssoc key == #foo
		 and: [anAssoc value == #foo]])
			ifFalse: [self message: 'tstUPinstVarAtPut: anArray with: anIndex failed']</body>

<body>runtstUPinstVarSize
	| result |
	result := self tstUPinstVarSize: self.
	result == 0
		 ifFalse: [self message: 'tstUPinstVarSize: anyObjectWithInstVars 1 failed'].
	result := self tstUPinstVarSize: (Array new: 3).
	result == 0
		 ifFalse: [self message: 'tstUPinstVarSize: anyObjectWithInstVars 2 failed'].
	result := self tstUPinstVarSize: Association new.
	result == 2
		 ifFalse: [self message: 'tstUPinstVarSize: anyObjectWithInstVars 3 failed']</body>

<body>runtstUPintegerAt
	| result |
	result := self tstUPintegerAt: #(1 2 3) with: 3.
	result = 3
		 ifFalse: [self message: 'tstUPintegerAt failed']</body>

<body>runtstUPintegerAtPut
	| result anArray |
	anArray := Array new: 3.
	result := self tstUPintegerAtPut: anArray with: 2 with: 8.
	(result = nil and: [anArray = (Array with: nil with: 8 with: nil)])
		 ifFalse: [self message: 'tstUPintegerAtPut: anArray with: anIndex with: toBePut failed']</body>

<body>runtstUPisArrayOfFloat
	| result |
	result := self tstUPisArrayOfFloat: (Array with: 1.0 with: 2.0 with: 3.0).
	result
		 ifFalse: [self message: 'tstUPisArrayOfFloat: anArrayOfFloat failed 1'].
	result := self tstUPisArrayOfFloat:  (Array with: 1  with: 2  with: 3).
	result
		 ifTrue: [self message: 'tstUPisArrayOfFloat: anArrayOfFloat failed 2'].
	result := self tstUPisArrayOfFloat: (Array with: 1.0 with: 2.0 with: 3).
	result
		 ifTrue: [self message: 'tstUPisArrayOfFloat: anArrayOfFloat failed 3']</body>

<body>runtstUPisArrayOfInteger
	| result |
	result := self tstUPisArrayOfInteger: #(1 2 3 4 5 ).
	result
		 ifFalse: [self message: 'tstUPisArrayOfInteger: anArrayOfInteger 1 failed'].
	result := self tstUPisArrayOfInteger: #(1 f2 f3 f4 f5 ).
	result
		 ifTrue: [self message: 'tstUPisArrayOfInteger: anArrayOfInteger 2 failed']</body>

<body>runtstUPisBoolean
	| result |
	result := self tstUPisBoolean: true.
	result
		 ifFalse: [self message: 'tstUPisBoolean: aBoolean failed 1'].
	result := self tstUPisBoolean: false.
	result
		 ifFalse: [self message: 'tstUPisBoolean: aBoolean failed 2'].
	result := self tstUPisBoolean: 7.
	result
		 ifTrue: [self message: 'tstUPisBoolean: aBoolean failed 3']</body>

<body>runtstUPisByteArray
	| result |
	result := self tstUPisByteArray:
		 (ByteArray with: 2 with: 3).
	result ifFalse: [self message: 'tstUPisByteArray: aByteArray failed']</body>

<body>runtstUPisByteLike

	| result |
	result := self tstUPisByteLike: (ByteArray new: 2).
	result ifFalse: [self message: 'tstUPisByteLike 1 failed'].
	result := self tstUPisByteLike: (UninterpretedBytes new: 2).
	result ifFalse: [self message: 'tstUPisByteLike 2 failed'].
	result := self tstUPisByteLike: (Array new: 2).
	result ifTrue: [self message: 'tstUPisByteLike 3 failed']</body>

<body>runtstUPisCharacter
	| result |
	result := self tstUPisCharacter: $h.
	result ifFalse: [self message: 'tstUPisCharacter: aCharacter failed']</body>

<body>runtstUPisDouble
	| result1 result2 |
	result1 := self tstUPisDouble: 0.0 asDouble.
	(result1) ifFalse: [self message: 'runtstUPisDouble 1 failed'].
	result2 := self tstUPisDouble: 0.0.
	(result2) ifTrue: [self message: 'runtstUPisDouble 2 failed']</body>

<body>runtstUPisFloat
	| result |
	result := self tstUPisFloat: 3.14.
	result
		 ifFalse: [self message: 'tstUPisFloat: aFloat failed 1'].
	result := self tstUPisFloat: 3.
	result
		 ifTrue: [self message: 'tstUPisFloat: aFloat failed 2']</body>

<body>runtstUPisImmediate
	| result |
	result := self tstUPisImmediate: 1.
	result
		 ifFalse: [self message: 'tstUPisImmediate failed 1'].
	result := self tstUPisImmediate: $a.
	result
		 ifFalse: [self message: 'tstUPisImmediate failed 2'].
	result := self tstUPisImmediate: Object new.
	result
		 ifTrue: [self message: 'tstUPisImmediate failed 3']</body>

<body>runtstUPisInteger
	| result |
	result := self tstUPisInteger: 2.
	result ifFalse: [self message: 'tstUPisInteger: aInteger failed']</body>

<body>runtstUPisKindOf
	| result |
	result := self tstUPisKindOf: 0@0 with: Point.
	(result) ifFalse: [self message: 'runtstUPisKindOf failed']</body>

<body>runtstUPisString
	| result |
	result := self tstUPisString: 'aString'.
	result ifFalse: [self message: 'tstUPisString: aString failed']</body>

<body>runtstUPnil
	| result |
	result := self tstUPnil.
	result == nil ifFalse: [self message: 'tstUPnil  failed']</body>

<body>runtstUPpostInt
	| sem |
	sem := Semaphore new.
	self tstUPpostInt: sem.
	Processor yield.	"let break-out occur"
	(sem instVarAt: 3) = 1
		ifFalse: [self message: 'runtstUPpostInt failed']</body>

<body>runtstUPregHandleAt
	| result |
	result := self tstUPregHandleAt: 1.
	result ifFalse: [self message: 'runtstUPregHandleAt failed']</body>

<body>runtstUPregHandleAtPut
	| result slot thing |
	thing := Object new.
	slot := self tstUPallocRegSlot.
	slot &lt; 30 ifTrue: [self message: 'tstUPallocRegSlot failed'].
	result := self tstUPregHandleAt: slot put: thing.
	(result == thing)
		ifFalse: [self message: 'runtstUPregHandleAt failed']</body>

<body>runtstUPreturnFalse
	| result |
	result := self tstUPreturnFalse.
	result ifTrue: [self message: 'tstUPreturnFalse  failed']</body>

<body>runtstUPreturnHandle
	| result |
	result := self tstUPreturnHandle: self.
	result == self ifFalse: [self message: 'tstUPreturnHandle  failed']</body>

<body>runtstUPreturnNil
	| result |
	result := self tstUPreturnNil.
	result == nil ifFalse: [self message: 'tstUPreturnNil  failed']</body>

<body>runtstUPreturnTrue
	| result |
	result := self tstUPreturnTrue.
	result ifFalse: [self message: 'tstUPreturnTrue  failed']</body>

<body>runtstUPsignalSem
	| sem |
	sem := Semaphore new.
	self tstUPsignalSem: sem.
	(sem instVarAt: 3) = 1
		ifFalse: [self message: 'runtstUPsignalSem failed']</body>

<body>runtstUPSTtoCbool
	| result |
	result := self tstUPSTtoCbool: true.
	result ifFalse: [self message: 'tstUPSTtoCbool 1 failed'].
	result := self tstUPSTtoCbool: false.
	result ifTrue: [self message: 'tstUPSTtoCbool 2 failed']</body>

<body>runtstUPSTtoCchar
	| result |
	result := self tstUPSTtoCchar: $h.
	result == $h ifFalse: [self message: 'tstUPSTtoCchar: aChar failed']</body>

<body>runtstUPSTtoCdouble
	| result |
	result := self tstUPSTtoCdouble: 99.0 asDouble.
	(result class = Double and: [result = 99.0])
		ifFalse: [self message: 'runtstUPSTtoCdouble failed']</body>

<body>runtstUPSTtoCfloat
	| result |
	result := self tstUPSTtoCfloat: 3.14.
	result = 3.14 ifFalse: [self message: 'tstUPSTtoCfloat: aFloat failed']</body>

<body>runtstUPSTtoCint
	| result |
	result := self tstUPSTtoCint: 2.
	result == 2 ifFalse: [self message: 'tstUPSTtoCint: aInt failed']</body>
</methods>

<methods>
<class-id>Examples.UserPrimitiveTests</class-id> <category>test primitives-performance</category>

<body>sumByteArray: ba

	&lt;primitive: 10100 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>zeroArray: a

	&lt;primitive: 10101 errorCode: errorCode&gt;
	^self reportError: errorCode</body>
</methods>

<methods>
<class-id>Examples.UserPrimitiveTests</class-id> <category>test primitives</category>

<body>tstUP32Arguments: a01 a02: a02 a03: a03 a04: a04 a05: a05 a06: a06 a07: a07 a08: a08 a09: a09 a10: a10 a11: a11 a12: a12 a13: a13 a14: a14 a15: a15 a16: a16 a17: a17 a18: a18 a19: a19 a20: a20 a21: a21 a22: a22 a23: a23 a24: a24 a25: a25 a26: a26 a27: a27 a28: a28 a29: a29 a30: a30 a31: a31 a32: a32
	&lt;primitive: 10052 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPallocFs: cls
	&lt;primitive: 10057 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPallocRegSlot
	&lt;primitive: 10056 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPallocVs: cls size: sz
	&lt;primitive: 10058 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPbasicAt: anArray with: anIndex
	&lt;primitive: 10016 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPbasicAtPut: anArray with: anIndex with: toBePut
	&lt;primitive: 10017 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPbyteAt: anArray with: anIndex
	&lt;primitive: 10018 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPbyteAtPut: anArray with: anIndex with: toBePut
	&lt;primitive: 10019 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPclass: obj
	&lt;primitive: 10066 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPclassType: cls
	&lt;primitive: 10059 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPcopyCtoSTbytes: anArray with: aCount with: aStartIndex
	&lt;primitive: 10021 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPcopyCtoSTfloatArray: anArray with: aCount with: aStartIndex
	&lt;primitive: 10022 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPcopyCtoSTIntArray: anArray with: aCount with: aStartIndex
	&lt;primitive: 10020 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPcopyCtoSTstring: anArray with: aCount with: aStartIndex
	&lt;primitive: 10023 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPcopySTtoCbytes: anArray with: aCount with: aStartIndex
	&lt;primitive: 10024 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPcopySTtoCfloatArray: anArray with: aCount with: aStartIndex
	&lt;primitive: 10025 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPcopySTtoCintArray: anArray with: aCount with: aStartIndex
	&lt;primitive: 10026 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPcopySTtoCstring: anArray with: aCount with: aStartIndex
	&lt;primitive: 10027 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPCtoSTbool
	&lt;primitive: 10001 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPCtoSTchar
	&lt;primitive: 10002 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPCtoSTdouble
	&lt;primitive: 10064 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPCtoSTfloat
	&lt;primitive: 10003 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPCtoSTint
	&lt;primitive: 10004 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPerrorHandler
	&lt;primitive: 10050 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPfloatAt: anArray with: anIndex
	&lt;primitive: 10030 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPfloatAtPut: anArray with: anIndex
	&lt;primitive: 10031 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPfloatAtPut: anArray with: anIndex with: aFloat
	&lt;primitive: 10031 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPindexVarSize: anyObjectWithIndexVars
	&lt;primitive: 10032 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPinstVarAt: anArray with: anIndex
	&lt;primitive: 10033 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPinstVarAtPut: anArray with: anIndex with: toBePut
	&lt;primitive: 10034 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPinstVarSize: anyObjectWithInstVars
	&lt;primitive: 10035 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPintegerAt: anArray with: anIndex
	&lt;primitive: 10053 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPintegerAtPut: anArray with: anIndex with: toBePut
	&lt;primitive: 10036 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPisArrayOfFloat: anArrayOfFloat
	&lt;primitive: 10037 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPisArrayOfInteger: anArrayOfInteger
	&lt;primitive: 10038 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPisBoolean: aBoolean
	&lt;primitive: 10039 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPisByteArray: aByteArray
	&lt;primitive: 10040 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPisByteLike: obj
	&lt;primitive: 10051 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPisCharacter: aCharacter
	&lt;primitive: 10041 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPisDouble: dbl
	&lt;primitive: 10063 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPisFloat: aFloat
	&lt;primitive: 10042 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPisImmediate: anObject
	&lt;primitive: 10067 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPisInteger: aInteger
	&lt;primitive: 10043 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPisKindOf: inst with: cls
	&lt;primitive: 10062 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPisString: aString
	&lt;primitive: 10044 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPnil
	&lt;primitive: 10045 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPpostInt: sem
	&lt;primitive: 10061 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPregHandleAt: index
	&lt;primitive: 10054 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPregHandleAt: index put: value
	&lt;primitive: 10055 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPreturnFalse
	&lt;primitive: 10046 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPreturnHandle: aHandle
	&lt;primitive: 10047 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPreturnNil
	&lt;primitive: 10048 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPreturnTrue
	&lt;primitive: 10049 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPsignalSem: sem
	&lt;primitive: 10060 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPSTtoCbool: bool
	&lt;primitive: 10005 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPSTtoCchar: aChar
	&lt;primitive: 10006 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPSTtoCdouble: dbl
	&lt;primitive: 10065 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPSTtoCfloat: aFloat
	&lt;primitive: 10007 errorCode: errorCode&gt;
	^self reportError: errorCode</body>

<body>tstUPSTtoCint: aInt
	&lt;primitive: 10008 errorCode: errorCode&gt;
	^self reportError: errorCode</body>
</methods>

<methods>
<class-id>Examples.UserPrimitiveTests</class-id> <category>private</category>

<body>message: aString
	Transcript show: ' -- ', aString.
	^self error: aString printString</body>

<body>reportError: errorCode
	^self class raiseError: errorCode</body>
</methods>



</st-source>

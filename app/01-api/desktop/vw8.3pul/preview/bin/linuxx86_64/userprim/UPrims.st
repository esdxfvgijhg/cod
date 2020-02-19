<?xml version="1.0"?>

<st-source>
<time-stamp>From VisualWorks®, Release 5i.4 of November 12, 2001 on January 17, 2002 at 11:58:45 pm</time-stamp>

<do-it>ChangeSet current addPatch: 'UPrims-VW7'</do-it>

<class>
<name>UserPrimitives</name>
<environment>Examples</environment>
<super>Core.Object</super>
<private>false</private>
<indexed-type>none</indexed-type>
<inst-vars></inst-vars>
<class-inst-vars></class-inst-vars>
<imports></imports>
<category>User Primitives</category>
</class>

<shared-variable>
<name>UPErrorSignal</name>
<environment>Examples.UserPrimitives</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
</shared-variable>

<shared-variable>
<name>FailCodes</name>
<environment>Examples.UserPrimitives</environment>
<private>false</private>
<constant>false</constant>
<category>As yet unclassified</category>
</shared-variable>

<!-- -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -   -->


<methods>
<class-id>Examples.UserPrimitives class</class-id> <category>class initialization</category>

<body>initFailCodes

	FailCodes := IdentityDictionary new: 20.

	FailCodes at: 0 put: 'failure code lost'.
	FailCodes at: -1 put: 'C argument out of range'.
	FailCodes at: -2 put: 'Smalltalk argument out of range'.
	FailCodes at: -3 put: 'argument not an object'.
	FailCodes at: -4 put: 'object incorrect type'.
	FailCodes at: -5 put: 'declared arg wrong type'.
	FailCodes at: -6 put: 'C int was not a SmallInteger'.
	FailCodes at: -7 put: 'C data structure too small'.
	FailCodes at: -8 put: 'Smalltalk datum too small to be represented in C'.
	FailCodes at: -9 put: 'Smalltalk datum too big to be represented in C'.
	FailCodes at: -10 put: 'Smalltalk object memory allocation failed'.
	FailCodes at: -11 put: 'arg count mismatch'.
	FailCodes at: -12 put: 'user primitive is not installed'.
	FailCodes at: -13 put: 'too many arguments'.
	FailCodes at: -14 put: 'no value returned'.
	FailCodes at: -15 put: 'assertion failure'</body>

<body>initialize
	"UserPrimitives initialize"

	UPErrorSignal := (Object errorSignal newSignalMayProceed: true)
			notifierString: 'User-defined primitive Error';
			nameClass: self message: #errorSignal.
	self initFailCodes</body>
</methods>

<methods>
<class-id>Examples.UserPrimitives class</class-id> <category>error reporting</category>

<body>errorStringFor: code
	"Answer a string describing the error code."

	^FailCodes at: code ifAbsent: ['error code ', code printString]</body>

<body>raiseError: anErrorCode
	"Raise a signal, with the failure code as an argument."

	^self
		errorSignal raiseRequestWith: anErrorCode
		errorString: (self errorStringFor: anErrorCode)</body>
</methods>

<methods>
<class-id>Examples.UserPrimitives class</class-id> <category>class accessing</category>

<body>errorSignal
	"Return the standard error signal for user-defined primitive errors."

	^UPErrorSignal</body>
</methods>

<!-- -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -   -->


<comment>
<class-id>Examples.UserPrimitives</class-id>
<body>I am a place to hang behavior for user-defined primitives.

My metaclass has protocol for interpreting error codes.

Class Variables:
	FailCodes		&lt;IdentityDictionary&gt;
						Maps standard failure codes to strings.
	UPErrorSignal	&lt;Signal&gt;
						Standard exception signal for user-defined primitive errors.

	@(#)UPrims.st	63.13</body>
</comment>


<initialize>
<class-id>Examples.UserPrimitives</class-id>
</initialize>


</st-source>

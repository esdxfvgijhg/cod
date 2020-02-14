<?xml version="1.0"?>

<st-source>
<!-- Changes in change set Setting-up DDE Filetype associations -->
<!-- "Code to set-up the .chb association:  Simplify and generalize:

OSSystemSupport concreteClass new
	setVariableWithPath: #('.chb')
	key: 0
	value: 'CHBfile'
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #('.chb')
	key: 'Content Type'
	value: 'text/plain'
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #('CHBfile')
	key: 0
	value: 'Smalltalk Changes File Backup'
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #('CHBfile')
	key: 'EditFlags'
	value: #[0 0 0 0]
	type: #REG_BINARY
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #('CHBfile' 'Shell' 'open')
	key: 'EditFlags'
	value: #[1 0 0 0]
	type: #REG_BINARY
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #('CHBfile' 'Shell')
	key: 0
	value: ''
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #('CHBfile' 'Shell' 'open' 'command')
	key: 0
	value: 'c:\dde\vw5i.exe -nologo c:\dde\dde5i.im %1'
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #('CHBfile' 'Shell' 'open' 'ddeexec')
	key: 0
	value: '%1'
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #('CHBfile' 'Shell' 'open' 'ddeexec' 'Application')
	key: 0
	value: 'VisualWorks'
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #('CHBfile' 'Shell' 'open' 'ddeexec' 'ifexec')
	key: 0
	value: '%1'
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #('CHBfile' 'Shell' 'open' 'ddeexec' 'topic')
	key: 0
	value: 'changelist'
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
" -->
<time-stamp>From VisualWorks®, Release 5i.1 Beta of October 8, 1999 on October 21, 1999 at 7:23:06 pm</time-stamp>


<methods>
<class-id>OS.Win95SystemSupport</class-id> <category>accessing</category>

<body><B>getVariableWithPath: path name: parameterName ifAbsent: errorBlock 
	</B>"Answer the value of the named parameter under top-level key 
	HKEY_LOCAL_MACHINE, which must be a string, binary data or 
	a long. If not present, answer the result of evaluating errorBlock."

	^self
		getVariableWithPath: path
		name: parameterName
		ifAbsent: errorBlock
		hkey: self HKEY_LOCAL_MACHINE</body>

<body><B>getVariableWithPath: path name: parameterName ifAbsent: errorBlock hkey: hkey
	</B>"Answer the value of the named parameter, which must be a string, binary data or a long. 
	If not present, answer the result of evaluating errorBlock."

	| voidPointerType key buffer bufferSize count type errorCode |
	buffer := CIntegerType char newInFixedSpace: (bufferSize := 256).
	count := CIntegerType long newInFixedSpace.
	type := CIntegerType unsignedLong newInFixedSpace.
	key := (voidPointerType := CVoidType void pointerType) newInFixedSpace.
	key contents: (voidPointerType cast: (hkey isInteger ifTrue: [hkey] ifFalse: [self perform: hkey])).
	path
		do: 
			[:subKey | 
			errorCode := self
						RegOpenKey: key contents
						subKey: subKey
						result: key.
			errorCode = self ERROR_SUCCESS ifFalse: [^errorBlock value]].
	count contents: bufferSize.
	errorCode := self
				RegQueryValueEx: key contents
				name: parameterName
				reserved: nil
				type: type
				data: buffer
				size: count.
	errorCode = self ERROR_SUCCESS ifFalse: [^errorBlock value].

	(type contents = self REG_EXPAND_SZ or: [type contents = self REG_SZ]) ifTrue:
		[^buffer copyCStringFromHeap].

	type contents = self REG_DWORD ifTrue:
		[^buffer datum longAt: 1].

	type contents = self REG_BINARY ifTrue:
		[^buffer datum asByteArray copyFrom: 1 to: count contents].

	^errorBlock value</body>

<body><B>setVariableWithPath: path key: subkey value: value </B>
	"Set the value of the named parameter, which must be a string"

	^self
		setVariableWithPath: path
		key: subkey
		value: value
		type: self REG_SZ
		hkey: self HKEY_LOCAL_MACHINE</body>

<body><B>setVariableWithPath: path key: subkey value: value type: type hkey: hkey 
	</B>"Set the value of the named parameter, which must be a string 
	(REG_SZ), binary data (REG_BINARY) or a long 
	(REG_DWORD)."

	| key newKey errorCode voidPointerType |
	key := (voidPointerType := CVoidType void pointerType) newInFixedSpace.
	key contents: (voidPointerType cast: (hkey isInteger
											ifTrue: [hkey]
											ifFalse: [self perform: hkey])).
	newKey := self createPath: path in: key contents.
	newKey == nil ifTrue: [^false].
	errorCode := self
					RegSetValueEx: newKey contents asInteger
					name: subkey
					reserved: 0
					type: (type isInteger
							ifTrue: [type]
							ifFalse: [self perform: type])
					data: value
					size: value size.
	^errorCode = self ERROR_SUCCESS</body>
</methods>

<methods>
<class-id>OS.Win95SystemSupport</class-id> <category>constants</category>

<body><B>REG_BINARY
	</B>^3</body>

<body><B>REG_DWORD
	</B>^4</body>
</methods>

<methods>
<class-id>OS.Win95SystemSupport</class-id> <category>private- accessing</category>

<body><B>keyFromPath: path
	</B>"Answer the key of the named parameter, which must be a string. "
	"(subkey of HKEY_LOCAK_MACHINE). Caller must free result."

	^self <B>keyFromPath: path</B> hkey: self HKEY_LOCAL_MACHINE</body>

<body><B>keyFromPath: path hkey: hkey
	</B>"Answer the key of the named parameter, which must be a string. "

	| storedKey initialKey key  errorCode |

	[ [ storedKey := CVoidType void pointerType malloc.
	initialKey := CVoidType void pointerType malloc.
	initialKey contents: (CVoidType void pointerType cast: (hkey isInteger ifTrue: [hkey] ifFalse: [self perform: hkey])).
	key := initialKey.
	path do:
		[ :subKey |
		errorCode := self RegOpenKey: key contents subKey: subKey result: storedKey.
		errorCode = self ERROR_SUCCESS ifFalse: [ ^nil ].
		key := storedKey
		]
	] ensure: [ initialKey notNil ifTrue: [ initialKey freePointer ] ]
	] ifCurtailed: [ storedKey notNil ifTrue: [ storedKey freePointer ]. nil ].

	^key</body>
</methods>



<do-it>(ChangeSet current respondsTo: #comment:) ifTrue:
	[ChangeSet current comment: '"Code to set-up the .chb association:  Simplify and generalize:

OSSystemSupport concreteClass new
	setVariableWithPath: #(''.chb'')
	key: 0
	value: ''CHBfile''
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #(''.chb'')
	key: ''Content Type''
	value: ''text/plain''
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #(''CHBfile'')
	key: 0
	value: ''Smalltalk Changes File Backup''
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #(''CHBfile'')
	key: ''EditFlags''
	value: #[0 0 0 0]
	type: #REG_BINARY
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #(''CHBfile'' ''Shell'' ''open'')
	key: ''EditFlags''
	value: #[1 0 0 0]
	type: #REG_BINARY
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #(''CHBfile'' ''Shell'')
	key: 0
	value: ''''
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #(''CHBfile'' ''Shell'' ''open'' ''command'')
	key: 0
	value: ''c:\dde\vw5i.exe -nologo c:\dde\dde5i.im %1''
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #(''CHBfile'' ''Shell'' ''open'' ''ddeexec'')
	key: 0
	value: ''%1''
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #(''CHBfile'' ''Shell'' ''open'' ''ddeexec'' ''Application'')
	key: 0
	value: ''VisualWorks''
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #(''CHBfile'' ''Shell'' ''open'' ''ddeexec'' ''ifexec'')
	key: 0
	value: ''%1''
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
OSSystemSupport concreteClass new
	setVariableWithPath: #(''CHBfile'' ''Shell'' ''open'' ''ddeexec'' ''topic'')
	key: 0
	value: ''changelist''
	type: #REG_SZ
	hkey: #HKEY_CLASSES_ROOT.
"']</do-it>

</st-source>

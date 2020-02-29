"Changes in change set SqueakCompat"!
'From VisualWorks® NonCommercial, Release 7 of January 27, 2003 on February 6, 2003 at 8:40:13 am'!


!Core.Object methodsFor: 'debugging'!

flag: aSymbol
	"Send this message, with a relevant symbol as argument, 
	to flag a message for subsequent retrieval. 
	For example, you might put the following line in a number of messages:
		self flag: #returnHereUrgently
	Then, to retrieve all such messages, browse all senders of #returnHereUrgently."! !


!Core.Behavior methodsFor: 'accessing class hierarchy'!

withAllSubclassesDo: aBlock
	"Evaluate the argument, aBlock, for the receiver and each of its subclasses."

	aBlock value: self.
	self allSubclassesDo: aBlock.! !


!Core.Collection methodsFor: 'enumerating'!

count: aBlock
	"Evaluate aBlock with each of the receiver's elements as the argument.  
	Answer the number of elements that answered true."

	| sum |
	sum := 0.
	self do: [:each | (aBlock value: each) ifTrue: [sum := sum + 1]].
	^ sum!

select: selectBlock thenCollect: collectBlock
	"Utility method to improve readability."

	^ (self select: selectBlock) collect: collectBlock! !


!Core.String class methodsFor: 'instance creation'!

cr
	"Answer a string containing a single carriage return character."

	^ self with: Character cr!

tab
	"Answer a string containing a single tab character."

	^ self with: Character tab! !


!Core.Set methodsFor: 'comparing'!

equals: aSet

	self == aSet ifTrue: [^ true].	"stop recursion"
	(aSet isKindOf: Set) ifFalse: [^ false].
	self size = aSet size ifFalse: [^ false].
	self do: [:each | (aSet includes: each) ifFalse: [^ false]].
	^ true! !



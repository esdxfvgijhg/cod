"Changes in change set ReparentDefaultTests"!
'From VisualWorks® NonCommercial, Release 7 of January 27, 2003 on February 6, 2003 at 8:40:07 am'!


Smalltalk defineClass: #LessonTestCase
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'SLesson Tests'!

XProgramming.SUnit defineClass: #ExampleSetTest
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'full empty '
	classInstanceVariableNames: ''
	imports: ''
	category: 'SUnitTests'!

XProgramming.SUnit defineClass: #SUnitTest
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'hasRun hasSetup hasRanOnce '
	classInstanceVariableNames: ''
	imports: ''
	category: 'SUnitTests'!




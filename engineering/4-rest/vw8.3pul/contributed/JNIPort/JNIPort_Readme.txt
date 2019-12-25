JNIPort 2.0
___________

JNIPort is a Smalltalk library which allows Java code to be invoked from
Smalltalk. It acts as a bridge between the world of Smalltalk objects
and a Java Virtual Machine (JVM) where Java code is executing. With
JNIPort you can:

    * Supplement Smalltalk's libraries with the rather extensive Java
libraries available for free or from commercial vendors.

    * Use the normal (to a Smalltalker) interactive way of playing with
objects and code in workspaces to learn about and prototype Java
operations.

    * Continue to use your legacy Java code as you migrate to a more
grown-up language... ;-)


You talk to a Java object via a Smalltalk object that acts as a proxy
for it. You can call Java methods via the proxy using a lowish-level API
where you have to tell the proxy what the method name is, what the
argument types are, and so on. Alternatively you can use a higher level
of wrapper methods that are either statically generated, or created
dynamically.

Java classes are represented explicitly by wrapper objects (called class
statics), so each proxy for a Java instance has both a Smalltalk class
and a reference to the (shared) class static. The Smalltalk class
defines the wrapper methods for calling the Java object's methods, and
accessing its fields. The class static is the single member of a
different Smalltalk class that has methods for using the "static"
methods and fields of the Java class. The class static also has methods
corresponding to the Java class's constructors, so it acts as a factory
for new instances. That means that from the point of view of a JNIPort
programmer, Java classes really are objects!

A few warnings before you start to expect too much:

    * JNIPort does not provide complete interoperability between Java
and Smalltalk. For instance it is not possible to create Smalltalk
subclasses of Java classes (or the other way around).

    * The facilities for calling back from Java into Smalltalk are weak,
slow, and clunky.

    * JNIPort allows proper interaction with Java objects but it cannot
magically give you the ability to redefine Java classes interactively
too.

    * Deploying applications based on a mixture of Java and Smalltalk
may be somewhat challenging. For instance, needed wrapper classes must
not be removed during runtime creation, even when they are not
referenced anywhere in the Smalltalk code.


License
_______

JNIPort was originally written by Chris Uppal for Dolphin Smalltalk and
published under a liberal license which permits its use in commercial
and non-commercial software. 

Joachim Geidel has ported JNIPort to VisualWorks, Pharo, and Squeak. 
The portions written by Joachim Geidel are available under the MIT license. 

Portions of this software created by Joachim Geidel are (c) 2006-2011 
Joachim Geidel. These portions fall under the "MIT license":

"Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."

Portions of this software created by Chris Uppal are (c) Chris Uppal,
2001-2007. These portions are covered by Chris Uppal's license:

"The terms under which you may use this software are:
	You must not claim that you wrote it.
	You must not claim that you own it.
	You use it at your own risk.

I'd appreciate it if you didn't distribute modified versions without 
at least trying to tell me about the changes you thought worthwhile.

	-- chris"


Documentation
_____________

Chris Uppal's documentation for JNIPort for Dolphin is contained in the
archive JNIPort_Docs.zip. It is also available online at

	http://metagnostic.dolphinmap.com

Additional documentation, in particular for the VisualWorks, Pharo,
and Squeak versions, is available online at 

	http://jniport.wikispaces.com


Installing JNIPort for VisualWorks
__________________________________

Installation from parcels
_________________________
To use JNIPort for VisualWorks, you must load the following parcels:
	- Registry (version 28 or later)
	- FastCMethodPointers (version 1.1 or later)
	- WeakCollections
	- JNIPort Prerequisites
	- JNIPort

The parcels Registry and FastCMethodPointers are distributed with 
VisualWorks, they are located in the directory "contributed" of your
VisualWorks installation. WeakCollections is distributed with JNIPort.
If you are using an older version of VisualWorks which does not include
these parcels or a version of a parcel which is too old, you can either 
download a later version of VisualWorks and use the parcels included there, 
or load the corresponding package from the Cincom Public Store Repository 
(see below).

Some rudimentary development tools are contained in the parcel JNIPort Tools.

To run the unit tests for JNIPort, load the parcel JNIPort Tests. You also 
need additional files from the archive JNIPort_Extras.zip, see below. For
additional instructions read the bundle comment of JNIPort Tests.

Loading JNIPort Prerequisites will load Registry, FastCMethodPointers, and
WeakCollections as prerequisites. Loading JNIPort will load JNIPort 
Prerequisites and all of its prerequisites. Loading JNIPort Tools or
JNIPort Tests will load JNIPort and all of its prerequisites. JNIPort Tests
will also load the SUnitToo test framework.

The JNIPort 2.0 parcels cannot be loaded in VisualWorks 7.5 or 7.6; 
you must load JNIPort 2.0 from a Store repository instead. The reason is 
a change in the definition of subclasses of ExternalInterfaces which leads 
to an exception when loading a parcel written with VisualWorks 7.7.1. 

Installation from a Store repository
____________________________________
All of the components needed for JNIPort are  available in Cincom's 
Public Store Repository. See

	http://www.cincomsmalltalk.com/CincomSmalltalkWiki/PostgreSQL+Access+Page
	
for instructions. 

If you load JNIPort from a Store repository, please make sure that Store
is configured to search for components in Store first, and that it loads
the latest version with blessing level "Development" or higher. When Store
is configured to prefer loading parcels, the components loaded from Store
may not be compatible with prerequisites loaded from parcels if the
parcels are part of an older version of JNIPort. 

On the other hand, this may lead to the attempt to load versions of 
prerequisites which are too recent to be compatible with the version of 
VisualWorks which you are using. For example, if you try to load JNIPort 
into VisualWorks 7.6 from the Cincom Public Store Repository with the 
configuration recommended above, loading JNIPort Tools will attempt to 
load a recent version of SUnitToo(ls) which is not compatible with 
VisualWorks 7.6. If you encounter such a problem, you will have to load 
the correct versions of the prereqisite packages manually before loading
JNIPort.

To load JNIPort, just load the bundle JNIPort. This will automatically
load all of the needed prerequisites.

If you want to run the the unit tests, load the bundle JNIPort Tests. 
Some rudimentary development tools are contained in the bundle 
JNIPort Tools. Both JNIPort Tests and JNIPort Tools will automatically 
load JNIPort as well.

In VisualWorks 7.5 or earlier, you must load the following components 
*before* all other components of JNIPort:
	- DefaultPackageNamespaces
	- JNIPort VW75 Extensions
The parcel DefaultPackageNamespaces is distributed with VisualWorks 7.5 
and can be found in the directory "contributed" of the VisualWorks CD.
JNIPort VW75 Extensions is a package in the public repository.
	
In VisualWorks 7.6, you must load the following package *before* all 
other components of JNIPort:
	- JNIPort VW76 Extensions

Other aspects
_____________
The archives JNIPort_Extras.zip and JNIPort_Docs.zip are part of the JNIPort 
bundle and will be stored in your file system when the bundle is loaded from 
a Store repository. Alternatively, they can be downloaded from 

	http://jniport.wikispaces.com

On Mac OS X 10.5 and later, you should use a virtual machine from 
VisualWorks 7.7 or later, even if your VisualWorks image is based on
VisualWorks 7.6 or earlier. Older virtual machines are not able to
use some of the functions from the standard C library libSystem.dylib
which are used by JNIPort.



Installing JNIPort for Pharo and Squeak
_______________________________________

To use JNIPort for Pharo and Squeak, you need a Squeak virtual machine with 
the IAB32 plugin which contains the primitives used by the Alien foreign
function interface library.

The Cog virtual machine cannot be used for JNIPort as of now (February 2011),
as Alien is not yet compatible with Cog. This may change in the future. Once
Alien can be used with Cog, you should be able to use JNIPort with the
Cog VM as well.

You first have to install the packages 
	Alien-Prerequs
	Alien-Core
	Alien-Examples
	Alien-LibC
from the Alien library. Alien is available at

	http://www.squeaksource.com/Alien.html

In Pharo 1.1, you can load these components by evaluating the following code:

Gofer it
	squeaksource:'MetacelloRepository' ;
	package: 'ConfigurationOfAlien';
	load.

((Smalltalk globals classNamed: 'ConfigurationOfAlien') 
	project version: 'Pharo 1.1') 
		load: 'Core'; load: 'LibC'

In Pharo 1.2, you can load these components by evaluating the following code:

Gofer it
	squeaksource:'MetacelloRepository' ;
	package: 'ConfigurationOfAlien';
	load.

((Smalltalk globals classNamed: 'ConfigurationOfAlien') 
	project version: 'Pharo 1.2') 
		load: 'Core'; load: 'LibC'

In Squeak 4.2, you can load these components by evaluating the following code
(Alien-Prereqs is not needed in Squeak 4.2):

Installer squeaksource
    project: 'Alien';
    install: 'Alien-Core';
    install: 'Alien-Examples';
    install: 'Alien-LibC'.

Alien-Prereqs is only be needed in certain versions of Squeak or Pharo, and
Alien-Examples is only needed because of a code dependency of Alien-LibC 
on Alien-Examples. Future versions of the Alien library may have a different 
structure when the code is cleaned up.
Also, there is work in progress to integrate Alien and the FFI foreign function
interface. As of February 2011, it is not yet know when this will happen and
if JNIPort has to be changed to support a future version of Alien. Please
consult the instructions at SqueakSource to check if the Alien packages have
changed since the publication of JNIPort 2.0.

Before loading JNIPort in Squeak, you have to enable a setting which lets
the Compiler accept underscores in message selectors. In Pharo, this is not
necessary.

In Squeak's "Tools" menu, select "Preferences". This will open a preferences
browser. In the browser's list, select "Compiler", enable "Allow 
underscore selectors", and click on the "Save" button in the toolbar.

JNIPort for Pharo and Squeak is available from SqueakSource at

	http://www.squeaksource.com/JNIPort.html

There is a Metacello configuration for JNIPort which automates loading the 
components of JNIPort from SqueakSource. This will not load the Alien 
packages - you have to load them upfront. Pharo images include Metacello
by default. In Squeak, you may have to install Metacello before you can
use it to load JNIPort. For instructions, see

	http://code.google.com/p/metacello/wiki/DownloadMetacello

To load the Metacello configuration for JNIPort from SqueakSource,
evaluate the following expression:

	Gofer it 
		squeaksource: 'JNIPort';
		package: 'ConfigurationOfJNIPort';
		load.

Alternatively, you can of course also load the ConfigurationOfJNIPort package
manually into your Squeak or Pharo image.

To load the components of JNIPort which are needed for interfacing to Java,
load the default group:

	ConfigurationOfJNIPort project latestVersion load

To load all components including the unit tests, load the group "All":

	ConfigurationOfJNIPort project latestVersion load: #('All')

To load the unit tests when the rest of JNIPort is already loaded, load 
the group "Tests":

	ConfigurationOfJNIPort project latestVersion load: #('Tests')

The archives JNIPort_Extras.zip and JNIPort_Docs.zip can be downloaded from 

	http://jniport.wikispaces.com

On Mac OS X, the easiest way to make the Java virtual machine available
to JNIPort is to place a symbolic link to the JRE's virtual machine library
file libjvm.dylib in the working directory, usually in the same directory
where the image file is located. For a Pharo one-click image, this is the
directory PharoOneClickN.M.app/Contents/Resources. The virtual machine
library for Mac OS X 10.6 is

/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Libraries/libjvm.dylib


Running the unit tests
______________________

To run the tests, you need the files JNIPort.jar and JNIPort-Tests.jar 
from the archive JNIPort_Extras.zip. Both jar files must be on the Java 
classpath. One way to ensure this is to add the files to the classpath in 
the JVM settings. In this case, where the classpath is defined as a 
runtime parameter for the Java virtual machine, the path separator is 
the semicolon (;) on MS Windows, but a colon (:) on Linux and Mac OS X. 
It may be easier to use absolute paths on Linux and Mac OS X.

MS Windows with jar files in the working directory:

	.;JNIPort.jar;JNIPort-Tests.jar
	
Linux or Mac OS X with jar files somewhere else:

	.:/insert_path_here/JNIPort.jar:/insert_path_here/JNIPort-Tests.jar
	
Another option is to set the CLASSPATH environment variable. In this case, 
the path separator is always the semicolon (;). If you have copied the two 
jar files to the working directory, you may set the CLASSPATH like this:

	CLASSPATH=.;JNIPort.jar;JNIPort-Tests.jar
	
The source code for the classes in JNIPort-Tests.jar is located in the 
corresponding  zip file "JNIPort-Tests.zip". You don't need the source 
code for running the tests.

Before running the tests you have to start a Java VM, either from the 
JNIPort  Settings tool if you are using VisualWorks, or programmatically. 
For instructions, see the documentation at

	http://jniport.wikispaces.com

In VisualWorks, when the JVM is running, select the bundle "JNIPort Tests" 
in the Refactoring Browser and execute all tests in the bundle by clicking 
on the "run" button at the bottom of the browser window.

In Pharo or Squeak, open a TestRunner, select the JNIPort test packages
and the test classes contained in these packages, and click on 
"Run selected".

The tests for wrapper generation and for callbacks from Java will report 
errors when the default JVM configuration is used. You have to use a JVM 
configured for wrapper generation and callbacks to run them. 

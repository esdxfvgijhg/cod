AspectS 0.4.5 Port to VisualWorks 7.x

Robert Hirschfeld
hirschfeld@acm.org
2003-02-06

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

GENERAL
--

Change Set:	AspectS
Date:		6 February 2003
Author:		Robert Hirschfeld (hirschfeld@acm.org)
Version:	0.4.5
Prerequisite:	SqueakCompat (, ReparentDefaultTests)
		VisualWorks NonCommercial, Release 7.x
Note:		Port of AspectS for Squeak to VisualWorks
License:	Squeak License (http://www.squeak.org/download/license.html)

AspectS is an experimental extension of the Smalltalk MOP to support 
aspect-oriented programming (AOP).

http://www.prakinf.tu-ilmenau.de/~hirsch/Projects/Squeak/AspectS/

WARNING: Incorrectly using AspectS may result in an inconsistent image that 
can't be trusted anymore. Therefore, before experimenting with AspectS, 
please save and backup your image.

This version of AspectS is based on a port of John Brant's MethodWrappers.
http://st-www.cs.uiuc.edu/~brant/Applications/MethodWrappers.html

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

INSTALLATION
--

To install AspectS, file in the following change sets in the order shown:

#1 ReparentDefaultTests-045-7x.st

	Moves default SUnit test classes contained in the base image 
	out of SUnit's reach by re-parenting them to Core.Object.
	This allows for the running of AspectS test cases only 
	(assuming a clean base image, of course).

#2 SqueakCompat-045-7x.st

	Introduces a small compatibility layer to Squeak to make it 
	easier to keep this port in sync with the Squeak version.

	Thanks to Roger Whitney <whitney@cs.sdsu.edu> for updating 
	SqueakCompat to work with VisualWorks 7.x!

#3 AspectS-045-7x.st

	AspectS 0.4.5

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

TESTS
--

To verify the correct installation of AspectS, open a UI to SUnit via

	XProgramming.SUnit.TestRunner open.

and run all 506 unit tests.

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

WORKSPACES
--

There are two workspaces that might help exploring AspectS:

* AspectS-VW-Maintenance.ws

	A workspace used during development.

* AspectS-VW-TryMe.ws

	A workspace with some instructions to get started...

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Questions or suggestions for improvement?
<hirschfeld@acm.org>

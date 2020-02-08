VisualWorks(R) 8.3 Linux 64-bit x86 Object Engine ReadMe
Copyright (C) 2017 Cincom Systems, Inc.  All rights reserved.

For installation instructions for this release, refer to the
VisualWorks Installation Guide (Install.pdf) in the root
VisualWorks directory.  For a description of the object
engines, refer to the "Virtual Machines" chapter of the 
VisualWorks Application Developer's Guide (/doc/AppDevGuide.pdf).


The 64-bit System: Overview
---------------------------
The 64-bit implementation uses full 64-bit addresses for objects,
providing the ability to fill the entire available address space
with objects.  For an idea of the effective limits today consider
that current AMD x86-64 chipsets support a 48-bit virtual address
and a 40-bit physical address, while average 64-bit object size
is around 64 bytes.  So the maximum number of objects here-on is
theoretically (2 raisedTo: 40) / 64.0, or around 16 Giga objects
in a system with a terabyte of memory.


The 64-bit System: Implementation
---------------------------------
There are only three tagged types, 61-bit 2's complement
SmallIntegers, 61-bit unsigned Characters and a 61-bit SmallDouble,
subset of the 64-bit IEEE double-precision format that provides
the central 1/8th of the IEEE range at full precision.  The
immediate floating-point format provides a very usable range
(approximately  -1.0d77 to 1.0d77) which overflows to full 64-bit
boxed Doubles when results don't fit.  It provides a faster and
much more space-affordable floating-point, being about 2.5 times
faster (about 2.5 times slower than SmallInteger arithmetic) and
having no space overhead.

The rationale behind using only three of the possible seven
immediate tag patterns is two-fold.  First, measurements show
that not much space is saved by doing things like packing seven
byte symbols into immediates because intrinsically these short
symbols don't take up much space anyway, and providing access to
such packed immediate types slows down the path for normal object
access in things like the #at: primitives.  Second, by using three
tag types we can make the #isImmediate, #isSmallInteger and
#isSmallDouble tests faster, since they need test only a single bit,
these tests being performance-critical to inlined arithmetic and
object access in the various #at: and #at:put: primitives.

The 64-bit object representation is relatively more compact than
the 32-bit one, resulting in only a 33% growth in object header
size from 12 bytes to 16.  In particular object headers no longer
reference their class object directly but instead include a 20-bit
"class index" that is used in all in-line cache tests and in object
instantiation.  Classes are held in a sparse table and accessed by
dereferencing the 20-bit index.  This saves 44 bits while imposing
a restriction on total number of classes unlikely to be a problem
to contemporary applications.  Class objects are accessed quite
rarely, for example when a message send fails to find a lookup in
the method caches and has to do a full class hierarchy lookup, or
when the programmer explicitly accesses the class via the
Object>>#class primitive.  64-bit objects have a 20 bit identity
hash field (and in fact the class index is the class's identity
hash) giving 1 Meg hash values (up from 16383 in the 32-bit system)
and a maximum of 1 Meg classes.  The header of 64-bit pointer
objects also includes the number of fixed fields (number of named
instance variables) so that the accessing primitives #at: and
#at:put: no longer have to indirect through the class to find how
many named instance variables to skip over.  Consequently array
access performance is much improved.

We have gratefully adopted an idea by Mark Van Gulik to do with
tagging objects.  Because object headers comprise two 64-bit words
they can be placed at an even or an odd modulo 128-bit boundary.
In the 64-bit system PermSpace objects are on an odd boundary and
OldSpace objects on the even one.  This means that the store check
is slightly faster, but much more importantly means that PermSpace
can be placed anywhere in the address space.  All that needs to
happen is for a PermSpace segment to have its object table aligned
on an odd modulo 128-bit boundary.  This means we can implement
shared PermSpace easily, allowing the operating system to dictate
where to memory map a PermSpace segment.  Thus bit 4 is a tag that
distinguishes between PermSpace and OldSpace objects, and hence we
call it "tagged perm".

In the 32-bit system we require all of PermSpace to be above all of
OldSpace or vice versa.  When shared perm was first implemented
OldSpace growth was not implemented.  It was therefore easy to
implement shared PermSpace with the OS mapping it above all of
OldSpace.  But once we provided OldSpace growth and shrinkage by
memory-mapping OldSpace segments it became much more difficult to
guarantee that PermSpace is mapped above all other heap segments
since the upper portion of the address space is typically where
shared libraries, the stack segment and memory-mapping all collide
in a manner best determined by the OS and not amenable to precise
control from an application program.  Mapping memory at low addresses
is typically difficult because in the lower portion of the address
space the C heap and the application's code and data itself collide.
Hence we have yet to reimplement shared perm in the 32-bit system.

By using the "tagged perm" scheme we are able to decouple PermSpace
from location and can hence easily share PermSpace, and allow
PermSpace to grow.  This first release preview release does not
support shared PermSpace, but we expect the next release will do so,
and a subsequent release will support loading parcels into new
PermSpace segments.  These usages, plus the problems of making
effective use of immediate types above, justify the use of one tag
bit for ordinary objects.

The C connect in the 64-bit implementation is a full 64-bit ABI and
consequently removes the annoying limitations people have encountered
when trying to run the 32-bit system on 64-bit Solaris linking (or
rather not being able to link) against 64-bit libraries.  We assume
that the 64-bit ABI is able to call 32-bit code since it is a superset,
but are not certain.  This is something that needs testing and 32-bit
code support in the 64-bit system might be something that has to wait
a release.


The 64-bit System: Getting Started
----------------------------------
The two systems are code compatible in that the bytecode is exactly the
same between the two systems, so parcels load unchanged and can be freely
exchanged between 32-bit and 64-bit systems.  The main differences within
the system are that

- in one SmallInteger maxVal is 536870911; in the other it is
  1152921504606846975

- in one system there are two float types Float and Double corresponding
  to 32-bit and 64-bit IEEE; in the other there is a third, a SmallDouble
  subrange of 64-bit IEEE.

Smalltalk's infinite precision Integer arithmetic essentially protects
Smalltalk code from the impact, doubtless hiding it behind some fairly
significant performance differences for certain kinds of computations.

The two systems can morph into each other using the image file.  A Smalltalk
program called the ImageWriter (preview/64-bit/ImageWriter.pcl) reads in a
32-bit image and writes out a 64-bit image, and will be able to do the
reverse (although we haven't implemented this yet there are no
insurmountable issues).  The ImageWriter is like Smalltalk-80's SystemTracer
except that it operates on an image file rather than on itself, avoiding a
number of tricky issues.  Using a modern machine converting a 32-bit image
to a 64-bit one is reasonably fast.

To produce a 64-bit image load the ImageWriter parcel and evaluate
    VirtualImage
        cloneFrom: 'visual'                    "input 32-bit image"
        to: 'visual64'                         "output 64-bit image"
        target: McCartneyImmediateDoubles      "code name for 64-bit engine"

then run visual64.im using a 64-bit VM.


Future 64-bit Platforms
-----------------------
We already have Solaris SPARC64, Solaris x86-64 and Windows x86-64 virtual
machines.  In the future, we may implement Mac OS X and AIX PPC64.  Note that
AMD's x86-64 and Intel's EMT64 architectures are compatible for our purposes,
so x86-64 VMs will be usable on EMT64 systems.  Currently we have an aversion
to the VLIW architecture of the Itanium which we think makes it hard to
develop an efficient implementation given our current compilation technology,
but if it endures then Itanium will be on our list.

We're interested in knowing your requirements for both processors and
operating systems.  If you have particular platform requests, please contact
Cincom product support.


Time and Space
--------------
Ignoring object headers, normal pointer objects double in size.  But lots of
objects are simply byte vectors.  These only grow by the 33% header increase.
So the 64-bit images we have cloned so far are about 53% larger than their
32-bit originals.  If the dynamic access pattern of a running Smalltalk
corresponds to the static ratio between pointer and byte vector objects then
you'd expect the 64-bit system to access about 60% more bits to accomplish the
same computation than the 32-bit implementation since every inst var access is
a 64-bit one, not a 32-bit one.  So one would guess that memory-limited
applications would be up to 60% slower than the 32-bit system.  So far
benchmarks show only a 10% slowdown, we think due to the efficiencies of the
object format (such as faster array access).


Using the VisualWorks Debug Object Engines
------------------------------------------

Information about and instructions for using the debug engines 
may be found in the VisualWorks Application Developer's Guide 
(/doc/AppDevGuide.pdf), specifically the sub-section entitled 
"Debugging with the Virtual Machine".


01/26/2017   MDR

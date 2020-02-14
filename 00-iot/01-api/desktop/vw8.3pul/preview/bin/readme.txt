VisualWorks(R) Preview System 4-Byte Loader ReadMe
Copyright 2007-2017 Cincom Systems, Inc. All rights reserved.

UNIVERSAL CONFIGURED STARTUP ON UNIX-BASED AND WINDOWS PLATFORMS
This directory contains
	VisualWorks.sh		a 4-byte loader for Unix-based platforms
	VisualWorksXL.exe	a 4-byte loader for Windows platforms
The loader determines which version of VW and which specific VM is needed to run
the image from the information in the loader's INI file
	VisualWorks.ini		4-byte loader info for Unix-based platforms
	VisualWorksXL.ini	4-byte loader info for Windows platforms

- The UNIX-based loader is written as a standard shell script, which lets it launch
VW on virtually any Unix-based platform. This also opens up the ability to have a
centrally managed site-wide installation of an arbitrary number of VW installations
while allowing users to open any image as an executable with no user-specific setup.

- The Windows loader expects to be linked to the .im fileType; it is an alternative
to the (supported) 2-Byte Windows loader in bin/{win|win64}/VisualWorks.exe.

INSTALLATION AND CONFIGURATION
A loader consists of two files that must reside in the same directory. Symbolic
links can be used instead of physical files if a separate location is desired.

ON WINDOWS
Create or edit the .im fileType to use a preferred loader - bin\VisualWorks.exe
(the 2-byte loader) or preview\bin\VisualWorksXL.exe (the 4-byte loader) - so
you can double-click a VW image to open it with the correct VM and VW home.

In some versions of Windows, editing a filetype to use another program of the same
name fails to effect a change. VisualWorks.exe and VisualWorksXL.exe are named
differently to avoid this bug. Note that this executable has been renamed for
VisualWorks 8.2 so if you have been using the 4-byte loader you will need to update
your existing .im fileType association. It may be necessary to do this by editing
the Windows Registry key

	HKEY_CLASSES_ROOT\Applications\VisualWorks.exe\shell\open\command  

Users in the VW-DEV program may find it convenient to use the 4-byte loader. Most
Windows users will find the existing, supported 2-byte loader sufficient, since the
3rd and 4th bytes are zero in releases, and installing VisualWorks on Windows adds
a Registry entry that sets VisualWorks home from the 2 bytes. The 2-byte loader is
	bin/{win|win64}/VisualWorks.exe
	bin/{win|win64}/VisualWorks.ini
On a 64-bit platform, either the 32-bit or 64-bit loader can be used with any
32-bit or 64-bit image.

ON LINUX/UNIX/MAC
The initial bytes of any VW image contain an executable expression that expects
an executable named 'visual' to be present in the system path. It runs this
executable with the image file as the image parameter.  Consequently, to invoke
the loader it is necessary to make VisualWorks.sh play the role of the "visual"
executable.  Two ways to achieve this are: 

 - Create a symbolic link named 'visual' that points to VisualWorks.sh. 
   Make sure this 'visual' link is in your PATH. For example, if the shell 
   is installed in /opt/VisualWorks/bin, execute:
   
	>cd ~/bin; ln -s /opt/VisualWorks/bin/VisualWorks.sh visual

 - Rename the VisualWorks.sh file to 'visual' and ensure that its directory
   (e.g. /opt/VisualWorks/vw8.1.1/preview/bin) is in your PATH.

Any image that you wish to launch this way must itself be marked as executable:

	>chmod u+x visual.im

Then it can be run as any other system command, e.g.

	>./visual.im

There is no 2-byte loader offered on Unix-based systems; use two-byte lines in the
INI file of this 4-byte loader if you only wish to match standard releases.

THE INI FILE
INI file lines contain either two or four byte values, followed by the installation
path, optionally preceeded by an explicit VM path, thus:
	X X VW-installation-path
or
    X X X X VW-installation-path
or
    X X VM-path?VW-installation-path
or
    X X X X VM-path?VW-installation-path
(where X X X X represents the 4-byte image signature). The first byte denotes the
major release number. The second bytes gives the minor release number. The third
and fourth bytes are always zero for public releases, so the line
    81 01 /opt/VisualWorks/vw8.1.1
has the same effect as
    81 01 00 00 /opt/VisualWorks/vw8.1.1
i.e., both match images from the 8.1.1 release. Users in the VW-DEV program may
wish to match specific dev releases; for example, the line
    81 01 05 04 /opt/VisualWorks/vw8.1.1/dec15.1
would match images from the 5th development build (the 05 third byte) of the 8.1.1
development cycle. The 04 final byte denotes a dev build, not release (00) or patch
(06), or etc. If the VisualWorks.ini file contains that line, typing
	./myDevImage.im
in a typical linux on an image with that signature would open it using the VM
	/opt/VisualWorks/vw8.1.1/dec15.1/bin/linux86/visual
and its VisualWorks home directory would be set to
	/opt/VisualWorks/vw8.1.1/dec15.1
Images from a development cycle build (available to VW-DEV members) have all four
bytes non-zero, and the signature changes with each build. Accordingly, a new
line matching all four bytes must be added to the INI file for each dev build.

The VW-installation-path configures the VisualWorks home setting: at startup, if
    X X X X VW-installation-path
is matched, the $VISUALWORKS system variable is assigned this value, and the
loader searches for an executable 'visual' VM in VW-installation-path/bin sub-
directories. If the optional VM-path? is given, and points at this visual VM, e.g.
    81 00 00 00 C:\Cincom\vw8.1\bin\win\visual.exe?C:\Cincom\vw8.1
that (merely) minimally speeds this search.  However a VM-path? part is essential
to specify use of the debug VM, the assert VM, or the statically-linked VM (all of
which are included in a typical VisualWorks installation), or a custom VM.

HOW ENTRIES ARE SEARCHED
The loader searches the INI file for entries that match the VI (VisualWorks Image)
signature. Each matching entry is tried in the order it appears in the INI file.  If
the optional VM-path? is specified, only that exact VM will be tried for that entry.

To handle non-standard locations for VMs for different platforms, it is permissible
to have multiple entries for the same image signature, each specifying a VM for a
different platform. The entries will be tried in sequence until the correct VM for
the current platform is found. So,
    81 01 /opt/vw8.1/bin/linux86/debug/vwlinux86dbg?/opt/vw8.1.1
    81 01 /opt/vw8.1/bin/linux86/visual?/opt/vw8.1.1
will try to use the debug VM first; if that fails the production VM will be tried.
This is why the script works across different platforms. Suppose the INI file has:
    81 01 /opt/vw7.5.1/bin/linux86/vwlinux86gui?/opt/vw8.1.1
    81 01 /opt/vw7.5.1/bin/solaris/visual?/opt/vw8.1.1
    81 01 /opt/vw8.1.1
If the script is run on solaris, the linux86 entry is tried first, and fails, so the the
solaris entry is tried, and succeeds. If the script is run on AIX, the first lines
fail, so the script searches for any working VM using the third entry.

OTHER FEATURES
1) If you run an image from the VW installation hierarchy, e.g.
	~vw/image/visual.im
then the loader uses the right VM without requiring an INI entry.

2) There is also a simple INI entry generator.  Run
    >visual -ne /path/to/vw/image/visual.im >> VisualWorks.ini
for a clean image in the original 'image' directory in the installation.

01/26/2017	MDR
20apr2016	Niall Ross, Sherry Michael
29nov2007	Martin Kobetic, Peter Hatch, Bruce Boyer
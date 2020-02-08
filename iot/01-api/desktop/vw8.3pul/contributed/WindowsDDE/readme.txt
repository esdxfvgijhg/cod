Using VW & DDE

DDE is a simple inter-process-communication mechanism.  Windows maintains a table mapping names to "server" processes.  If a process wants to register itself with DDE then at start-up it issues a call that inserts it in the table under an arbitrary name.  So the VW DDE image is configured to install itself as the application known as VisualWorks at start-up.  Then a DDE application installs call-backs which are invoked when DDE actions come in from Windows.  These callbacks essentially supply a filename and a "topic".  Topics are arbitrary and are associated with files in the Windows File Types table.  Since this requires a "server" process is already registered one also must supply a command to run if the "server" is not registered.  So file type actions specify an application to launch, the name of the "server" process, and a topic.

When one invokes a file's action & topic DDE checks if a "server" process with the correspondng name is in its table.  If not, it uses the action's defined command.  Presumably the command will then install itself in the table.  DDE then invokes a callback (via the message queue) that communicates to the "server" process.

So to build a DDE VisualWorks we need to both set-up the "server" image and the file type actions and their topics.

Image:

1. File-in SetDir.cha.  This adds code to set the current directory.  Its used by the DDE code to put the image in the right directory on launch.  Windoze (of course) puts the image in WINDOWS.

2. Load parcel VW DDE Shell

3. Launcher->File->DDE Save And Exit As... as a new image (e.g. vw30dde).  This closes all windows, saves and exits.

4. Set up some file types and actions.  e.g. for type .ST:
   Windows Finder/Explorer->View->Options... File Types tab 

	name Smalltalk Source File
	extension .ST

	edit...
add an open action
	new...
make it an open action
	
In the edit page fill in:
	Application used to perform the action:
		c:\vw30\bin\visual.exe -NOLOGO c:\mydir\vw30dde.im
Tick "Use DDE" (which opens up the following fields:)
	DDE Message:
		%1
	Application
		VisualWorks
	DDE Application Not Running:
		%1
	Topic
		changelist

Current topics are
	changelist
	browsefile
	filein
Current partially implemented topics are
	parcel

Add new topics to SystemShellCommand>>#process
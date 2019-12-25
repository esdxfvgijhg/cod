COAST Framework Release 5.3 (2013-04-15)

This Archive contains the following files:

Prerequisite non-coast parcels
	DeploymentVersionPragma
		Adds version information to deployed executables
	WinService
		Required to run the COAST mediator as a service on Windows
	ExternalInterfaceBashing	
		Fixes some known bugs after loading external interfaces from source
	WeakCollections
		Implementation of WeakSet. Not included, because it was implemented by a 3rd party.
		Must be retrieved from Cincom's public Store repository, or from the contributed JNI Port package.

COAST framework pacels
	COASTCore
		Core classes needed by mediator and clients
	COASTMediator
		Servcer part
	COASTClient
		Client part
	COASTLanCache
		a dedicated caching client
	COASTViews
		for clients with GUI
	COASTDevelopment
		development tools
	COASTGarbageCollection
		Garbage collection of persistent COAST-Objects
	COASTMailNotifier	
		to send mails in deployed images when errors are logged

Sample coast application: Sudoku (copyright by H.Scholz@i-views.de)
	SudokuModel
		a simple Sudoku Model for computing
	SudokuSolving
		multiple solving strategies to solve a sudoku puzzle
	SudokuCoastModel
		a coast Model for cooperative sudoku games
	SudokuInternational
		MessageCatalog #eng & #ger
	SudokuViews
		"SudokuLoginApp open" to start a local game or connect to a coast mediator for games teams against other teams

Other ressources
	readme.txt
	license.txt
		copy of the license under witch thissoftware is distributed
			

Documentation:

The COAST documentation is still work in progress. We included
the following files:

	COAST4-overview.PDF
		An overview describing the main concepts


Don't hesitate to contact us (support-coast@i-views.de). 
We know that the documentation we provide is outdated, so please feel free to 
ask questions!

We will thankfully welcome any contribution to the further development of COAST.

	The COAST team, Hans Scholz

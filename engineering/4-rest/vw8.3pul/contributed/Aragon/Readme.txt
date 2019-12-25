

These have been trivially updated to work with the VisualWorks 8.1
release.  The updated parcels were published from versions in the
Cincom Open Repository.
	February 12, 2015
_________________________________________________________________________


        The Aragon Add Ons
         for VisualWorks 7.1

        Release 7

        Installation & Release Notes
        May 27, 2003

_________________________________________________________________________




    This readme file gives instructions on installation
    of the Aragon Add Ons along with some more detailed 
    information on certain components.

    Contents:

        Installation
        Notes on VisualWorks 5i implementation
        Packages requiring DLL/C Connect



_________________________________________________________________________

    Installation
_________________________________________________________________________



	Unzip the Aragon archive to some arbitrary directory (referred to as ~Aragon, 
	in the remainder). In order to add Aragon packages to your image simply open 
	a FileBrowser in VisualWorks, navigate to ~Aragon/Parcels and load the parcels 
	that you want to use. 
	
	Note that you don't need to load the parcels Aragon.Basics and Aragon.Shared 
	explicitely, they are loaded automatically via the Parcel's pre-requisites mechanism.
	
        

_________________________________________________________________________

    Compatibility Notes 
_________________________________________________________________________


            Since Aragon/5, all the Aragon classes 
         are placed in a separate namespace 'Aragon'. This has the 
         side-effect that existing applications that are based on 
         Aragon products might need modifications in code that
         references Aragon classes. E.g., a code like this:
         
               aTreeNode := AragonTreeNode on: 'Something'.
              
         would have to be rewritten to read like this:
         
               aTreeNode := Aragon.AragonTreeNode on: 'Something'.
               
         (BTW: In this case 'Something' asTreeNode would be better).
         
         Alternatively, if the effort to find and rewrite all the 
         respective methods in an existing app would be to high, 
         you might choose to include the Aragon namespace into the
         Smalltalk namespace.
         
         Secondly you would not have to rewrite windowSpecs and 
         other resources that refer to Aragon widget spec classes 
         by symbols. The Aragon spec classes are included into the 
         Smalltalk namespace as statics for this purpose.
         

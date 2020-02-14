README for GLORP



These directories contain code for GLORP: Generic Lightweight

Object-Relational Persistence. GLORP is an open source Smalltalk

library for storing and retrieving objects from relational databases. See the 

file COPYING.TXT for license conditions. Glorp is officially supported code 

since VisualWorks 7.6.  For documentation, see doc/GlorpGuide.pdf.  For

the GLORP project website, see http://www.glorp.org.



The latest versions of GLORP can also be found in the public store 

repository. See http://www.cincomsmalltalk.com



Included in this directory are



 Glorp.pcl/.pst - The main body of the Glorp code

 GlorpTest.pcl/.pst - Tests for Glorp. This is also a useful source of examples.

 GlorpVWPort.pcl/.pst - A prerequisite for Glorp, containing VisualWorks-specific code. The main 

body of Glorp code is portable between Smalltalk dialects, and this parcel contains only the code

that cannot be written in a portable way.


 GlorpActiveRecord.pcl/.pst - A library that implements a simpler to configure descriptor system, using

convention and reading information from the database. The APIs are similar to those in the Ruby on Rails

ActiveRecord implementation, although you still have access to all of the underlying mapping facilities

to permit much more sophisticated mappings.

 GlorpActiveRecordDemo.pcl/.pst - A simple demo of the GlorpActiveRecord code.

 GlorpActiveRecordTests.pcl/.pst - Tests for GlorpActiveRecord.



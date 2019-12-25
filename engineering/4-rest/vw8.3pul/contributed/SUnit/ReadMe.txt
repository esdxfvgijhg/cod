SUnit 4.0 Release Candidate Notes
Dialect: VisualWorks
Current Release Candidate level: 4
Last Update: 20100507
==================================
See references to SUnit in doc/ReleaseNotes7.7.1.pdf and doc/ToolGuide.pdf.

Changes:
4.0 - 20100507
* To support customisation, the TestResult handler dispatches to the exception raised by the
test, which in turn invokes a method on the TestResult, to determine how to react to an Error
or TestFailure.

* TestResource>>setUp no longer called from TestResource>>initialize;  framework calls both.
Call of TestResource>>tearDown is ensured if TestResource>>setUp is entered, not, as before,
only if setUp succeeds.

* SUnit gets test selectors more performantly.  New method TestCase class>>lookupHierarchyRoot
supplements TestCase class>>shouldInheritSelectors in controlling inheritance.

3.3 - 20100101
* Move the reaction to resource unavailability from TestCase to TestResource>>availableFor:
so that subclasses may add to or alter the default behaviour (which is to raise a TestFailure).

* If two resources require a resource (e.g. two resources add data to a database and remove it
on tearDown, and both use the same database connection resource), all three resources will be
torn down in the right order.  See TestResource class>>resetResources: (use this in scripts).

* Prevent looping when tearing down an un-setUp-able indirectly-self-prerequing resource.

* Move deprecated method #correctCount to 'deprecated' protocol.

3.2 - 20090911
* Better ordering of TestResource setUp and tearDown.
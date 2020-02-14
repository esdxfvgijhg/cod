Example: AsWindowMousingAspect to show a mouse-enter/mouse-exit/mouse-double-click event trace on the Transcript

Create an instance of AsWindowMousingAspect and open an inspector on it.
	doIt: [demoAspect := AsWindowMousingAspect new]
Then, evaluate
	doIt: [demoAspect install] or
	doIr: [demoAspect uninstall]
to activate or deactivate the aspect. While the aspect is active, move the mouse around over several system windows and watch the Transcript for messages.

A variation of the example above shows one way of how aspects could be applied as project-specific views.
	doIt: [demoAspect := AsWindowMousingProjectAspect new]
Then, evaluate
	doIt: [demoAspect addProject: LightweightProjects current] or
	doIt: [demoAspect removeProject: LightweightProjects current]
to make the aspect aware of the current project or not. To activate or deactivate the aspect, evaluate
	doIt: [demoAspect install] or
	doIt: [demoAspect uninstall]
To see the project awareness of the aspect:
	* add the current project to the aspect
	* validate that the aspect is working by opening a transcript and moving to mouse around to see eventlogs appear at the transcript
	* change to another project (for example via the Change Sets UI)
	* check if the aspect active in the previous project is still active there... (and it shouldn't)

More examples:

AspectS-Examples Visitor category: shows the use of a set of introduction advice to introduce new behavior to tie a set of visitors into the implementation of a simple tree implementation.
AspectS-Examples Factorial category: illustrates the use of CFlow elements in advice.

Some of the SUnit tests might be of interest as well. See all subclasses of AsTestCase ...

Even more examples? Add some, and tell me <hirschfeld@acm.org> ;-)

For maintenance only:

AsMethodWrapper initializeWithAllSubclasses.
AsMethodWrapper countAllInstances.

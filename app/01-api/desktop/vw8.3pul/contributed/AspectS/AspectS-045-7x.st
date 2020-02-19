"Changes in change set AspectS"!
'From VisualWorks® NonCommercial, Release 7 of January 27, 2003 on February 6, 2003 at 8:40:18 am'!


Smalltalk defineNameSpace: #AspectS
	private: false
	imports: '
			private Smalltalk.*
			'
	category: 'AspectS-Name Spaces'!

Smalltalk.AspectS defineClass: #AsCFlowPoint
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'object selector '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Aspects'!

Smalltalk.AspectS defineClass: #AsNode
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'first op second '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor'!

Smalltalk.AspectS defineClass: #AsAspect
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'receivers senders senderClasses projects clientAnnotations advice installed '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Aspects'!

Smalltalk.AspectS defineClass: #AsWindowMousingAspect
	superclass: #{AspectS.AsAspect}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples WindowMousing'!

Smalltalk.AspectS defineClass: #AsCounterAutoReset2Aspect
	superclass: #{AspectS.AsAspect}
	indexedType: #none
	private: false
	instanceVariableNames: 'threshold '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Counter'!

Smalltalk.AspectS defineClass: #AsFactorial2TraceAspect
	superclass: #{AspectS.AsAspect}
	indexedType: #none
	private: false
	instanceVariableNames: 'trace traceFirst traceAllButFirst '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Factorial'!

Smalltalk.AspectS defineClass: #AsTestCase
	superclass: #{XProgramming.SUnit.TestCase}
	indexedType: #none
	private: false
	instanceVariableNames: 'aspekt result trace '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests General'!

Smalltalk.AspectS defineClass: #AsVisitorAlternative2AspectTest
	superclass: #{AspectS.AsTestCase}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor Alternative 2'!

Smalltalk.AspectS defineClass: #AsPostfixVisitorAlternative2AspectTest
	superclass: #{AspectS.AsVisitorAlternative2AspectTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor Alternative 2'!

Smalltalk.AspectS defineClass: #AsCounterAspectTest
	superclass: #{AspectS.AsTestCase}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Counter'!

Smalltalk.AspectS defineClass: #AsCounterAutoReset2AspectTest
	superclass: #{AspectS.AsCounterAspectTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Counter'!

Smalltalk.AspectS defineClass: #AsVisitorAspectTest
	superclass: #{AspectS.AsTestCase}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor'!

Smalltalk.AspectS defineClass: #AsAdviceQualifierTest
	superclass: #{AspectS.AsTestCase}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests General'!

Smalltalk.AspectS defineClass: #AsAbstractVisitorAlternative2Aspect
	superclass: #{AspectS.AsAspect}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor Alternative 2'!

Smalltalk.AspectS defineClass: #AsPostfixVisitorAlternative2Aspect
	superclass: #{AspectS.AsAbstractVisitorAlternative2Aspect}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor Alternative 2'!

Smalltalk.AspectS defineClass: #AsCounterThresholdAspectTest
	superclass: #{AspectS.AsCounterAspectTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Counter'!

Smalltalk.AspectS defineClass: #AsCounterThresholdAspect
	superclass: #{AspectS.AsAspect}
	indexedType: #none
	private: false
	instanceVariableNames: 'threshold lastPass '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Counter'!

Smalltalk.AspectS defineClass: #AsAbstractVisitorAspect
	superclass: #{AspectS.AsAspect}
	indexedType: #none
	private: false
	instanceVariableNames: 'trace '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor'!

Smalltalk.AspectS defineClass: #AsInfixVisitorAspect
	superclass: #{AspectS.AsAbstractVisitorAspect}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor'!

Smalltalk.AspectS defineClass: #AsPostfixVisitorAspect
	superclass: #{AspectS.AsAbstractVisitorAspect}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor'!

Smalltalk.AspectS defineClass: #AsInfixVisitorAlternativeAspectTest
	superclass: #{AspectS.AsTestCase}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor Alternative'!

Smalltalk.AspectS defineClass: #AsAroundWrapperTest
	superclass: #{AspectS.AsTestCase}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstInstanceSGAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsSenderGeneralAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsCFlowFirstClassRGAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsCFlowFirstClassSSAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstInstanceRSAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstInstanceSSAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstClassSSAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsCFlowFirstInstanceSGAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsCFlowFirstInstanceRGAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsPostfixVisitorAlternativeAspect
	superclass: #{AspectS.AsAspect}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor Alternative'!

Smalltalk.AspectS defineClass: #AsReceiverSpecificAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsFactorialTraceAspect
	superclass: #{AspectS.AsAspect}
	indexedType: #none
	private: false
	instanceVariableNames: 'trace traceFirst traceAllButFirst '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Factorial'!

Smalltalk.AspectS defineClass: #AsFactorialAspectTest
	superclass: #{AspectS.AsTestCase}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Factorial'!

Smalltalk.AspectS defineClass: #AsFactorialTraceAspectTest
	superclass: #{AspectS.AsFactorialAspectTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Factorial'!

Smalltalk.AspectS defineClass: #AsCounter
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'n '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Counter'!

Smalltalk.AspectS defineClass: #AsHandlerWrapperTest
	superclass: #{AspectS.AsTestCase}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsCFlowFirstClassRGHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstInstanceRSHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsReceiverSpecificHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstInstanceSGHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstClassRGHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstClassSGHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsCFlowFirstClassSSHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsCFlowFirstInstanceRSHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstInstanceSSHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsReceiverGeneralAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsJoinPointDescriptor
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'targetClass targetSelector '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Aspects'!

Smalltalk.AspectS defineClass: #AsInfixVisitorAlternative2Aspect
	superclass: #{AspectS.AsAbstractVisitorAlternative2Aspect}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor Alternative 2'!

Smalltalk.AspectS defineClass: #AsMethodWrapper
	superclass: #{Kernel.CompiledMethod}
	indexedType: #objects
	private: false
	instanceVariableNames: 'clientSelector clientMethod definingClass wrappedClass wrappingWrapper aspect advice activators '
	classInstanceVariableNames: 'protoMethods '
	imports: ''
	category: 'AspectS-Wrappers'!

Smalltalk.AspectS defineClass: #AsAroundWrapper
	superclass: #{AspectS.AsMethodWrapper}
	indexedType: #objects
	private: false
	instanceVariableNames: 'aroundBlock '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Wrappers'!

Smalltalk.AspectS defineClass: #AsIntroductionWrapper
	superclass: #{AspectS.AsMethodWrapper}
	indexedType: #objects
	private: false
	instanceVariableNames: 'introBlock '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Wrappers'!

Smalltalk.AspectS defineClass: #AsCFlowFirstClassSGAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsA
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'x '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests General'!

Smalltalk.AspectS defineClass: #AsB
	superclass: #{AspectS.AsA}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests General'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstClassSSHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstInstanceRGHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsPostfixVisitorAspectTest
	superclass: #{AspectS.AsVisitorAspectTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor'!

Smalltalk.AspectS defineClass: #AsAdvice
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'pointcut qualifier wrappers installed '
	classInstanceVariableNames: 'wrapperClasses '
	imports: ''
	category: 'AspectS-Aspects'!

Smalltalk.AspectS defineClass: #AsHandlerAdvice
	superclass: #{AspectS.AsAdvice}
	indexedType: #none
	private: false
	instanceVariableNames: 'exception handlerBlock '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Aspects'!

Smalltalk.AspectS defineClass: #AsIntroductionAdvice
	superclass: #{AspectS.AsAdvice}
	indexedType: #none
	private: false
	instanceVariableNames: 'introBlock '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Aspects'!

Smalltalk.AspectS defineClass: #AsBeforeAfterAdvice
	superclass: #{AspectS.AsAdvice}
	indexedType: #none
	private: false
	instanceVariableNames: 'beforeBlock afterBlock '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Aspects'!

Smalltalk.AspectS defineClass: #AsCounterSetTraceAspectTest
	superclass: #{AspectS.AsCounterAspectTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Counter'!

Smalltalk.AspectS defineClass: #AsPrefixVisitorAlternativeAspect
	superclass: #{AspectS.AsAspect}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor Alternative'!

Smalltalk.AspectS defineClass: #AsInfixVisitorAlternative2AspectTest
	superclass: #{AspectS.AsVisitorAlternative2AspectTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor Alternative 2'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstInstanceRGAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsSenderGeneralHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsAspectB
	superclass: #{AspectS.AsAspect}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests General'!

Smalltalk.AspectS defineClass: #AsAspectBA
	superclass: #{AspectS.AsAspectB}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests General'!

Smalltalk.AspectS defineClass: #AsHandlerWrapper
	superclass: #{AspectS.AsMethodWrapper}
	indexedType: #objects
	private: false
	instanceVariableNames: 'exception handlerBlock '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Wrappers'!

Smalltalk.AspectS defineClass: #AsPrefixVisitorAlternativeAspectTest
	superclass: #{AspectS.AsTestCase}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor Alternative'!

Smalltalk.AspectS defineClass: #AsFactorial2TraceAspectTest
	superclass: #{AspectS.AsFactorialAspectTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Factorial'!

Smalltalk.AspectS defineClass: #AsCFlowFirstClassSGHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsBeforeAfterWrapper
	superclass: #{AspectS.AsMethodWrapper}
	indexedType: #objects
	private: false
	instanceVariableNames: 'beforeBlock afterBlock '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Wrappers'!

Smalltalk.AspectS defineClass: #AsAroundAdvice
	superclass: #{AspectS.AsAdvice}
	indexedType: #none
	private: false
	instanceVariableNames: 'aroundBlock '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Aspects'!

Smalltalk.AspectS defineClass: #AsPrefixVisitorAspect
	superclass: #{AspectS.AsAbstractVisitorAspect}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor'!

Smalltalk.AspectS defineClass: #AsSenderSpecificHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstClassRSAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsAspectA
	superclass: #{AspectS.AsAspect}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests General'!

Smalltalk.AspectS defineClass: #AsCFlowFirstInstanceRSAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsAspectAnnotationsTest
	superclass: #{AspectS.AsTestCase}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests General'!

Smalltalk.AspectS defineClass: #AsReceiverGeneralHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

AspectS.AsMethodWrapper defineSharedVariable: #ProtoActivators
	private: false
	constant: false
	category: 'activators'
	initializer: nil!

Smalltalk.AspectS defineClass: #AsCFlowFirstClassRSAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstClassSGAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsCounterSetTraceAspect
	superclass: #{AspectS.AsAspect}
	indexedType: #none
	private: false
	instanceVariableNames: 'trace '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Counter'!

Smalltalk.AspectS defineClass: #AsCFlowFirstInstanceRGHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsSenderSpecificAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsCFlowFirstInstanceSSAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsIntroductionWrapperTest
	superclass: #{AspectS.AsTestCase}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Introduction'!

Smalltalk.AspectS defineClass: #AsReceiverGeneralIWrapperTest
	superclass: #{AspectS.AsIntroductionWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Introduction'!

Smalltalk.AspectS defineClass: #AsSenderGeneralIWrapperTest
	superclass: #{AspectS.AsIntroductionWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Introduction'!

Smalltalk.AspectS defineClass: #AsSenderSpecificIWrapperTest
	superclass: #{AspectS.AsIntroductionWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Introduction'!

Smalltalk.AspectS defineClass: #AsPostfixVisitorAlternativeAspectTest
	superclass: #{AspectS.AsTestCase}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor Alternative'!

Smalltalk.AspectS defineClass: #AsCFlowFirstInstanceSSHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsInfixVisitorAlternativeAspect
	superclass: #{AspectS.AsAspect}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor Alternative'!

Smalltalk.AspectS defineClass: #AsCFlowFirstClassRSHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstClassRGAWrapperTest
	superclass: #{AspectS.AsAroundWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Around'!

Smalltalk.AspectS defineClass: #AsReceiverSpecificIWrapperTest
	superclass: #{AspectS.AsIntroductionWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Introduction'!

Smalltalk.AspectS defineClass: #AsCounterAutoResetAspectTest
	superclass: #{AspectS.AsCounterAspectTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Counter'!

Smalltalk.AspectS defineClass: #AsPrefixVisitorAspectTest
	superclass: #{AspectS.AsVisitorAspectTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor'!

Smalltalk.AspectS defineClass: #AsAdviceQualifier
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'attributes '
	classInstanceVariableNames: 'constraints '
	imports: ''
	category: 'AspectS-Aspects'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstClassRSHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsMethodWrapperTest
	superclass: #{AspectS.AsTestCase}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests General'!

Smalltalk.AspectS defineClass: #AsFactorial2
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Factorial'!

Smalltalk.AspectS defineClass: #AsPrefixVisitorAlternative2AspectTest
	superclass: #{AspectS.AsVisitorAlternative2AspectTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor Alternative 2'!

Smalltalk.AspectS defineClass: #AsCounterAutoResetAspect
	superclass: #{AspectS.AsAspect}
	indexedType: #none
	private: false
	instanceVariableNames: 'threshold count '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Counter'!

Smalltalk.AspectS defineClass: #AsLeaf
	superclass: #{Core.Object}
	indexedType: #none
	private: false
	instanceVariableNames: 'value '
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor'!

Smalltalk.AspectS defineClass: #AsBeforeAfterWrapperTest
	superclass: #{AspectS.AsTestCase}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsCFlowFirstClassSSBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsReceiverGeneralBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsCFlowFirstSuperSGBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter Super'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstSuperRGBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter Super'!

Smalltalk.AspectS defineClass: #AsCFlowFirstSuperRSBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter Super'!

Smalltalk.AspectS defineClass: #AsCFlowFirstSuperRGBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter Super'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstInstanceRSBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsCFlowFirstInstanceRSBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstSuperRSBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter Super'!

Smalltalk.AspectS defineClass: #AsCFlowFirstClassRGBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstSuperSGBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter Super'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstClassSSBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsCFlowFirstInstanceSGBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstClassSGBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsCFlowFirstInstanceRGBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsReceiverSpecificBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsSenderSpecificBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstInstanceSSBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsCFlowFirstClassRSBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstSuperSSBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter Super'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstClassRGBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstInstanceRGBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsCFlowFirstInstanceSSBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsCFlowFirstClassSGBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstClassRSBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsCFlowFirstSuperSSBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter Super'!

Smalltalk.AspectS defineClass: #AsCFlowAllButFirstInstanceSGBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsSenderGeneralBAWrapperTest
	superclass: #{AspectS.AsBeforeAfterWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests BeforeAfter'!

Smalltalk.AspectS defineClass: #AsAspectBB
	superclass: #{AspectS.AsAspectB}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests General'!

Smalltalk.AspectS defineClass: #AsInfixVisitorAspectTest
	superclass: #{AspectS.AsVisitorAspectTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor'!

Smalltalk.AspectS defineClass: #AsCFlowFirstInstanceSGHWrapperTest
	superclass: #{AspectS.AsHandlerWrapperTest}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Tests Handler'!

Smalltalk.AspectS defineClass: #AsWindowMousingProjectAspect
	superclass: #{AspectS.AsAspect}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples WindowMousing'!

Smalltalk.AspectS defineClass: #AsPrefixVisitorAlternative2Aspect
	superclass: #{AspectS.AsAbstractVisitorAlternative2Aspect}
	indexedType: #none
	private: false
	instanceVariableNames: ''
	classInstanceVariableNames: ''
	imports: ''
	category: 'AspectS-Examples Visitor Alternative 2'!

Smalltalk asNameSpace reorganizeFromString: '('''' #XProgramming)
(''AspectS-Name Spaces'' #AspectS)
(''Browser-Namespaces'' #Refactory)
(''CrafProcessMonitor'' #ProcessMonitorClient #ProcessMonitorRecord #ProcessMonitorService)
(''CraftedSt'' #CraftedSmalltalk)
(''Help-Namespace'' #VWHelp)
(''Net-Namespace'' #Net)
(''SLesson Base'' #A00_Intro #A01_Setup #A01_Setup_01 #A01_Setup_02 #LessonBrowserBase #LessonBrowserWithNotebook #LessonBrowser_01 #LessonBrowser_02 #LessonBrowser_03 #LessonBrowser_04 #LessonBuilder #LessonModel #LessonRunner #LessonRunnerState #LessonStep #LessonStepsBrowser #LessonTextCollector #ReadOnlyBrowserPanel #SelectionInListWithDisplay #StepCode #StepEditor #VWBaseAdaptor #VWVersion3to5Adaptor)
(''SLesson Intro Content'' #A02_LessonRunner #A02_LessonRunner_01 #A02_LessonRunner_02 #A02_LessonRunner_03 #A02_LessonRunner_04 #A02_LessonRunner_05 #A03_WhySmalltalk #A03_WhySmalltalk_01 #A03_WhySmalltalk_02 #A03_WhySmalltalk_03 #A03_WhySmalltalk_04 #B00_Fundamentals #B01_Basics #B01_Basics_005 #B01_Basics_009 #B01_Basics_03 #B01_Basics_04 #B01_Basics_05 #B01_Basics_06 #B01_Basics_07 #B01_Basics_08 #B01_Basics_09 #B01_Basics_10 #B01_Basics_11 #B02_Interaction #B02_Interaction_01 #B02_Interaction_02 #B02_Interaction_03 #B03_Output #B03_Output_01 #B03_Output_02 #B03_Output_03 #B03_Output_04 #B03_Output_05 #B03_Output_06 #B03_Output_07 #B03_Output_08 #B04_Classes #B04_Classes_01 #B04_Classes_02 #B04_Classes_03 #B04_Classes_04 #B04_Classes_05 #B05_MoreConcepts #B05_MoreConcepts_01 #B05_MoreConcepts_02 #B05_MoreConcepts_03 #B05_MoreConcepts_04 #B05_MoreConcepts_05 #E00_LibraryOne #E01_TheLibrary #E01_TheLibrary_01 #E01_TheLibrary_02 #E02_Strings #E02_Strings_01 #E02_Strings_02 #E02_Strings_03 #E03_Numbers #E03_Numbers_01 #E03_Numbers_02 #E03_Numbers_03 #E03_Numbers_04 #E03_Numbers_05 #E03_Numbers_06 #E03_Numbers_07 #E04_Blocks #E04_Blocks_01 #E04_Blocks_02 #E04_Blocks_03 #E04_Blocks_04 #E04_Blocks_05 #E05_ControlStructs #E05_ControlStructs_01 #E05_ControlStructs_02 #E05_ControlStructs_03 #E05_ControlStructs_04 #E05_ControlStructs_05 #E05_ControlStructs_06 #E05_ControlStructs_07 #E05_ControlStructs_08 #F00_LibraryTwo #F01_Collections #F01_Collections_01 #F01_Collections_02 #F01_Collections_03 #F01_Collections_04 #F01_Collections_05 #F01_Collections_06 #F01_Collections_07 #F01_Collections_08 #F02_Iterators #F02_Iterators_01 #F02_Iterators_02 #F02_Iterators_03 #F02_Iterators_04 #F02_Iterators_05 #F02_Iterators_06 #F03_Streams #F03_Streams_01 #F03_Streams_02 #F03_Streams_03 #F03_Streams_04 #F04_Files #F04_Files_01)
(''SLesson Tests'' #ContentIntegrityTest #LessonBrowserBaseTest #LessonBrowserWithNotebookTest #LessonBuilderTests #LessonBuilderTests2 #LessonModelTest #LessonStepTest #LessonTestCase #LessonTextTest #StepCodeTest #StepEditorTest)
(''SLesson Tests PreLoad'' #VWTestRunnerAdaptor)
(''SLesson XP Content'' #LessonBrowser_05 #Z00_ExtendingSLesson #Z01_SLessonBuilder #Z01_SLessonBuilder_01 #Z01_SLessonBuilder_02 #Z01_SLessonBuilder_03 #Z01_SLessonBuilder_04 #Z02_LessonModel #Z02_LessonModel_01 #Z02_LessonModel_02 #Z02_LessonModel_03 #Z02_LessonModel_04 #Z02_LessonModel_05 #Z03_CodeGeneration #Z03_CodeGeneration_01 #Z03_CodeGeneration_02 #Z07_EFridge_Demo #Z07_EFridge_Demo_01 #Z07_EFridge_Demo_02 #Z07_EFridge_Demo_03 #Z07_EFridge_Demo_04 #Z07_EFridge_Demo_05 #Z07_EFridge_Demo_06 #Z07_EFridge_Demo_07 #Z07_EFridge_Demo_08 #ZZ0_BrowserTesting #ZZ1_Browser01 #ZZ1_Browser01_01 #ZZ1_Browser01_02 #ZZ2_Browser02 #ZZ2_Browser02_01 #ZZ2_Browser02_02 #ZZ3_Browser03 #ZZ3_Browser03_01 #ZZ3_Browser03_02 #ZZ4_Browser04 #ZZ4_Browser04_01 #ZZ4_Browser04_02 #ZZ5_Browser05 #ZZ5_Browser05_01 #ZZ5_Browser05_02 #ZZ5_Browser05_03 #ZZ6_Tools #ZZ6_Tools_01)
(''SLesson XP Tests'' #LessonBrowser_05Test #LessonModelCodeLoadingTest #SLessonTestsIntializer)
(''System-Name Spaces'' #Core #Examples #External #Graphics #Kernel #OS #Root #Smalltalk #Tools #UI)
(''XML-NameSpace'' #XML)
'!


!Core.Object methodsFor: 'testing'!

isAsAdviceQualifier

	^ false!

isAsAspectClass

	^ false!

isAsCFlowPoint

	^ false!

isAsMethodWrapper

	^ false!

isBlockClosure

	^ false! !

!Core.Object methodsFor: 'aspects'!

aspectClasses

	^ self class aspectClasses!

aspects

	^ self class aspects!

wrapperClasses

	^ self class wrapperClasses!

wrappers

	self flag: #rhi. "NAME CONFLICT with AsAdvice>>wrappers!!"
	^ self class wrappers! !


Core.Object reorganizeFromString: '(''initialize-release'' #release)
(''accessing'' #at: #at:put: #basicAt: #basicAt:put: #basicSize #size #yourself)
(''changing'' #broadcast: #broadcast:with: #changed #changed: #changed:with: #changeRequest #changeRequest: #changeRequestFrom:)
(''comparing'' #= #== #hash #identityHash #isEqualTo:within:and: #~= #~~)
(''controlling'' #ifNil: #ifNil:ifNotNil: #ifNotNil: #ifNotNil:ifNil:)
(''converting'' #-> #asImmutableLiteral #asValue)
(''copying'' #basicDcopy #basicMethodDcopy #copy #dcopy #postCopy #postDcopy #shallowCopy)
(''printing'' #basicPrintOn: #basicPrintString #debugString #displayLabel #displayString #forStackDumpPrintUsing: #inspectString #isImmutableLiteral #isLiteral #printOn: #printString #storeOn: #storeString)
(''testing'' #allowsSelfDefinition #isAsAdviceQualifier #isAsAspectClass #isAsCFlowPoint #isAsMethodWrapper #isBehavior #isBindingReference #isBlockClosure #isBlockContext #isCharacters #isCharStyleCacheable #isError #isExceptionCreator #isExceptionHandler #isImmediate #isImmutable #isInteger #isLikeNameSpace #isNameSpace #isNil #isOverride #isProtocolAdaptor #isSequenceable #isSignalledException #isString #isSymbol #isVariableBinding #notNil #refersToLiteral: #respondsToArithmetic #supersedesAsTextEmphasis: #_isBehaviorOrProxy #_isCompilerErrorHandler)
(''updating'' #performUpdate: #performUpdate:with: #update: #update:with: #update:with:from: #updateRequest #updateRequest:)
(''class membership'' #changeClassTo: #changeClassToThatOf: #class #isKindOf: #isMemberOf: #respondsTo:)
(''dependents access'' #addDependent: #dependents #expressInterestIn:for:sendBack: #removeDependent: #retractInterestIn:for:)
(''dependents collection'' #asDependentsAsCollection #asDependentsWith: #asDependentsWithout:)
(''error handling'' #attemptToAssign:withIndex: #breakOn:label: #commentOnly #doesNotUnderstand: #error: #errorSignal #halt #halt: #hardHalt #messageNotUnderstoodSignal #noModificationErrorFor:index:value: #notify: #primitiveFailed #shouldNotImplement #subclassResponsibility)
(''external accessing'' #baseCType)
(''external copying'' #copyToHeap #copyToHeap16 #gcCopyToHeap #gcCopyToHeap16)
(''fileIn/Out'' #reverseByteOrder)
(''finalization'' #executor #finalize #mourn)
(''message handling'' #perform: #perform:with: #perform:with:with: #perform:with:with:with: #perform:withArguments: #performMethod: #performMethod:arguments: #performMethod:with: #performMethod:with:with: #performMethod:with:with:with:)
(''system primitives'' #allOwners #allOwnersWeakly: #allStrongOwners #allStrongOwnersWeakly: #become: #beImmutable #beMutable #firstOwner #instVarAt: #instVarAt:put: #isImmutable: #nextInstance #nextObject #oneWayBecome: #ownerAfter: #primBecome: #replaceReferencesTo:with:)
(''user interface'' #basicInspect #basicInspectorClass #browse #findGuiResourcesIn: #inspect #inspectorActions #inspectorClass #inspectorClasses #inspectorCollaborators #inspectorExtraAttributes #inspectorHierarchies)
(''tracing'' #traceFrom: #traceWalkFrom:)
(''binary storage'' #isCodeReaderEquivalentReferenceTo: #isCodeReaderEquivalentTo: #isCodeReaderEquivalentTo:within:and: #postLoad #postReadGeneralStructureOn: #readGeneralStructureOn: #storeGeneralAllocationOn: #storeGeneralStructureOn:)
(''external testing'' #hasFixedData #isFixedArgument)
(''event accessing'' #actionForEvent: #actionListForEvent: #canTriggerEvent: #eventsHandled #hasActionForEvent: #removeAction:forEvent: #removeActionsForEvent: #removeActionsSatisfying:forEvent: #removeActionsWithReceiver:forEvent: #removeAllActionsWithReceiver:)
(''event configuring'' #when:do: #when:evaluate: #when:send:to: #when:send:to:with: #when:send:to:with:with: #when:send:to:withArguments: #whenAny:do: #whenAny:evaluate: #whenAny:send:to: #whenAny:send:to:with: #whenAny:send:to:with:with: #whenAny:send:to:withArguments:)
(''event evaluating'' #evaluate #evaluateWithArguments:)
(''event triggering'' #triggerEvent: #triggerEvent:ifNotHandled: #triggerEvent:with: #triggerEvent:with:with: #triggerEvent:withArguments: #triggerEvent:withArguments:ifNotHandled:)
(''private-events'' #errorBadEvent: #errorBadSelector: #eventTable #eventTableCreate #eventTableForEdit #myEventTable #myEventTable: #releaseEventTable #setActionList:forEvent:)
(''vw5i release support'' #isObsoleteProtocol #notYetImplemented)
(''private-backward compatibility'' #subscriptBoundsError:)
(''private'' #allOwnersNoRetry: #allStrongOwnersNoRetry: #becomeNoRetry: #breakDependents #copyToHeap: #handleFailedBecome: #improperStoreError #mustBeBoolean #myDependents #myDependents: #nilFields #nonIntegerIndexError: #species #subscriptBoundsErrorFor:index: #subscriptBoundsErrorFor:index:value: #whileMutableDo:)
(''Camp Smalltalk'' #sunitAddDependent: #sunitChanged: #sunitRemoveDependent:)
(''SLesson Base'')
(''debugging'' #flag:)
(''Arbor Core adds'' #aisIsAssociation)
(''AHS Core adds'' #odbDeepRefresh #odbReadLock #odbRelease #odbReleaseLock #odbReleaseUnDirtyLock #odbWriteLock)
(''Help Core mods'' #odbDirty #odbRefresh #odbRefreshIfNotDirty)
(''aspects'' #aspectClasses #aspects #wrapperClasses #wrappers)
'!

!AspectS.AsCFlowPoint class methodsFor: 'instance creation'!

object: anObject selector: aSymbol

	^ self new
		object: anObject;
		selector: aSymbol! !

!AspectS.AsCFlowPoint methodsFor: 'accessing'!

object
	"^ <Object>"

	^ object!

object: anObject

	object := anObject.!

selector
	"^ <Symbol>"

	^ selector!

selector: aSymbol

	selector := aSymbol.! !

!AspectS.AsCFlowPoint methodsFor: 'comparing'!

= anObject

	^ anObject isAsCFlowPoint
		and: [self object == anObject object
			and: [self selector == anObject selector]]!

hash

	^ self object hash + self selector hash! !

!AspectS.AsCFlowPoint methodsFor: 'testing'!

isAsCFlowPoint

	^ true! !


!AspectS.AsNode class methodsFor: 'instance creation'!

first: aFirstAsNodeOrAsLeaf op: aSymbol second: aSecondAsNodeOrAsLeaf

	^ self new
		first: aFirstAsNodeOrAsLeaf;
		op: aSymbol;
		second: aSecondAsNodeOrAsLeaf! !

!AspectS.AsNode methodsFor: 'accessing'!

first
	"^ <AsNode | AsLeaf>"

	^ first!

first: anAsNodeOrAsLeaf

	first := anAsNodeOrAsLeaf.!

op
	"^ <Symbol>"

	^ op!

op: aSymbol

	op := aSymbol.!

second
	"^ <AsNode | AsLeaf>"

	^ second!

second: anAsNodeOrAsLeaf

	second := anAsNodeOrAsLeaf.! !


!Kernel.BlockClosure methodsFor: 'testing'!

isBlockClosure

	^ true! !


!AspectS.AsAspect class methodsFor: 'instance creation'!

new

	^ super new initialize! !

!AspectS.AsAspect class methodsFor: 'testing'!

isAsAspectClass

	^ true! !

!AspectS.AsAspect methodsFor: 'accessing'!

advice
	"^ <Collection of: AsAdvice>"

	^ advice!

advice: aCollection

	advice := aCollection.!

clientAnnotations
	"^ <IdentityDictionary key: Object value: <IdentityDictionary key: Symbol value: Object>>"

	^ clientAnnotations!

clientAnnotations: anIdentityDictionary

	clientAnnotations := anIdentityDictionary.!

installed
	"^ <Boolean>"

	^ installed!

installed: aBoolean

	installed := aBoolean.!

projects
	"^ <IdentitySet of: LightweightProjects>"

	^ projects!

projects: anIdentitySet

	projects := anIdentitySet.!

receivers
	"^ <IdentitySet of: Object>"

	^ receivers!

receivers: anIdentitySet

	receivers := anIdentitySet.!

senderClasses
	"^ <IdentitySet of: Class>"

	^ senderClasses!

senderClasses: anIdentitySet

	senderClasses := anIdentitySet.!

senders
	"^ <IdentitySet of: Object>"

	^ senders!

senders: anIdentitySet

	senders := anIdentitySet.! !

!AspectS.AsAspect methodsFor: 'adding'!

addProject: aProject

	^ self projects add: aProject!

addReceiver: anObject

	^ self receivers add: anObject!

addSender: anObject

	^ self senders add: anObject!

addSenderClass: aClass

	^ self senderClasses add: aClass! !

!AspectS.AsAspect methodsFor: 'derived accessing'!

annotationsFor: aClientObject at: aSymbol

	self flag: #rhi. "Assert that aSymbol ~~ nil!!"
	^ (self clientAnnotationsAt: aClientObject) at: aSymbol!

annotationsFor: aClientObject at: aSymbol put: anAnnotationObject

	self flag: #rhi. "Assert that aSymbol ~~ nil!!"
	^ (self clientAnnotationsAt: aClientObject) at: aSymbol put: anAnnotationObject!

clientAnnotationsAt: anObject

	^ self clientAnnotations at: anObject ifAbsentPut: [IdentityDictionary new]! !

!AspectS.AsAspect methodsFor: 'initialization'!

initialize

	self
		receivers: IdentitySet new;
		senders: IdentitySet new;
		senderClasses: IdentitySet new;
		projects: IdentitySet new;
		clientAnnotations: IdentityDictionary new;
		advice: nil;
		installed: false.! !

!AspectS.AsAspect methodsFor: 'installation'!

install

	self installed ifTrue: [self error: 'Aspect already installed.'].
	[	self
			collectAdvice;
			installAdvice;
			installed: true.
	] on: Error do: [:ex |
		self uninstall.
		self error: 'Installation of aspect failed.'].!

uninstall

	self
		uninstallAdvice;
		advice: nil;
		installed: false.! !

!AspectS.AsAspect methodsFor: 'removing'!

removeProject: aProject

	^ self projects remove: aProject ifAbsent: []!

removeReceiver: anObject

	^ self receivers remove: anObject ifAbsent: []!

removeSender: anObject

	^ self senders remove: anObject ifAbsent: []!

removeSenderClass: aClass

	^ self senderClasses remove: aClass ifAbsent: []! !

!AspectS.AsAspect methodsFor: 'testing'!

hasProject: aProject

	^ self projects includes: aProject!

hasReceiver: anObject

	^ self receivers includes: anObject!

hasSender: anObject

	^ self senders includes: anObject!

hasSenderClass: aClass

	^ self senderClasses anySatisfy: [:senderClass | aClass includesBehavior: senderClass]! !

!AspectS.AsAspect methodsFor: 'weaving'!

collectAdvice

	self advice: (self class allSelectors
		select: [:sel | sel isAdviceSelector]
		thenCollect: [:adv | self perform: adv asSymbol]).!

installAdvice

	self advice do: [:adv | adv installWith: self].!

uninstallAdvice

	self advice do: [:adv | adv uninstall].! !


!Core.Integer methodsFor: 'factorization and divisibility'!

factorial2
	"Answer the factorial of the receiver. Object-recursive."

	self = 0 ifTrue: [^ 1].
	self > 0 ifTrue: [^ self * (self - 1) factorial2].
	self error: 'Not valid for negative integers'.! !


!AspectS.AsWindowMousingAspect methodsFor: 'advice'!

adviceEventDoubleClick

	^ AsBeforeAfterAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific))
		pointcut: [
			WindowSensor withAllSubclasses
				select: [:each | each includesSelector: #eventDoubleClick:]
				thenCollect: [:each | AsJoinPointDescriptor targetClass: each targetSelector: #eventDoubleClick:]]
		beforeBlock: [:receiver :arguments :aspect :client |
			self showHeader: '>>> EventDoubleClick >>>' receiver: receiver event: arguments first]!

adviceEventEnter

	^ AsBeforeAfterAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific))
		pointcut: [
			WindowSensor withAllSubclasses
				select: [:each | each includesSelector: #eventEnter:]
				thenCollect: [:each | AsJoinPointDescriptor targetClass: each targetSelector: #eventEnter:]]
		beforeBlock: [:receiver :arguments :aspect :client |
			self showHeader: '>>> EventEnter >>>' receiver: receiver event: arguments first]!

adviceEventExit

	^ AsBeforeAfterAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific))
		pointcut: [
			WindowSensor withAllSubclasses
				select: [:each | each includesSelector: #eventExit:]
				thenCollect: [:each | AsJoinPointDescriptor targetClass: each targetSelector: #eventExit:]]
		beforeBlock: [:receiver :arguments :aspect :client |
			self showHeader: '>>> EventExit >>>' receiver: receiver event: arguments first]! !

!AspectS.AsWindowMousingAspect methodsFor: 'private'!

showHeader: aString receiver: anEventSensor event: anArray

	Transcript
		cr; show: aString;
		cr; tab; show: anEventSensor printString;
		cr; tab; show: anArray printString.! !


!AspectS.AsCounterAutoReset2Aspect methodsFor: 'accessing'!

threshold
	"^ <Integer>"

	^ threshold!

threshold: anInteger

	threshold := anInteger.! !

!AspectS.AsCounterAutoReset2Aspect methodsFor: 'adding'!

addReceiver: anObject

	super addReceiver: anObject.
	self annotationsFor: anObject at: #count put: 0.
	^ anObject! !

!AspectS.AsCounterAutoReset2Aspect methodsFor: 'advice'!

adviceAutoReset

	^ AsBeforeAfterAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverInstanceSpecific))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsCounter targetSelector: #inc)
			with: (AsJoinPointDescriptor targetClass: AsCounter targetSelector: #dec)]
		afterBlock: [:receiver :arguments :aspect :client :result |
			aspect annotationsFor: client
				at: #count
				put: (aspect annotationsFor: client at: #count) + 1.
			(self threshold = (aspect annotationsFor: client at: #count))
				ifTrue: [
					receiver n: 0.
					aspect annotationsFor: client at: #count put: 0]]! !

!AspectS.AsCounterAutoReset2Aspect methodsFor: 'initialization'!

initialize

	super initialize.
	self threshold: 0.! !


!Kernel.Context methodsFor: 'derived accessing'!

allBaseClients

	| clients context |
	clients := OrderedCollection new.
	context := thisContext baseSender.
	self flag: #rhi. "Revisit!!"
	[	[true] whileTrue: [
			clients add: context receiver.
			context := context baseSender].
	] on: MessageNotUnderstood do: [:ex | ].
	^ clients!

allBaseClientsWithSelector

	| clients context |
	clients := OrderedCollection new.
	context := thisContext baseSender.
	self flag: #rhi. "Revisit!!"
	[	[true] whileTrue: [
			clients add: context receiver -> context selector.
			context := context baseSender].
	] on: MessageNotUnderstood do: [:ex | ].
	^ clients!

baseClient

	^ self baseSender receiver!

baseSender

	| baseSender |
	baseSender := self sender.
	[baseSender receiver isAsMethodWrapper
		or: [baseSender receiver isBlockClosure
			or: [baseSender isBlockContext]]]
				whileTrue: [baseSender := baseSender sender].
	^ baseSender!

client

	^ sender receiver! !


Kernel.Context reorganizeFromString: '(''accessing'' #at: #at:put: #basicAt: #basicAt:put: #basicSize #contextStackDepth #home #homeReceiver #mclass #receiver #selector #sender #size #sourceCode #stackP)
(''accessing-PC map'' #changeToNPC #changeToVPC #nFromVPC: #nFromVPCnoFail: #vFromNPC:)
(''testing'' #canJumpSafely #hasExited #hasInterimValues #hasSender: #isBlockContext)
(''control'' #evaluateUnwind #restart #restartWith: #resume #resumeWith: #terminate #terminateTo: #unwindUpTo:)
(''hander search'' #findNextMarkedUpTo: #findNextUnwindUpTo: #skipOverUnwindingBlocks #unwindRequestorContext)
(''printing'' #printOn: #printSenderStackOn:max: #printStack)
(''user interface'' #inspectorClass #inspectorExtraAttributes)
(''error handling'' #cannotResume #cannotReturn:)
(''accessing-debugger'' #findParentContextWithHomeMethod: #findTemp:do: #getTempVar: #growBy: #intendedReceiver #localScope #messageObjects #nesting #pdpSlotAccessors #put:intoTempVar: #resizedWith: #sender: #sendersTo: #slotAccessors #slotAt: #slotAt:put: #sourceInfo: #sourceMap #supposedHome #tempAt: #tempAt:put: #tempNames #visibleSourceMap)
(''simulation-primitive support'' #doPrimitive:receiver:numArgs:boundByMethod: #result0: #result1: #skipPrimitive #tryPrimitive:receiver:numArgs:boundByMethod:)
(''simulation-primitives'' #primBlockValue:arguments: #primBlockValue:numArgs: #primFlushVMmethodCache: #primFlushVMmethodCacheEntries: #primObjectPerform:selector:arguments: #primPerform:selector:arguments: #primPerform:selector:numArgs: #primPerformMethod: #primSuspend: #primUnlinkedCallCExternalMethod:receiver:numArgs: #primWait:)
(''simulation-control'' #callPrimitive:numArgs: #jump: #jump:if: #loopHead #makeCopyingBlock:count: #makeFullBlock: #makeFullCopyingBlock:count: #methodPrimitive: #noOp #primitiveReturn #returnTop #send:numArgs: #sendNoCheck:numArgs: #sendNonImmediate:numArgs: #sendSuper:numArgs:)
(''simulation-data movement'' #dupFirst #dupLast #dupNext #pop #pushConstant: #pushContext #pushInst: #pushLocal: #pushLocalIndirect:index: #pushNewArray: #pushReceiver #pushStatic: #storeInst: #storeLocal: #storePopLocalIndirect:index:)
(''simulation-debugger'' #completeCallee: #pdpCompleteCallee: #pdpStepUntilPC: #pdpStepUntilVisibleEffect #safelyInterpretNextInstructionFor: #send #sendIntoBlockStartingWithCallee: #step #stepForever #stepUntilHaveNPC #stepUntilPC: #stepUntilProceedable #stepUntilSkipPC: #stepUntilVisibleEffect)
(''private-simulation'' #dup #findMethod:class:ifFound: #isSendLoop #push: #return: #runMethod:numArgs:contextClass: #send:receiver:class:super:numArgs: #top #topPop)
(''private-debugger'' #blockContextFrom:args: #checkHandlerBlock:value: #clearStack #initialStackDepthForProbes #privateReplaceArgAt:put: #probeMethod: #removeContextsTo: #replaceArgAt:put: #restackMessage:to: #sendFast:receiver:numArgs: #storeTop: #uparrowReturn)
(''private-reflection protocol'' #_object:at: #_object:at:put: #_object:eqeq: #_object:instVarAt: #_object:instVarAt:put: #_object:perform:withArguments: #_objectClass: #_objectSize:)
(''private-accessing'' #countTemps:do:elseDo: #findTemp:do:elseDo: #localAt: #localAt:put: #localSize)
(''tracing'' #traceFrom:)
(''copying'' #postCopy)
(''system primitives'' #instVarAt: #instVarAt:put:)
(''private-initialization'' #setSender:receiver:method:arguments:size:)
(''derived accessing'' #allBaseClients #allBaseClientsWithSelector #baseClient #baseSender #client)
'!

!AspectS.AsFactorial2TraceAspect methodsFor: 'accessing'!

trace
	"^ <String>"

	^ trace!

trace: aString

	trace := aString.!

traceAllButFirst
	"^ <String>"

	^ traceAllButFirst!

traceAllButFirst: aString

	traceAllButFirst := aString.!

traceFirst
	"^ <String>"

	^ traceFirst!

traceFirst: aString

	traceFirst := aString.! !

!AspectS.AsFactorial2TraceAspect methodsFor: 'advice'!

adviceFactorialInOut

	^ AsBeforeAfterAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsFactorial2 targetSelector: #factorial:)]
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'factorial2-in: ', arguments first printString.
			self trace: self trace, msg.
			"Transcript show: msg"]
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'factorial2-out(', arguments first printString, '): ',
				return printString.
			self trace: self trace, msg.
			"Transcript show: msg"]!

adviceFactorialInOutAllButFirst

	^ AsBeforeAfterAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific cfAllButFirstInstance))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsFactorial2 targetSelector: #factorial:)]
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, '*factorial2-in: ', arguments first printString.
			self traceAllButFirst: self traceAllButFirst, msg.
			"Transcript show: msg"]
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, '*factorial2-out(', arguments first printString, '): ',
				return printString.
			self traceAllButFirst: self traceAllButFirst, msg.
			"Transcript show: msg"]!

adviceFactorialInOutFirst

	^ AsBeforeAfterAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific cfFirstInstance))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsFactorial2 targetSelector: #factorial:)]
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, '#factorial2-in: ', arguments first printString.
			self traceFirst: self traceFirst, msg.
			"Transcript show: msg"]
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, '#factorial2-out(', arguments first printString, '): ',
				return printString.
			self traceFirst: self traceFirst, msg.
			"Transcript show: msg"]! !

!AspectS.AsFactorial2TraceAspect methodsFor: 'initialization'!

initialize

	super initialize.
	self
		trace: String new;
		traceFirst: String new;
		traceAllButFirst: String new.! !


!AspectS.AsTestCase class methodsFor: 'testing'!

shouldInheritSelectors
	"Answer true to NOT inherit selectors from superclasses."

	^ false! !

!AspectS.AsTestCase methodsFor: 'accessing'!

aspekt
	"^ <AsAspect>"

	^ aspekt!

aspekt: anAsAspect

	aspekt := anAsAspect.!

result
	"^ <Object>"

	^ result!

result: anObject

	result := anObject.!

trace
	"^ <WriteStream on: String>"

	^ trace!

trace: aWriteStream

	trace := aWriteStream.! !


!AspectS.AsVisitorAlternative2AspectTest methodsFor: 'running'!

setUp

	self aspekt: self aspectClass new.
	self aspekt install.!

tearDown

	self aspekt uninstall.
	self aspekt: nil.! !

!AspectS.AsVisitorAlternative2AspectTest methodsFor: 'private'!

buildTree

	^ AsNode
		first: (AsNode
			first: (AsNode
				first: (AsLeaf value: 1)
				op: #+
				second: (AsLeaf value: 2))
			op: #*
			second: (AsNode
				first: (AsLeaf value: 3)
				op: #-
				second: (AsLeaf value: 4)))
		op: #/
		second: (AsLeaf value: 5)! !


!AspectS.AsPostfixVisitorAlternative2AspectTest methodsFor: 'running'!

testPostfixVisitorAlternative

	self assert: self expectedTrace = self buildTree printPostfix.! !

!AspectS.AsPostfixVisitorAlternative2AspectTest methodsFor: 'private'!

aspectClass

	^ AsPostfixVisitorAlternative2Aspect!

expectedTrace

	^ '(((1 2 +) (3 4 -) *) 5 /)'! !



!AspectS.AsCounterAutoReset2AspectTest methodsFor: 'running'!

testAutoReset

	| counter aspect |
	counter := AsCounter new.
	aspect := self aspectClass new.
	aspect install.
	aspect threshold: 10.
	aspect addReceiver: counter.
	self assert: (aspect annotationsFor: counter at: #count) = 0.
	self assert: counter n = 0.
	counter inc; inc; inc; inc; inc; inc; inc; dec.
	self assert: counter n = 6.
	self assert: (aspect annotationsFor: counter at: #count) = 8.
	counter dec; inc.
	self assert: counter n = 0.
	self assert: (aspect annotationsFor: counter at: #count) = 0.
	counter dec; dec; dec; dec; dec; dec; dec; dec; dec.
	self assert: counter n = -9.
	self assert: (aspect annotationsFor: counter at: #count) = (aspect threshold - 1).
	counter dec.
	self assert: counter n = 0.
	self assert: (aspect annotationsFor: counter at: #count) = 0.
	aspect removeReceiver: counter.
	aspect uninstall.!

testAutoReset2

	| counter1 counter2 aspect |
	counter1 := AsCounter new.
	counter2 := AsCounter new.
	aspect := self aspectClass new.
	aspect install.
	aspect threshold: 10.
	aspect addReceiver: counter1.
	aspect addReceiver: counter2.
	self assert: (aspect annotationsFor: counter1 at: #count) = 0.
	self assert: (aspect annotationsFor: counter2 at: #count) = 0.
	self assert: counter1 n = 0.
	self assert: counter2 n = 0.
	counter1 inc; inc; inc; inc; inc; inc; inc; dec.
	counter2 inc; inc; inc; inc; inc; inc; inc; dec.
	self assert: counter1 n = 6.
	self assert: counter2 n = 6.
	self assert: (aspect annotationsFor: counter1 at: #count) = 8.
	self assert: (aspect annotationsFor: counter2 at: #count) = 8.
	counter1 dec; inc.
	counter2 dec; inc.
	self assert: counter1 n = 0.
	self assert: counter2 n = 0.
	self assert: (aspect annotationsFor: counter1 at: #count) = 0.
	self assert: (aspect annotationsFor: counter2 at: #count) = 0.
	counter1 dec; dec; dec; dec; dec; dec; dec; dec; dec.
	counter2 dec; dec; dec; dec; dec; dec; dec; dec; dec.
	self assert: counter1 n = -9.
	self assert: counter2 n = -9.
	self assert: (aspect annotationsFor: counter1 at: #count) = (aspect threshold - 1).
	self assert: (aspect annotationsFor: counter2 at: #count) = (aspect threshold - 1).
	counter1 dec.
	counter2 dec.
	self assert: counter1 n = 0.
	self assert: counter2 n = 0.
	self assert: (aspect annotationsFor: counter1 at: #count) = 0.
	self assert: (aspect annotationsFor: counter2 at: #count) = 0.
	aspect removeReceiver: counter1.
	aspect removeReceiver: counter2.
	aspect uninstall.!

testAutoReset3

	| counter1 counter2 aspect |
	counter1 := AsCounter new.
	counter2 := AsCounter new.
	aspect := self aspectClass new.
	aspect install.
	aspect threshold: 10.
	aspect addReceiver: counter1.
	aspect addReceiver: counter2.
	self assert: (aspect annotationsFor: counter1 at: #count) = 0.
	self assert: (aspect annotationsFor: counter2 at: #count) = 0.
	self assert: counter1 n = 0.
	self assert: counter2 n = 0.
	counter1 inc; inc; inc; inc; inc; inc; inc; dec.
	counter2 inc; inc; inc; inc; inc; inc; inc; dec.
	self assert: counter1 n = 6.
	self assert: counter2 n = 6.
	self assert: (aspect annotationsFor: counter1 at: #count) = 8.
	self assert: (aspect annotationsFor: counter2 at: #count) = 8.
	counter1 dec; inc.
	counter2 dec; inc.
	self assert: counter1 n = 0.
	self assert: counter2 n = 0.
	self assert: (aspect annotationsFor: counter1 at: #count) = 0.
	self assert: (aspect annotationsFor: counter2 at: #count) = 0.
	counter1 dec; dec; dec; dec; dec; dec; dec; dec; dec.
	counter2 dec; dec; dec; dec; dec; dec; dec; dec; inc.
	self assert: counter1 n = -9.
	self assert: counter2 n = -7.
	self assert: (aspect annotationsFor: counter1 at: #count) = (aspect threshold - 1).
	self assert: (aspect annotationsFor: counter2 at: #count) = (aspect threshold - 1).
	counter1 dec.
	counter2 dec.
	self assert: counter1 n = 0.
	self assert: counter2 n = 0.
	self assert: (aspect annotationsFor: counter1 at: #count) = 0.
	self assert: (aspect annotationsFor: counter2 at: #count) = 0.
	aspect removeReceiver: counter1.
	aspect removeReceiver: counter2.
	aspect uninstall.! !

!AspectS.AsCounterAutoReset2AspectTest methodsFor: 'private'!

aspectClass

	^ AsCounterAutoReset2Aspect! !



!AspectS.AsAdviceQualifierTest methodsFor: 'running'!

testAttributesNil

	| qualifier |
	qualifier := AsAdviceQualifier new.
	self assert: qualifier attributes isNil.
	self
		should: [qualifier validate]
		raise: Error.!

testDuplicateAttributes

	| qualifier |
	qualifier := AsAdviceQualifier attributes: #(a a a b).
	self assert: qualifier attributes notNil.
	self assert: qualifier attributes size = 2.
	self assert: (qualifier attributes includes: #a).
	self assert: (qualifier attributes includes: #b).!

testMultipleSenderOrReceiverAttributes

	| qualifier |
	qualifier := AsAdviceQualifier attributes: #(
			receiverClassSpecific receiverInstanceSpecific
			senderClassSpecific senderInstanceSpecific
		).
	self assert: qualifier attributes notNil.
	self assert: qualifier attributes size = 4.
	self
		should: [qualifier validate]
		raise: Error.!

testNoAttributes

	| qualifier |
	qualifier := AsAdviceQualifier attributes: #().
	self assert: qualifier attributes notNil.
	self assert: qualifier attributes isEmpty.
	self
		should: [qualifier validate]
		raise: Error.!

testValidAttributes

	| qualifier |
	qualifier := AsAdviceQualifier attributes: #(
			receiverClassSpecific receiverInstanceSpecific
			senderClassSpecific senderInstanceSpecific
			cfFirstClass cfAllButFirstClass
			cfFirstInstance cfAllButFirstInstance
			cfFirstSuper cfAllButFirstSuper
			projectSpecific
		). "AsMethodWrapper protoActivators keys."
	self assert: qualifier attributes notNil.
	self assert: qualifier attributes size = AsMethodWrapper protoActivators keys size.
	self assert: (qualifier attributes asSet equals: AsMethodWrapper protoActivators keys asSet).! !


!AspectS.AsAbstractVisitorAlternative2Aspect methodsFor: 'advice'!

adviceVisitLeaf

	^ AsIntroductionAdvice
		qualifier: self qualifier
		pointcut: self leafPointcut
		introBlock: [:receiver :arguments :aspect :client | self leafIntro: receiver]!

adviceVisitNode

	^ AsIntroductionAdvice
		qualifier: self qualifier
		pointcut: self nodePointcut
		introBlock: [:receiver :arguments :aspect :client | self nodeIntro: receiver]! !

!AspectS.AsAbstractVisitorAlternative2Aspect methodsFor: 'intros'!

leafIntro: anAsLeaf

	^ anAsLeaf value printString!

nodeIntro: anAsNode

	^ self subclassResponsibility! !

!AspectS.AsAbstractVisitorAlternative2Aspect methodsFor: 'pointcut'!

leafPointcut

	^ [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsLeaf targetSelector: self printSelector)]!

nodePointcut

	^ [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsNode targetSelector: self printSelector)]!

printSelector

	self subclassResponsibility.! !

!AspectS.AsAbstractVisitorAlternative2Aspect methodsFor: 'qualifier'!

qualifier

	^ AsAdviceQualifier attributes: #(receiverClassSpecific)! !


!AspectS.AsPostfixVisitorAlternative2Aspect methodsFor: 'intros'!

nodeIntro: anAsNode

	^ '(', anAsNode first printPostfix, ' ', anAsNode second printPostfix, ' ', anAsNode op asString, ')'! !

!AspectS.AsPostfixVisitorAlternative2Aspect methodsFor: 'pointcut'!

printSelector

	^ #printPostfix! !


!AspectS.AsCounterThresholdAspectTest methodsFor: 'running'!

testCounting

	| counter aspect |
	counter := AsCounter new.
	aspect := self aspectClass new.
	aspect install.
	self assert: aspect threshold = 0.
	self assert: counter n = 0.
	self assert: aspect lastPass = #NotYet.
	counter inc.
	self assert: aspect lastPass = #NotYet.
	counter dec.
	self assert: aspect lastPass = #CountingDown.
	counter inc.
	self assert: aspect lastPass = #CountingDown.
	counter dec; dec; dec; inc.
	self assert: aspect lastPass = #CountingDown.
	counter inc.
	self assert: aspect lastPass = #CountingUp.
	aspect uninstall.
	counter inc; dec.
	self assert: aspect lastPass = #CountingUp.
	self assert: counter n = aspect threshold.!

testCounting5

	| counter aspect |
	counter := AsCounter new.
	aspect := self aspectClass new.
	aspect install.
	aspect threshold: 5.
	self assert: aspect threshold = 5.
	self assert: counter n = 0.
	self assert: aspect lastPass = #NotYet.
	counter inc; inc; inc; inc; inc.
	self assert: aspect lastPass = #CountingUp.
	counter inc; dec.
	self assert: aspect lastPass = #CountingDown.
	counter inc.
	self assert: aspect lastPass = #CountingDown.
	counter dec; dec; dec; inc.
	self assert: aspect lastPass = #CountingDown.
	counter inc.
	self assert: aspect lastPass = #CountingUp.
	aspect uninstall.
	counter inc; dec.
	self assert: aspect lastPass = #CountingUp.
	self assert: counter n = aspect threshold.! !

!AspectS.AsCounterThresholdAspectTest methodsFor: 'private'!

aspectClass

	^ AsCounterThresholdAspect! !


!AspectS.AsCounterThresholdAspect methodsFor: 'accessing'!

lastPass
	"^ <Symbol> #(#NotYet #CountingUp #CountingDown)"

	^ lastPass!

lastPass: aSymbol

	lastPass := aSymbol.!

threshold
	"^ <Integer>"

	^ threshold!

threshold: anInteger

	threshold := anInteger.! !

!AspectS.AsCounterThresholdAspect methodsFor: 'advice'!

adviceThresholdPassedCountingDown

	^ AsBeforeAfterAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsCounter targetSelector: #dec)]
		afterBlock: [:receiver :arguments :aspect :client :return |
			(self threshold = receiver n) ifTrue: [self lastPass: #CountingDown]]!

adviceThresholdPassedCountingUp

	^ AsBeforeAfterAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsCounter targetSelector: #inc)]
		afterBlock: [:receiver :arguments :aspect :client :return |
			(self threshold = receiver n) ifTrue: [self lastPass: #CountingUp]]! !

!AspectS.AsCounterThresholdAspect methodsFor: 'initialization'!

initialize

	super initialize.
	self
		threshold: 0;
		lastPass: #NotYet.! !


!AspectS.AsAbstractVisitorAspect methodsFor: 'accessing'!

trace
	"^ <WriteStream on: String>"

	^ trace!

trace: aWriteStream

	trace := aWriteStream.! !

!AspectS.AsAbstractVisitorAspect methodsFor: 'advice'!

adviceVisitLeaf

	^ AsIntroductionAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsLeaf targetSelector: #acceptVisitor:)]
		introBlock: [:receiver :arguments :aspect :client |
			arguments first visitLeaf: receiver]!

adviceVisitNode

	^ AsIntroductionAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsNode targetSelector: #acceptVisitor:)]
		introBlock: [:receiver :arguments :aspect :client |
			arguments first visitNode: receiver]! !

!AspectS.AsAbstractVisitorAspect methodsFor: 'initialization'!

initialize

	super initialize.
	self trace: (WriteStream on: String new).! !

!AspectS.AsAbstractVisitorAspect methodsFor: 'visiting'!

visitLeaf: anAsLeaf

	self trace nextPutAll: anAsLeaf value printString.!

visitNode: anAsNode

	self subclassResponsibility.! !


!AspectS.AsInfixVisitorAspect methodsFor: 'visiting'!

visitNode: anAsNode

	self trace nextPutAll: '('.
	anAsNode first acceptVisitor: self.
	self trace nextPutAll: ' ', anAsNode op asString, ' '.
	anAsNode second acceptVisitor: self.
	self trace nextPutAll: ')'.! !


!AspectS.AsPostfixVisitorAspect methodsFor: 'visiting'!

visitNode: anAsNode

	self trace nextPutAll: '('.
	anAsNode first acceptVisitor: self.
	self trace nextPutAll: ' '.
	anAsNode second acceptVisitor: self.
	self trace nextPutAll: ' ', anAsNode op asString.
	self trace nextPutAll: ')'.! !


!AspectS.AsInfixVisitorAlternativeAspectTest methodsFor: 'running'!

testInfixVisitorAlternative

	| tree infixAspect |
	tree := self buildTree.
	infixAspect := self aspectClass new.
	self should: [tree printInfix] raise: Error.
	infixAspect install.
	self assert: self expectedTrace = tree printInfix.
	infixAspect uninstall.
	self should: [tree printInfix] raise: Error.! !

!AspectS.AsInfixVisitorAlternativeAspectTest methodsFor: 'private'!

aspectClass

	^ AsInfixVisitorAlternativeAspect!

buildTree

	^ AsNode
		first: (AsNode
			first: (AsNode
				first: (AsLeaf value: 1)
				op: #+
				second: (AsLeaf value: 2))
			op: #*
			second: (AsNode
				first: (AsLeaf value: 3)
				op: #-
				second: (AsLeaf value: 4)))
		op: #/
		second: (AsLeaf value: 5)!

expectedTrace

	^ '(((1 + 2) * (3 - 4)) / 5)'! !


!AspectS.AsAroundWrapperTest methodsFor: 'running'!

testClassInstVars

	self assert: self wrapperClass class instVarNames size = 0.
	self assert: self wrapperClass classVarNames size = 0.

	self assert: self wrapperClass protoMethods notNil.
	self assert: (self wrapperClass protoMethods isMemberOf: Dictionary).!

testNoProtoInstanceCount

	| allInstCount protoInstCount |
	self flag: #rhi. "VW?: self wrapperClass tempNameCache: nil."
	ObjectMemory garbageCollect.
	allInstCount := self wrapperClass allInstances size.
	protoInstCount := self wrapperClass protoMethods size.
	self assert: (allInstCount - protoInstCount) = 0.!

testSequenceWrappers

	| method wrapper wrapperA wrapperBA wrapperH |
	method := AsA compiledMethodAt: #mOne.
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	wrapperA := AsAroundWrapper on: #mOne inClass: AsA.
	wrapperBA := AsBeforeAfterWrapper on: #mOne inClass: AsA.
	wrapperH := AsHandlerWrapper on: #mOne inClass: AsA.
	self assert: (method isMemberOf: CompiledMethod).
	wrapper install.
	self assert: (AsA compiledMethodAt: #mOne) == wrapper.
	self assert: wrapper clientMethod == method.
	wrapperA install.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperA.
	self assert: wrapperA clientMethod == wrapper.
	self assert: wrapper clientMethod == method.
	wrapperBA install.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperA.
	self assert: wrapperA clientMethod == wrapper.
	self assert: wrapper clientMethod == wrapperBA.
	self assert: wrapperBA clientMethod == method.
	wrapperH install.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperA.
	self assert: wrapperA clientMethod == wrapper.
	self assert: wrapper clientMethod == wrapperBA.
	self assert: wrapperBA clientMethod == wrapperH.
	self assert: wrapperH clientMethod == method.
	wrapperH uninstall.
	wrapperBA uninstall.
	wrapperA uninstall.
	wrapper uninstall.
	self assert: (AsA compiledMethodAt: #mOne) == method.! !

!AspectS.AsAroundWrapperTest methodsFor: 'private'!

wrapperClass

	^ AsAroundWrapper! !


!AspectS.AsCFlowAllButFirstInstanceSGAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance callNTimes: 5).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance callNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance callNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance createAndCallNTimes: 5).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowAllButFirstInstanceSGAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ ''!

expectedMethodRecursionTrace3

	^ '
callNTimes-in: 4
callNTimes-in: 3
callNTimes-in: 2
callNTimes-in: 1
callNTimes-in: 0
callNTimes-out(0): 0
callNTimes-out(1): 1
callNTimes-out(2): 3
callNTimes-out(3): 6
callNTimes-out(4): 10'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

expectedObjectRecursionTrace3

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderClassSpecificActivator;
		add: self wrapperClass cfAllButFirstInstanceActivator.! !


!AspectS.AsSenderGeneralAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0.!

testInstallInstantiateUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		install.
	instance := AsA new.
	instance mOne.
	wrapper uninstall.
	instance mOne.!

testInstallUninstall

	| wrapper |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).
	wrapper
		aspect: self aspekt;
		install.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: self wrapperClass).
	wrapper uninstall.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).!

testInstantiateInstallUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	instance := AsA new.
	instance mOne.
	wrapper
		aspect: self aspekt;
		install.
	instance mOne.
	wrapper uninstall.
	instance mOne.!

testNoSender

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return |
			arguments at: 1 put: arguments first * 2.
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			return squared];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance addToX: 3).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: instance x = 3.
	self assert: self result = 3.!

testSender

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return |
			arguments at: 1 put: arguments first * 2.
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			return squared];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance addToX: 3).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: instance x = 6.
	self assert: self result = 36.!

testSenderMoreGeneralClass

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return |
			arguments at: 1 put: arguments first * 2.
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			return squared];
		install.
	self aspekt addSenderClass: self class superclass.
	self result: (instance addToX: 3).
	self aspekt removeSenderClass: self class superclass.
	wrapper uninstall.
	self assert: instance x = 6.
	self assert: self result = 36.!

testSenderWrongClass

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return |
			arguments at: 1 put: arguments first * 2.
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			return squared];
		install.
	self aspekt addSenderClass: Compiler.
	self result: (instance addToX: 3).
	self aspekt removeSenderClass: Compiler.
	wrapper uninstall.
	self assert: instance x = 3.
	self assert: self result = 3.! !

!AspectS.AsSenderGeneralAWrapperTest methodsFor: 'private'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass senderClassSpecificActivator.! !


!AspectS.AsCFlowFirstClassRGAWrapperTest methodsFor: 'running'!

setUp

	self
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.! !

!AspectS.AsCFlowFirstClassRGAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ '
callNTimes-in: 5
callNTimes-out(5): 15'!

expectedObjectRecursionTrace

	^ '
createAndCallNTimes-in: 5
createAndCallNTimes-out(5): 15'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverClassSpecificActivator;
		add: self wrapperClass cfFirstClassActivator.! !


!AspectS.AsCFlowFirstClassSSAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance callNTimes: 5).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSender: self.
	self result: (instance callNTimes: 5).
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSender: instance.
	self result: (instance callNTimes: 5).
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance createAndCallNTimes: 5).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSender: self.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSender: instance.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowFirstClassSSAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
callNTimes-in: 5
callNTimes-out(5): 15'!

expectedMethodRecursionTrace3

	^ ''!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndCallNTimes-in: 5
createAndCallNTimes-out(5): 15'!

expectedObjectRecursionTrace3

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderInstanceSpecificActivator;
		add: self wrapperClass cfFirstClassActivator.! !


!AspectS.AsCFlowAllButFirstInstanceRSAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.! !

!AspectS.AsCFlowAllButFirstInstanceRSAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
callNTimes-in: 4
callNTimes-in: 3
callNTimes-in: 2
callNTimes-in: 1
callNTimes-in: 0
callNTimes-out(0): 0
callNTimes-out(1): 1
callNTimes-out(2): 3
callNTimes-out(3): 6
callNTimes-out(4): 10'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverInstanceSpecificActivator;
		add: self wrapperClass cfAllButFirstInstanceActivator.! !


!AspectS.AsCFlowAllButFirstInstanceSSAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance callNTimes: 5).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSender: self.
	self result: (instance callNTimes: 5).
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSender: instance.
	self result: (instance callNTimes: 5).
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance createAndCallNTimes: 5).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowAllButFirstInstanceSSAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ ''!

expectedMethodRecursionTrace3

	^ '
callNTimes-in: 4
callNTimes-in: 3
callNTimes-in: 2
callNTimes-in: 1
callNTimes-in: 0
callNTimes-out(0): 0
callNTimes-out(1): 1
callNTimes-out(2): 3
callNTimes-out(3): 6
callNTimes-out(4): 10'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

expectedObjectRecursionTrace3

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderInstanceSpecificActivator;
		add: self wrapperClass cfAllButFirstInstanceActivator.! !


!AspectS.AsCFlowAllButFirstClassSSAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance callNTimes: 5).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSender: self.
	self result: (instance callNTimes: 5).
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSender: instance.
	self result: (instance callNTimes: 5).
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance createAndCallNTimes: 5).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSender: self.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSender: instance.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowAllButFirstClassSSAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ ''!

expectedMethodRecursionTrace3

	^ '
callNTimes-in: 4
callNTimes-in: 3
callNTimes-in: 2
callNTimes-in: 1
callNTimes-in: 0
callNTimes-out(0): 0
callNTimes-out(1): 1
callNTimes-out(2): 3
callNTimes-out(3): 6
callNTimes-out(4): 10'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

expectedObjectRecursionTrace3

	^ '
createAndCallNTimes-in: 4
createAndCallNTimes-out(4): 10'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderInstanceSpecificActivator;
		add: self wrapperClass cfAllButFirstClassActivator.! !


!AspectS.AsCFlowFirstInstanceSGAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance callNTimes: 5).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance callNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance callNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance createAndCallNTimes: 5).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowFirstInstanceSGAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
callNTimes-in: 5
callNTimes-out(5): 15'!

expectedMethodRecursionTrace3

	^ ''!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndCallNTimes-in: 5
createAndCallNTimes-out(5): 15'!

expectedObjectRecursionTrace3

	^ '
createAndCallNTimes-in: 4
createAndCallNTimes-in: 3
createAndCallNTimes-in: 2
createAndCallNTimes-in: 1
createAndCallNTimes-in: 0
createAndCallNTimes-out(0): 0
createAndCallNTimes-out(1): 1
createAndCallNTimes-out(2): 3
createAndCallNTimes-out(3): 6
createAndCallNTimes-out(4): 10'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderClassSpecificActivator;
		add: self wrapperClass cfFirstInstanceActivator.! !


!AspectS.AsCFlowFirstInstanceRGAWrapperTest methodsFor: 'running'!

setUp

	self
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.! !

!AspectS.AsCFlowFirstInstanceRGAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ '
callNTimes-in: 5
callNTimes-out(5): 15'!

expectedObjectRecursionTrace

	^ '
createAndCallNTimes-in: 5
createAndCallNTimes-in: 4
createAndCallNTimes-in: 3
createAndCallNTimes-in: 2
createAndCallNTimes-in: 1
createAndCallNTimes-in: 0
createAndCallNTimes-out(0): 0
createAndCallNTimes-out(1): 1
createAndCallNTimes-out(2): 3
createAndCallNTimes-out(3): 6
createAndCallNTimes-out(4): 10
createAndCallNTimes-out(5): 15'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverClassSpecificActivator;
		add: self wrapperClass cfFirstInstanceActivator.! !


!AspectS.AsPostfixVisitorAlternativeAspect methodsFor: 'advice'!

adviceVisitLeaf

	^ AsIntroductionAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsLeaf targetSelector: #printPostfix)]
		introBlock: [:receiver :arguments :aspect :client |
			receiver value printString]!

adviceVisitNode

	^ AsIntroductionAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsNode targetSelector: #printPostfix)]
		introBlock: [:receiver :arguments :aspect :client |
			'(', receiver first printPostfix, ' ',
				receiver second printPostfix, ' ',
					receiver op asString, ')']! !


!AspectS.AsReceiverSpecificAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0.!

testAround

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #x: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			arguments at: 1 put: arguments first * 2.
			clientMethod valueWithReceiver: receiver arguments: arguments.
			thisContext baseClient x squared];
		install.
	self result: (instance x: 3).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: instance x = 3.
	self assert: self result = instance.!

testAround2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #x: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			arguments at: 1 put: arguments first * 2.
			clientMethod valueWithReceiver: receiver arguments: arguments.
			thisContext baseClient x squared];
		install.
	self result: (instance x: 3).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: instance x = 6.
	self assert: self result = 36.!

testAroundEven

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #x: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			arguments first even
				ifTrue: [clientMethod valueWithReceiver: receiver arguments: arguments]];
		install.
	instance x: 3.
	self assert: instance x = 3.
	instance x: 4.
	self assert: instance x = 4.
	instance x: 5.
	self assert: instance x = 5.
	instance x: 6.
	self assert: instance x = 6.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"!

testAroundEven2

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #x: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			arguments first even
				ifTrue: [clientMethod valueWithReceiver: receiver arguments: arguments]];
		install.
	instance x: 3.
	self assert: instance x = 0.
	instance x: 4.
	self assert: instance x = 4.
	instance x: 5.
	self assert: instance x = 4.
	instance x: 6.
	self assert: instance x = 6.
	wrapper uninstall.
	self aspekt removeReceiver: instance.!

testAroundReturn

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return |
			arguments at: 1 put: arguments first * 2.
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			return squared];
		install.
	self result: (instance addToX: 3).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: instance x = 3.
	self assert: self result = 3.!

testAroundReturn2

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return |
			arguments at: 1 put: arguments first * 2.
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			return squared];
		install.
	self result: (instance addToX: 3).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: instance x = 6.
	self assert: self result = 36.!

testAroundShadow

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #x: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod | ];
		install.
	instance x: 3.
	self assert: instance x = 3.
	instance x: 4.
	self assert: instance x = 4.
	instance x: 5.
	self assert: instance x = 5.
	instance x: 6.
	self assert: instance x = 6.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"!

testAroundShadow2

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #x: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod | ];
		install.
	instance x: 3.
	self assert: instance x = 0.
	instance x: 4.
	self assert: instance x = 0.
	instance x: 5.
	self assert: instance x = 0.
	instance x: 6.
	self assert: instance x = 0.
	wrapper uninstall.
	self aspekt removeReceiver: instance.!

testInstallInstantiateUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		install.
	instance := AsA new.
	instance mOne.
	wrapper uninstall.
	instance mOne.!

testInstallUninstall

	| wrapper |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		install.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: self wrapperClass).
	wrapper uninstall.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).!

testInstantiateInstallUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	instance := AsA new.
	instance mOne.
	wrapper
		aspect: self aspekt;
		install.
	instance mOne.
	wrapper uninstall.
	instance mOne.!

testNonLocalReturn

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #setXNonLocalReturn: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			clientMethod valueWithReceiver: receiver arguments: arguments.
			instance x: 7];
		install.
	instance setXNonLocalReturnInteger: 3.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: instance x = 3.!

testNonLocalReturn2

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #setXNonLocalReturn: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			clientMethod valueWithReceiver: receiver arguments: arguments.
			instance x: 7];
		install.
	instance setXNonLocalReturnInteger: 3.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: instance x = 3.!

testNonLocalReturnEnsure

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #setXNonLocalReturn: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			[	clientMethod
					valueWithReceiver: receiver
					arguments: arguments.
			] ensure: [instance x: 7]];
		install.
	instance setXNonLocalReturnInteger: 3.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: instance x = 3.!

testNonLocalReturnEnsure2

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #setXNonLocalReturn: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			[	clientMethod
					valueWithReceiver: receiver
					arguments: arguments.
			] ensure: [instance x: 7]];
		install.
	instance setXNonLocalReturnInteger: 3.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: instance x = 7.! !

!AspectS.AsReceiverSpecificAWrapperTest methodsFor: 'private'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass receiverInstanceSpecificActivator.! !


!AspectS.AsFactorialTraceAspect methodsFor: 'accessing'!

trace
	"^ <String>"

	^ trace!

trace: aString

	trace := aString.!

traceAllButFirst
	"^ <String>"

	^ traceAllButFirst!

traceAllButFirst: aString

	traceAllButFirst := aString.!

traceFirst
	"^ <String>"

	^ traceFirst!

traceFirst: aString

	traceFirst := aString.! !

!AspectS.AsFactorialTraceAspect methodsFor: 'advice'!

adviceFactorialInOut

	^ AsBeforeAfterAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: Integer targetSelector: #factorial2)]
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'factorial-in: ', receiver printString.
			self trace: self trace, msg.
			"Transcript show: msg"]
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'factorial-out(', receiver printString, '): ', return printString.
			self trace: self trace, msg.
			"Transcript show: msg"]!

adviceFactorialInOutAllButFirst

	^ AsBeforeAfterAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific cfAllButFirstClass))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: Integer targetSelector: #factorial2)]
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, '*factorial-in: ', receiver printString.
			self traceAllButFirst: self traceAllButFirst, msg.
			"Transcript show: msg"]
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, '*factorial-out(', receiver printString, '): ', return printString.
			self traceAllButFirst: self traceAllButFirst, msg.
			"Transcript show: msg"]!

adviceFactorialInOutFirst

	^ AsBeforeAfterAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific cfFirstClass))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: Integer targetSelector: #factorial2)]
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, '#factorial-in: ', receiver printString.
			self traceFirst: self traceFirst, msg.
			"Transcript show: msg"]
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, '#factorial-out(', receiver printString, '): ', return printString.
			self traceFirst: self traceFirst, msg.
			"Transcript show: msg"]! !

!AspectS.AsFactorialTraceAspect methodsFor: 'initialization'!

initialize

	super initialize.
	self
		trace: String new;
		traceFirst: String new;
		traceAllButFirst: String new.! !



!AspectS.AsFactorialTraceAspectTest methodsFor: 'running'!

testFactorialTrace

	| aspect fact |
	aspect := self aspectClass new.
	aspect install.
	fact := 5 factorial2.
	aspect uninstall.
	self assert: fact = 120.
	self assert: aspect trace = self expectedTrace.
	self assert: aspect traceFirst = self expectedTraceFirst.
	self assert: aspect traceAllButFirst = self expectedTraceAllButFirst.! !

!AspectS.AsFactorialTraceAspectTest methodsFor: 'private'!

aspectClass

	^ AsFactorialTraceAspect!

expectedTrace

	^ '
factorial-in: 5
factorial-in: 4
factorial-in: 3
factorial-in: 2
factorial-in: 1
factorial-in: 0
factorial-out(0): 1
factorial-out(1): 1
factorial-out(2): 2
factorial-out(3): 6
factorial-out(4): 24
factorial-out(5): 120'!

expectedTraceAllButFirst

	^ '
*factorial-in: 4
*factorial-in: 3
*factorial-in: 2
*factorial-in: 1
*factorial-in: 0
*factorial-out(0): 1
*factorial-out(1): 1
*factorial-out(2): 2
*factorial-out(3): 6
*factorial-out(4): 24'!

expectedTraceFirst

	^ '
#factorial-in: 5
#factorial-out(5): 120'! !


!AspectS.AsCounter class methodsFor: 'instance creation'!

new

	^ super new initialize! !

!AspectS.AsCounter methodsFor: 'accessing'!

n
	"^ <Integer>"

	^ n!

n: anInteger

	n := anInteger.! !

!AspectS.AsCounter methodsFor: 'counting'!

dec

	self n: self n - 1.!

inc

	self n: self n + 1.! !

!AspectS.AsCounter methodsFor: 'initialization'!

initialize

	self n: 0.! !


!AspectS.AsHandlerWrapperTest methodsFor: 'running'!

testClassInstVars

	self assert: self wrapperClass class instVarNames size = 0.
	self assert: self wrapperClass classVarNames size = 0.

	self assert: self wrapperClass protoMethods notNil.
	self assert: (self wrapperClass protoMethods isMemberOf: Dictionary).!

testNoProtoInstanceCount

	| allInstCount protoInstCount |
	self flag: #rhi. "VW?: self wrapperClass tempNameCache: nil."
	ObjectMemory garbageCollect.
	allInstCount := self wrapperClass allInstances size.
	protoInstCount := self wrapperClass protoMethods size.
	self assert: (allInstCount - protoInstCount) = 0.!

testSequenceWrappers

	| method wrapper wrapperA wrapperBA wrapperH |
	method := AsA compiledMethodAt: #mOne.
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	wrapperA := AsAroundWrapper on: #mOne inClass: AsA.
	wrapperBA := AsBeforeAfterWrapper on: #mOne inClass: AsA.
	wrapperH := AsHandlerWrapper on: #mOne inClass: AsA.
	self assert: (method isMemberOf: CompiledMethod).
	wrapper install.
	self assert: (AsA compiledMethodAt: #mOne) == wrapper.
	self assert: wrapper clientMethod == method.
	wrapperA install.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperA.
	self assert: wrapperA clientMethod == wrapper.
	self assert: wrapper clientMethod == method.
	wrapperBA install.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperA.
	self assert: wrapperA clientMethod == wrapperBA.
	self assert: wrapperBA clientMethod == wrapper.
	self assert: wrapper clientMethod == method.
	wrapperH install.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperA.
	self assert: wrapperA clientMethod == wrapperBA.
	self assert: wrapperBA clientMethod == wrapperH.
	self assert: wrapperH clientMethod == wrapper.
	self assert: wrapper clientMethod == method.
	wrapperH uninstall.
	wrapperBA uninstall.
	wrapperA uninstall.
	wrapper uninstall.
	self assert: (AsA compiledMethodAt: #mOne) == method.! !

!AspectS.AsHandlerWrapperTest methodsFor: 'private'!

wrapperClass

	^ AsHandlerWrapper! !


!AspectS.AsCFlowFirstClassRGHWrapperTest methodsFor: 'running'!

setUp

	self trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		shouldnt: [instance failInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		shouldnt: [instance createAndFailInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace.! !

!AspectS.AsCFlowFirstClassRGHWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ '
failInNTimes-n: 5'!

expectedObjectRecursionTrace

	^ '
createAndFailInNTimes-n: 5'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverClassSpecificActivator;
		add: self wrapperClass cfFirstClassActivator.! !


!AspectS.AsCFlowAllButFirstInstanceRSHWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		shouldnt: [instance failInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self trace contents = self expectedObjectRecursionTrace2.! !

!AspectS.AsCFlowAllButFirstInstanceRSHWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
failInNTimes-n: 0'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverInstanceSpecificActivator;
		add: self wrapperClass cfAllButFirstInstanceActivator.! !


!AspectS.AsReceiverSpecificHWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0.!

testException

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	self assert: self result = 0.
	wrapper := self wrapperClass on: #signalNotFoundError inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: NotFoundError;
		handlerBlock: [:receiver :arguments :aspect :client :ex | 42];
		install.
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 0.!

testException2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	self assert: self result = 0.
	wrapper := self wrapperClass on: #signalNotFoundError inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: NotFoundError;
		handlerBlock: [:receiver :arguments :aspect :client :ex | 42];
		install.
	self
		shouldnt: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 42.!

testInstallInstantiateUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		install.
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	instance mOne.
	"*** self aspekt removeReceiver: instance. ***"
	wrapper uninstall.
	instance mOne.!

testInstallInstantiateUninstall2

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		install.
	instance := AsA new.
	self aspekt addReceiver: instance.
	instance mOne.
	self aspekt removeReceiver: instance.
	wrapper uninstall.
	instance mOne.!

testInstallUninstall

	| wrapper |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).
	wrapper
		aspect: self aspekt;
		install.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: self wrapperClass).
	wrapper uninstall.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).!

testInstantiateInstallUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	instance := AsA new.
	instance mOne.
	"*** self aspekt addReceiver: instance. ***"
	wrapper
		aspect: self aspekt;
		install.
	instance mOne.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	instance mOne.!

testInstantiateInstallUninstall2

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	instance := AsA new.
	instance mOne.
	self aspekt addReceiver: instance.
	wrapper
		aspect: self aspekt;
		install.
	instance mOne.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	instance mOne.!

testNoException

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	self shouldnt: [self result: instance signalNoException] raise: Exception.
	self assert: self result = 69.
	wrapper := self wrapperClass on: #signalNoException inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Exception;
		handlerBlock: [:receiver :arguments :aspect :client :ex | 42];
		install.
	self shouldnt: [self result: instance signalNoException] raise: Exception.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 69.!

testNoException2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	self shouldnt: [self result: instance signalNoException] raise: Exception.
	self assert: self result = 69.
	wrapper := self wrapperClass on: #signalNoException inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Exception;
		handlerBlock: [:receiver :arguments :aspect :client :ex | 42];
		install.
	self shouldnt: [self result: instance signalNoException] raise: Exception.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 69.!

testOtherException

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	self assert: self result = 0.
	wrapper := self wrapperClass on: #signalNotFoundError inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: EndOfStreamNotification;
		handlerBlock: [:receiver :arguments :aspect :client :ex | 42];
		install.
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 0.!

testOtherException2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	self assert: self result = 0.
	wrapper := self wrapperClass on: #signalNotFoundError inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: EndOfStreamNotification;
		handlerBlock: [:receiver :arguments :aspect :client :ex | 42];
		install.
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 0.! !

!AspectS.AsReceiverSpecificHWrapperTest methodsFor: 'private'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass receiverInstanceSpecificActivator.! !


!AspectS.AsCFlowAllButFirstInstanceSGHWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: self class.
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: instance class.
	self
		shouldnt: [instance failInNTimes: 5]
		raise: Error.
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: self class.
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: instance class.
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowAllButFirstInstanceSGHWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ ''!

expectedMethodRecursionTrace3

	^ '
failInNTimes-n: 0'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

expectedObjectRecursionTrace3

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderClassSpecificActivator;
		add: self wrapperClass cfAllButFirstInstanceActivator.! !


!AspectS.AsCFlowAllButFirstClassRGHWrapperTest methodsFor: 'running'!

setUp

	self trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		shouldnt: [instance failInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		shouldnt: [instance createAndFailInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace.! !

!AspectS.AsCFlowAllButFirstClassRGHWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ '
failInNTimes-n: 0'!

expectedObjectRecursionTrace

	^ '
createAndFailInNTimes-n: 0'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverClassSpecificActivator;
		add: self wrapperClass cfAllButFirstClassActivator.! !


!AspectS.AsCFlowAllButFirstClassSGHWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: self class.
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: instance class.
	self
		shouldnt: [instance failInNTimes: 5]
		raise: Error.
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: self class.
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: instance class.
	self
		shouldnt: [instance createAndFailInNTimes: 5]
		raise: Error.
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowAllButFirstClassSGHWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ ''!

expectedMethodRecursionTrace3

	^ '
failInNTimes-n: 0'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

expectedObjectRecursionTrace3

	^ '
createAndFailInNTimes-n: 0'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderClassSpecificActivator;
		add: self wrapperClass cfAllButFirstClassActivator.! !


!AspectS.AsCFlowFirstClassSSHWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSender: self. ***"
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: self.
	self
		shouldnt: [instance failInNTimes: 5]
		raise: Error.
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: instance.
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSender: self. ***"
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: self.
	self
		shouldnt: [instance createAndFailInNTimes: 5]
		raise: Error.
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: instance.
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowFirstClassSSHWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
failInNTimes-n: 5'!

expectedMethodRecursionTrace3

	^ ''!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndFailInNTimes-n: 5'!

expectedObjectRecursionTrace3

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderInstanceSpecificActivator;
		add: self wrapperClass cfFirstClassActivator.! !


!AspectS.AsCFlowFirstInstanceRSHWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		shouldnt: [instance failInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		shouldnt: [instance createAndFailInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self trace contents = self expectedObjectRecursionTrace2.! !

!AspectS.AsCFlowFirstInstanceRSHWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
failInNTimes-n: 5'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndFailInNTimes-n: 5'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverInstanceSpecificActivator;
		add: self wrapperClass cfFirstInstanceActivator.! !


!AspectS.AsCFlowAllButFirstInstanceSSHWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSender: self. ***"
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: self.
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: instance.
	self
		shouldnt: [instance failInNTimes: 5]
		raise: Error.
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSender: self. ***"
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: self.
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: instance.
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowAllButFirstInstanceSSHWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ ''!

expectedMethodRecursionTrace3

	^ '
failInNTimes-n: 0'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

expectedObjectRecursionTrace3

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderInstanceSpecificActivator;
		add: self wrapperClass cfAllButFirstInstanceActivator.! !


!AspectS.AsReceiverGeneralAWrapperTest methodsFor: 'running'!

setUp

	self result: 0.!

testAround

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #x: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			arguments at: 1 put: arguments first * 2.
			clientMethod valueWithReceiver: receiver arguments: arguments.
			thisContext baseClient x squared];
		install.
	self result: (instance x: 3).
	wrapper uninstall.
	self assert: instance x = 6.
	self assert: self result = 36.!

testAroundEven

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	wrapper := self wrapperClass on: #x: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			arguments first even
				ifTrue: [clientMethod valueWithReceiver: receiver arguments: arguments]];
		install.
	instance x: 3.
	self assert: instance x = 0.
	instance x: 4.
	self assert: instance x = 4.
	instance x: 5.
	self assert: instance x = 4.
	instance x: 6.
	self assert: instance x = 6.
	wrapper uninstall.!

testAroundReturn

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return |
			arguments at: 1 put: arguments first * 2.
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			return squared];
		install.
	self result: (instance addToX: 3).
	wrapper uninstall.
	self assert: instance x = 6.
	self assert: self result = 36.!

testAroundShadow

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	wrapper := self wrapperClass on: #x: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod | ];
		install.
	instance x: 3.
	self assert: instance x = 0.
	instance x: 4.
	self assert: instance x = 0.
	instance x: 5.
	self assert: instance x = 0.
	instance x: 6.
	self assert: instance x = 0.
	wrapper uninstall.!

testInstallInstantiateUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper install.
	instance := AsA new.
	instance mOne.
	wrapper uninstall.
	instance mOne.!

testInstallUninstall

	| wrapper |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).
	wrapper install.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: self wrapperClass).
	wrapper uninstall.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).!

testInstantiateInstallUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	instance := AsA new.
	instance mOne.
	wrapper install.
	instance mOne.
	wrapper uninstall.
	instance mOne.!

testNonLocalReturn

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	wrapper := self wrapperClass on: #setXNonLocalReturn: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			clientMethod valueWithReceiver: receiver arguments: arguments.
			instance x: 7];
		install.
	instance setXNonLocalReturnInteger: 3.
	wrapper uninstall.
	self assert: instance x = 3.!

testNonLocalReturnEnsure

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	wrapper := self wrapperClass on: #setXNonLocalReturn: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			[	clientMethod
					valueWithReceiver: receiver
					arguments: arguments.
			] ensure: [instance x: 7]];
		install.
	instance setXNonLocalReturnInteger: 3.
	wrapper uninstall.
	self assert: instance x = 7.! !

!AspectS.AsReceiverGeneralAWrapperTest methodsFor: 'private'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass receiverClassSpecificActivator.! !


!AspectS.AsJoinPointDescriptor class methodsFor: 'instance creation'!

targetClass: aClass targetSelector: aSymbol

	^ self new
		targetClass: aClass;
		targetSelector: aSymbol! !

!AspectS.AsJoinPointDescriptor methodsFor: 'accessing'!

targetClass
	"^ <Class>"

	^ targetClass!

targetClass: aClass

	targetClass := aClass.!

targetSelector
	"^ <Symbol>"

	^ targetSelector!

targetSelector: aSymbol

	targetSelector := aSymbol.! !


!AspectS.AsInfixVisitorAlternative2Aspect methodsFor: 'intros'!

nodeIntro: anAsNode

	^ '(', anAsNode first printInfix, ' ', anAsNode op asString, ' ', anAsNode second printInfix, ')'! !

!AspectS.AsInfixVisitorAlternative2Aspect methodsFor: 'pointcut'!

printSelector

	^ #printInfix! !


!Kernel.CompiledMethod methodsFor: 'derived accessing'!

unwrappedMethod

	^ self! !

!Kernel.CompiledMethod methodsFor: 'aspects'!

aspectClassesX

	^ self aspectsX collect: [:each | each class]!

aspectsX

	^ Set new!

wrapperClassesX

	^ self wrappersX collect: [:each | each class]!

wrappersX

	^ Set new! !


Kernel.CompiledMethod reorganizeFromString: '(''accessing'' #blockMethodIndex #compilerClass #mclass #newFullProbedMethod #newNormalProbedMethod #newTempFullProbedMethod #newTempProbedMethod #primitiveNumber #probedMethodClass #revert #selector #usuallyAllowsReceiver #usuallyHasSelector #variableScope)
(''copying'' #withAdditionalPropertiesFrom:)
(''printing'' #definition #printNameOn:inClass: #who)
(''private'' #copyStateFromOldVersion: #mclass:)
(''source code management'' #fileIndex #filePosition #getSource #methodWithSource #sourcePointer #sourcePointer:)
(''tracing'' #traceFrom:)
(''binary storage'' #storeGeneralStructureOn:)
(''derived accessing'' #unwrappedMethod)
(''testing'' #isFullBlockChain #isProbeable)
(''RefactoringBrowser'' #equivalentTo:)
(''aspects'' #aspectClassesX #aspectsX #wrapperClassesX #wrappersX)
'!

!AspectS.AsMethodWrapper class methodsFor: 'CHECKS'!

countAllInstances
	"doIt: [self countAllInstances]"

	| totalCount |
	totalCount := 0.
	ObjectMemory garbageCollect.
	Transcript cr.
	self withAllSubclassesDo: [:each |
		| count |
		count := each allInstances size.
		totalCount := totalCount + count.
		Transcript cr; show: each name, ' -> ', count printString].
	Transcript cr; show: '=== TOTAL COUNT -> ', totalCount printString.! !

!AspectS.AsMethodWrapper class methodsFor: 'accessing'!

protoActivators
	"^ <IdentityDictionary key: Symbol value: BlockContext>"

	^ ProtoActivators!

protoActivators: anIdentityDictionary

	ProtoActivators := anIdentityDictionary.!

protoMethods
	"^ <Dictionary key: SmallInteger value: AsMethodWrapper>"

	^ protoMethods!

protoMethods: aDictionary

	protoMethods := aDictionary.! !

!AspectS.AsMethodWrapper class methodsFor: 'activation'!

cfAllButFirstClassActivator

	^ [:aspect :baseSender |
		| lastCfPoint allCfPoints result |
		lastCfPoint := AsCFlowPoint object: baseSender receiver class selector: baseSender selector.
		allCfPoints := thisContext allBaseClientsWithSelector collect: [:each |
			AsCFlowPoint object: each key class selector: each value].
		result := (allCfPoints occurrencesOf: lastCfPoint) > 1.
		result] copy!

cfAllButFirstInstanceActivator

	^ [:aspect :baseSender |
		| lastCfPoint allCfPoints result |
		lastCfPoint := AsCFlowPoint object: baseSender receiver selector: baseSender selector.
		allCfPoints := thisContext allBaseClientsWithSelector collect: [:each |
			AsCFlowPoint object: each key selector: each value].
		result := (allCfPoints occurrencesOf: lastCfPoint) > 1.
		result] copy!

cfAllButFirstSuperActivator

	^ [:aspect :baseSender |
		| baseBaseSender result |
		baseBaseSender := baseSender baseSender.
		[#(valueWithReceiver:arguments: #'' '') includes: baseBaseSender selector]
			whileTrue: [baseBaseSender := baseBaseSender baseSender].
		result := baseSender receiver == baseBaseSender receiver
			and: [baseSender mclass ~~ baseSender receiver class].
		result] copy!

cfFirstClassActivator

	^ [:aspect :baseSender |
		| lastCfPoint allCfPoints result |
		lastCfPoint := AsCFlowPoint object: baseSender receiver class selector: baseSender selector.
		allCfPoints := thisContext allBaseClientsWithSelector collect: [:each |
			AsCFlowPoint object: each key class selector: each value].
		result := (allCfPoints occurrencesOf: lastCfPoint) = 1.
		result] copy!

cfFirstInstanceActivator

	^ [:aspect :baseSender |
		| lastCfPoint allCfPoints result |
		lastCfPoint := AsCFlowPoint object: baseSender receiver selector: baseSender selector.
		allCfPoints := thisContext allBaseClientsWithSelector collect: [:each |
			AsCFlowPoint object: each key selector: each value].
		result := (allCfPoints occurrencesOf: lastCfPoint) = 1.
		result] copy!

cfFirstSuperActivator
	^ [:aspect :baseSender |
		| baseBaseSender result |
		baseBaseSender := baseSender baseSender.
		[#(valueWithReceiver:arguments: #'' '') includes: baseBaseSender selector]
			whileTrue: [baseBaseSender := baseBaseSender baseSender].
		self flag: #rhi. "Consider ContextDefinition>>implementingClass and ContextDefinition>>inheritingClass."
		result := baseSender receiver ~~ baseBaseSender receiver
			or: [baseSender mclass == baseSender receiver class].
		result] copy!

projectSpecificActivator

	^ [:aspect :baseSender |
		| result |
		result := aspect hasProject: LightweightProjects current.
		result] copy!

receiverClassSpecificActivator

	^ [:aspect :baseSender |
		true] copy!

receiverInstanceSpecificActivator

	^ [:aspect :baseSender |
		| result |
		result := aspect hasReceiver: baseSender receiver.
		result] copy!

senderClassSpecificActivator

	^ [:aspect :baseSender |
		| result |
		result := aspect hasSenderClass: baseSender baseClient class.
		result] copy!

senderInstanceSpecificActivator

	^ [:aspect :baseSender |
		| result |
		result := aspect hasSender: baseSender baseClient.
		result] copy! !

!AspectS.AsMethodWrapper class methodsFor: 'class initialization'!

initAdditionalProtoActivators

	self protoActivators
		add: (#projectSpecific -> self projectSpecificActivator).!

initCFlowProtoActivators

	self protoActivators
		add: (#cfFirstClass -> self cfFirstClassActivator);
		add: (#cfAllButFirstClass -> self cfAllButFirstClassActivator);

		add: (#cfFirstInstance -> self cfFirstInstanceActivator);
		add: (#cfAllButFirstInstance -> self cfAllButFirstInstanceActivator);

		add: (#cfFirstSuper -> self cfFirstInstanceActivator);
		add: (#cfAllButFirstSuper -> self cfAllButFirstInstanceActivator).!

initialize
	"doIt: [self initialize]"

	self
		protoActivators: IdentityDictionary new;
		protoMethods: Dictionary new;
		initRegularProtoActivators;
		initCFlowProtoActivators;
		initAdditionalProtoActivators.!

initializeWithAllSubclasses
	"doIt: [self initializeWithAllSubclasses]"

	self withAllSubclassesDo: [:each | each initialize].!

initRegularProtoActivators

	self protoActivators
		add: (#receiverClassSpecific -> self receiverClassSpecificActivator);
		add: (#receiverInstanceSpecific -> self receiverInstanceSpecificActivator);
		add: (#senderClassSpecific -> self senderClassSpecificActivator);
		add: (#senderInstanceSpecific -> self senderInstanceSpecificActivator).! !

!AspectS.AsMethodWrapper class methodsFor: 'constants'!

wrapperSequence

	self flag: #rhi. "Move that into a class variable!!"
	^ OrderedCollection new
		add: AsAroundWrapper;
		add: AsBeforeAfterWrapper;
		add: AsHandlerWrapper;
		add: AsIntroductionWrapper;
		add: CompiledMethod;
		yourself! !

!AspectS.AsMethodWrapper class methodsFor: 'instance creation'!

on: aSymbol inClass: aClass

	| wrapper |
	self flag: #rhi. "How about signaling an exception instead of returning nil?"
	(self canWrap: aSymbol inClass: aClass) ifFalse: [^ nil].
	wrapper := (self protoMethods
			at: aSymbol numArgs
			ifAbsentPut: [self createMethodFor: aSymbol numArgs]) copy.
	wrapper class: aClass selector: aSymbol.
	^ wrapper! !

!AspectS.AsMethodWrapper class methodsFor: 'testing'!

canWrap: aSelector inClass: aClass

	| class method |
	self flag: #rhi. "Are there any other chances for infinite recursion?"
	(aClass includesBehavior: AsMethodWrapper) ifTrue: [^ false].
	((aClass includesBehavior: CompiledMethod)
		and: [aSelector == #valueWithReceiver:arguments:])
			ifTrue: [^ false].
	((aClass includesBehavior: BlockClosure)
		and: [#(#valueAsUnwindBlockFrom: #ensure:) includes: aSelector])
			ifTrue: [^ false].
	class := aClass whichClassIncludesSelector: aSelector.
	class ifNil: [^ false].
	method := class compiledMethodAt: aSelector ifAbsent: [nil].
	^ method notNil and: [(self primitives includes: method primitiveNumber) not]! !

!AspectS.AsMethodWrapper class methodsFor: 'private'!

codeStringFor: numArgs

	| nameString tempsString |
	numArgs = 0
		ifTrue: [
			nameString := 'value'.
			tempsString := 't := #Array new']
		ifFalse: [
			nameString := ''.
			tempsString := '(t := #Array new: ', numArgs printString, ')'.
			1 to: numArgs do: [:i |
				nameString := nameString,
					'value: t',
					i printString,
					(i = numArgs ifTrue: [''] ifFalse: [' ']).
				tempsString := tempsString,
					(i = 1 ifTrue: [''] ifFalse: [';']),
					' at: ' , i printString,
					' put: t',
					i printString]].
	^ nameString, '
	| t |
	', tempsString, '.
	^ ',
	self methodWrapperSymbol printString,
	' valueWithReceiver: self arguments: t'!

createMethodFor: numArgs

	^ (Compiler new
			methodClass: self;
			compile: (self codeStringFor: numArgs)
				in: self
				notifying: nil
				ifFail: []) generate!

methodWrapperSymbol

	^ #'The method wrapper should be inserted in this position!!'!

nuke
	"doIt: [self nuke]"

	self
		uninstallAllWrappers;
		initialize.!

primitives

	self flag: #rhi. "Revisit & Verify!!"
	^ #(
		61		"at:put:"
		71		"new:"
		501		"value"
		523		"valueWithReceiver:arguments:"
	)!

uninstallAllWrappers
	"doIt: [self uninstallAllWrappers]"

	self allSubInstancesDo: [:inst | inst uninstall].! !

!AspectS.AsMethodWrapper methodsFor: 'accessing'!

activators
	"^ <Set of: BlockClosure>"

	^ activators!

activators: aSet

	activators := aSet.!

advice
	"^ <AsAdvice>"

	^ advice!

advice: anAsAdvice

	advice := anAsAdvice.!

aspect
	"^ <AsAspect>"

	^ aspect!

aspect: anAsAspect

	aspect := anAsAspect.!

clientMethod
	"^ <CompiledMethod>"

	^ clientMethod!

clientMethod: aCompiledMethod

	clientMethod := aCompiledMethod.!

clientSelector
	"^ <Symbol>"

	^ clientSelector!

clientSelector: aSymbol

	clientSelector := aSymbol.!

definingClass
	"^ <Class>"

	^ definingClass!

definingClass: aClass

	definingClass := aClass.!

wrappedClass
	"^ <Class>"

	^ wrappedClass!

wrappedClass: aClass

	wrappedClass := aClass.!

wrappingWrapper
	"^ <AsMethodWrapper>"

	^ wrappingWrapper!

wrappingWrapper: anAsMethodWrapper

	wrappingWrapper := anAsMethodWrapper.! !

!AspectS.AsMethodWrapper methodsFor: 'constants'!

wrapperSequence

	^ self class wrapperSequence! !

!AspectS.AsMethodWrapper methodsFor: 'derived accessing'!

unwrappedMethod

	^ self clientMethod ifNotNil: [self clientMethod unwrappedMethod]! !

!AspectS.AsMethodWrapper methodsFor: 'evaluating'!

valueWithReceiver: anObject arguments: anArrayOfObjects

	self subclassResponsibility.! !

!AspectS.AsMethodWrapper methodsFor: 'initialization'!

class: aClass selector: aSymbol

	self
		basicAt: self methodPosition put: self;
		basicAt: self arrayPosition put: Array;
		wrappedClass: aClass;
		clientSelector: aSymbol;
		activators: Set new.! !

!AspectS.AsMethodWrapper methodsFor: 'installation'!

install

	| holdingClass method previous |
	self flag: #rhi. "KLUDGE: Einwegwrapper."
	self wasActive ifTrue: [self error: 'Einwegwrapper!!'].
	holdingClass := self wrappedClass whichClassIncludesSelector: self clientSelector.
	holdingClass ifNil: [^ self].
	method := holdingClass compiledMethodAt: self clientSelector.
	"--------------------------------------------------------------------------------"
	[self inSequenceBeforeOrAt: method]
		whileFalse: [
			previous := method.
			method := method clientMethod].
	"--------------------------------------------------------------------------------"
	[(method isMemberOf: CompiledMethod) not
			and: [(self inSequenceBeforeOrAt: method)
				and: [(self aspect isKindOf: method aspect class) not]]]
		whileTrue: [
			previous := method.
			method := method clientMethod].		
	"--------------------------------------------------------------------------------"
	self flag: #rhi. "Single test for self might not be sufficient."
	method == self ifTrue: [^ self].
	self
		clientMethod: method;
		sourcePointer: method sourcePointer.
	method isAsMethodWrapper
		ifTrue: [
			method wrappingWrapper: self.
			self definingClass: method definingClass]
		ifFalse: [self definingClass: holdingClass].
	previous
		ifNotNil: [
			self wrappingWrapper: previous.
			previous clientMethod: self]
		ifNil: [self wrappedClass simpleAddSelector: self clientSelector withMethod: self].!

uninstall

	self flag: #rhi. "The #uninstall should actually become #destroy!!"
	[	self clientMethod ifNil: [^ self].
		(self wrappedClass compiledMethodAt: self clientSelector ifAbsent: [nil]) == self
			ifTrue: [self wrappedClass == self definingClass
				ifTrue: [self wrappedClass
					simpleAddSelector: self clientSelector
					withMethod: self clientMethod]
				ifFalse: [self wrappedClass removeSelector: self clientSelector]].
		self clientMethod isAsMethodWrapper
			ifTrue: [self clientMethod wrappingWrapper: self wrappingWrapper].
		self wrappingWrapper
			ifNotNil: [
				self wrappingWrapper
					clientMethod: self clientMethod;
					definingClass: self definingClass.
				self wrappingWrapper: nil].
		self
			definingClass: nil;
			clientMethod: nil.
	] ensure: [
		self flag: #rhi. "KLUDGE: Einwegwrapper."
		self invalidate].! !

!AspectS.AsMethodWrapper methodsFor: 'source code management'!

sourcePointer

	| pos |
	pos := super sourcePointer.
	(pos = nil or: [pos = 0])
		ifTrue: [
			pos := self clientMethod sourcePointer.
			self sourcePointer: pos].
	^ pos!

sourcePointer: sourceRef

	super sourcePointer: sourceRef.
	self clientMethod sourcePointer: sourceRef.! !

!AspectS.AsMethodWrapper methodsFor: 'testing'!

inSequenceBeforeOrAt: aCompiledMethod

	^ (self wrapperSequence identityIndexOf: self class)
		<= (self wrapperSequence identityIndexOf: aCompiledMethod class)!

isActive

	| baseSender |
	baseSender := thisContext baseSender.
	self flag: #rhi. "Consider removing notEmpty test (performance)?!!"
	^ self activators notEmpty
		and: [self activators allSatisfy: [:aBlock |
			aBlock value: self aspect value: baseSender]]!

isAsMethodWrapper

	^ true!

wasActive

	self flag: #rhi. "KLUDGE: Einwegwrapper."
	^ self wrappedClass isNil "and: [self clientSelector isNil]"! !

!AspectS.AsMethodWrapper methodsFor: 'private'!

arrayPosition

	"self numArgs == 0 ifTrue: [^ 0]."
	^ (1 to: self size) detect: [:i |
			| each |
			each := self realBasicAt: i.
			each == #Array or: [each == Array]]
		ifNone: [self error: 'Cannot find array position.']!

basicAt: anIndex

	| object |
	object := self realBasicAt: anIndex.
	^ object == self
		ifTrue: [self clientMethod]
		ifFalse: [object]!

invalidate

	self
		wrappedClass: nil;
		clientSelector: nil.!

methodPosition

	^ (1 to: self size) detect: [:i |
			| each |
			each := self realBasicAt: i.
			each == self class methodWrapperSymbol or: [each == self]]
		ifNone: [self error: 'Cannot find position to insert wrapper']!

realBasicAt: anIndex

	^ super basicAt: anIndex! !

!AspectS.AsMethodWrapper methodsFor: 'aspects'!

aspectsX

	^ self clientMethod aspectsX add: self aspect; copyWithout: nil!

wrappersX

	^ self clientMethod wrappersX add: self; yourself! !


!AspectS.AsAroundWrapper class methodsFor: 'class initialization'!

initialize
	"doIt: [self initialize]"

	super initialize.! !

!AspectS.AsAroundWrapper methodsFor: 'accessing'!

aroundBlock
	"^ <BlockClosure>"

	^ aroundBlock!

aroundBlock: aBlockClosure

	aroundBlock := aBlockClosure.! !

!AspectS.AsAroundWrapper methodsFor: 'evaluating'!

valueWithReceiver: anObject arguments: anArrayOfObjects

	| client |
	client := thisContext baseClient.
	self flag: #rhi. "Consider taking out the ifFalse: branch!! Semantics?"
	^ self isActive
		ifTrue: [self aroundBlock copy valueWithArguments: (Array
				with: anObject
				with: anArrayOfObjects
				with: self aspect
				with: client
				with: self clientMethod)]
		ifFalse: [self clientMethod valueWithReceiver: anObject arguments: anArrayOfObjects]! !

!AspectS.AsAroundWrapper methodsFor: 'initialization'!

class: aClass selector: aSymbol

	super class: aClass selector: aSymbol.
	self aroundBlock: [:receiver :arguments :aspekt :client :klientMethod | ].! !

!AspectS.AsAroundWrapper methodsFor: 'installation'!

uninstall

	self flag: #rhi. "self clientMethod ifNil: [^ self]."
	self flag: #rhi. "VW?: self aroundBlock instVarNamed: 'home' put: nil."
	self flag: #rhi. "self aroundBlock: nil."
	super uninstall.! !


!AspectS.AsIntroductionWrapper class methodsFor: 'class initialization'!

initialize
	"doIt: [self initialize]"

	super initialize.! !

!AspectS.AsIntroductionWrapper class methodsFor: 'instance creation'!

on: aSymbol inClass: aClass

	| wrapper |
	self flag: #rhi. "How about signaling an exception instead of returning nil?"
	(self canIntroduce: aSymbol inClass: aClass) ifFalse: [^ nil].
	wrapper := (self protoMethods
			at: aSymbol numArgs
			ifAbsentPut: [self createMethodFor: aSymbol numArgs]) copy.
	wrapper class: aClass selector: aSymbol.
	^ wrapper! !

!AspectS.AsIntroductionWrapper class methodsFor: 'testing'!

canIntroduce: aSelector inClass: aClass

	| class method |
	(aClass includesBehavior: AsMethodWrapper) ifTrue: [^ false].
	self flag: #rhi. "Should allow overriding?!!"
	class := aClass whichClassIncludesSelector: aSelector.
	class == aClass ifFalse: [^ true].
	method := class compiledMethodAt: aSelector ifAbsent: [nil].
	^ method isNil! !

!AspectS.AsIntroductionWrapper methodsFor: 'accessing'!

introBlock
	"^ <BlockClosure>"

	^ introBlock!

introBlock: aBlockClosure

	introBlock := aBlockClosure.! !

!AspectS.AsIntroductionWrapper methodsFor: 'evaluating'!

valueWithReceiver: anObject arguments: anArrayOfObjects

	| client |
	client := thisContext baseClient.
	self flag: #rhi. "Consider taking out the ifFalse: branch!! Or returning client. Semantics?"
	^ self isActive
		ifTrue: [self introBlock copy valueWithArguments: (Array
				with: anObject
				with: anArrayOfObjects
				with: self aspect
				with: client)]
		ifFalse: [nil]! !

!AspectS.AsIntroductionWrapper methodsFor: 'initialization'!

class: aClass selector: aSymbol

	self flag: #rhi. "The super-call is probably very wrong?!!"
	super class: aClass selector: aSymbol.
	self introBlock: [:receiver :arguments :aspekt :client | ].! !

!AspectS.AsIntroductionWrapper methodsFor: 'installation'!

install

	| method |
	self flag: #rhi. "KLUDGE: Einwegwrapper."
	self wasActive ifTrue: [self error: 'Einwegwrapper!!'].
	method := self wrappedClass compiledMethodAt: self clientSelector ifAbsent: [nil].
	method == self ifTrue: [^ self].
	method ifNotNil: [self error: 'Failed to introduce (method already defined).'].
	self flag: #rhi. "Insert/Factor-out wrapper ordering here."
	self wrappedClass simpleAddSelector: self clientSelector withMethod: self.!

uninstall

	self flag: #rhi. "The #uninstall should actually become #destroy!!"
	[	self wrappedClass removeSelector: self clientSelector.
		self flag: #rhi. "VW?: self introBlock instVarNamed: 'home' put: nil."
		self flag: #rhi. "self introBlock: nil."
		self wrappingWrapper
			ifNotNil: [
				self wrappingWrapper
					clientMethod: self clientMethod;
					definingClass: self definingClass.
				self wrappingWrapper: nil].
	] ensure: [
		self flag: #rhi. "KLUDGE: Einwegwrapper."
		self invalidate].! !

!AspectS.AsIntroductionWrapper methodsFor: 'source code management'!

sourcePointer

	^ 0! !

!AspectS.AsIntroductionWrapper methodsFor: 'aspects'!

aspectsX

	^ (Set with: self aspect) copyWithout: nil!

wrappersX

	^ Set with: self! !


!AspectS.AsCFlowFirstClassSGAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance callNTimes: 5).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance callNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance callNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance createAndCallNTimes: 5).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowFirstClassSGAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
callNTimes-in: 5
callNTimes-out(5): 15'!

expectedMethodRecursionTrace3

	^ ''!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndCallNTimes-in: 5
createAndCallNTimes-out(5): 15'!

expectedObjectRecursionTrace3

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderClassSpecificActivator;
		add: self wrapperClass cfFirstClassActivator.! !


!AspectS.AsA methodsFor: 'accessing'!

x
	"^ <Integer>"

	^ x!

x: anInteger

	x := anInteger.! !

!AspectS.AsA methodsFor: 'debugging'!

addToX: anInteger

	self x: self x + anInteger.
	^ self x!

callNTimes: anInteger

	^ anInteger = 0
		ifTrue: [0]
		ifFalse: [anInteger + (self callNTimes: anInteger - 1)]!

createAndCallNTimes: anInteger

	^ anInteger = 0
		ifTrue: [0]
		ifFalse: [anInteger + (self class new createAndCallNTimes: anInteger - 1)]!

createAndFailInNTimes: anInteger

	anInteger = 0
		ifTrue: [^ Error signal]
		ifFalse: [
			anInteger > 0
				ifTrue: [self class new createAndFailInNTimes: anInteger - 1]
				ifFalse: [self error: 'Not valid for negative integers.']].!

failInNTimes: anInteger

	anInteger = 0
		ifTrue: [^ Error signal]
		ifFalse: [
			anInteger > 0
				ifTrue: [self failInNTimes: anInteger - 1]
				ifFalse: [self error: 'Not valid for negative integers.']].!

mCompile

	^ 'jin' copy!

mOne!

mTwo!

recAndDefClass

	^ 'rec:', self class name, '(def:AsA)'!

setXNonLocalReturn: aBlockClosure

	aBlockClosure value.!

setXNonLocalReturnInteger: anInteger

	self setXNonLocalReturn: [^ self x: anInteger].!

signalNoException

	^ 69!

signalNotFoundError

	NotFoundError raiseSignal.! !


!AspectS.AsB methodsFor: 'debugging'!

mThree!

mTwo!

recAndDefClass

	^ 'rec:', self class name, '(def:AsB)--[super]-->', super recAndDefClass! !


!Core.Symbol methodsFor: 'testing'!

isAdviceSelector

	^ ('advice#*' match: self) and: [self numArgs = 0]! !


!AspectS.AsCFlowAllButFirstClassSSHWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSender: self. ***"
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: self.
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: instance.
	self
		shouldnt: [instance failInNTimes: 5]
		raise: Error.
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSender: self. ***"
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: self.
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: instance.
	self
		shouldnt: [instance createAndFailInNTimes: 5]
		raise: Error.
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowAllButFirstClassSSHWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ ''!

expectedMethodRecursionTrace3

	^ '
failInNTimes-n: 0'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

expectedObjectRecursionTrace3

	^ '
createAndFailInNTimes-n: 4'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderInstanceSpecificActivator;
		add: self wrapperClass cfAllButFirstClassActivator.! !


!AspectS.AsCFlowAllButFirstInstanceRGHWrapperTest methodsFor: 'running'!

setUp

	self trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		shouldnt: [instance failInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace.! !

!AspectS.AsCFlowAllButFirstInstanceRGHWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ '
failInNTimes-n: 0'!

expectedObjectRecursionTrace

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverClassSpecificActivator;
		add: self wrapperClass cfAllButFirstInstanceActivator.! !


!AspectS.AsPostfixVisitorAspectTest methodsFor: 'running'!

testPostfixTrace

	| aspect |
	aspect := self aspectClass new.
	aspect install.
	self buildTree acceptVisitor: aspect.
	aspect uninstall.
	self assert: aspect trace contents = self expectedTrace.! !

!AspectS.AsPostfixVisitorAspectTest methodsFor: 'private'!

aspectClass

	^ AsPostfixVisitorAspect!

buildTree

	^ AsNode
		first: (AsNode
			first: (AsNode
				first: (AsLeaf value: 1)
				op: #+
				second: (AsLeaf value: 2))
			op: #*
			second: (AsNode
				first: (AsLeaf value: 3)
				op: #-
				second: (AsLeaf value: 4)))
		op: #/
		second: (AsLeaf value: 5)!

expectedTrace

	^ '(((1 2 +) (3 4 -) *) 5 /)'! !


!AspectS.AsAdvice class methodsFor: 'instance creation'!

new

	^ super new initialize! !

!AspectS.AsAdvice methodsFor: 'accessing'!

installed
	"^ <Boolean>"

	^ installed!

installed: aBoolean

	installed := aBoolean.!

pointcut
	"^ <BlockClosure>"

	self flag: #rhi. "#value returns a <Collection of: AsJoinPointDescriptor>"
	^ pointcut!

pointcut: aBlockClosure

	pointcut := aBlockClosure.!

qualifier
	"^ <AsAdviceQualifier>"

	^ qualifier!

qualifier: anAsAdviceQualifier

	qualifier := anAsAdviceQualifier.!

wrappers
	"^ <Collection of: AsMethodWrapper>"

	^ wrappers!

wrappers: aCollection

	wrappers := aCollection.! !

!AspectS.AsAdvice methodsFor: 'initialization'!

initialize

	self
		pointcut: nil;
		qualifier: nil;
		wrappers: nil;
		installed: false.! !

!AspectS.AsAdvice methodsFor: 'installation'!

installWith: anAsAspect

	self installed ifTrue: [self error: 'Advice already installed.'].
	[	self
			wrappers: OrderedCollection new;
			buildWrappers;
			installWrappersWith: anAsAspect;
			installed: true.
	] on: Error do: [:ex |
		self uninstall.
		self error: 'Installation of advice failed.'].!

uninstall

	self
		uninstallWrappers;
		wrappers: nil;
		installed: false.! !

!AspectS.AsAdvice methodsFor: 'weaving'!

buildWrappers

	self subclassResponsibility.!

installWrappersWith: anAsAspect

	self wrappers do: [:wrapper |
		wrapper
			advice: self;
			aspect: anAsAspect;
			install].!

uninstallWrappers

	self wrappers do: [:wrapper |
		wrapper
			aspect: nil;
			aspect: nil;
			uninstall].!

wrapperClass

	self subclassResponsibility.! !


!AspectS.AsHandlerAdvice class methodsFor: 'instance creation'!

qualifier: anAsAdviceQualifier pointcut: aPointcutBlockClosure exception: anExceptionClass handlerBlock: aHandlerBlockClosure

	^ super new
		qualifier: anAsAdviceQualifier;
		pointcut: aPointcutBlockClosure;
		exception: anExceptionClass;
		handlerBlock: aHandlerBlockClosure! !

!AspectS.AsHandlerAdvice methodsFor: 'accessing'!

exception
	"^ <Exception class>"

	^ exception!

exception: anExceptionClass

	exception := anExceptionClass.!

handlerBlock
	"^ <BlockClosure>"

	^ handlerBlock!

handlerBlock: aBlockClosure

	handlerBlock := aBlockClosure.! !

!AspectS.AsHandlerAdvice methodsFor: 'weaving'!

buildWrappers

	| wrapper |
	self pointcut value do: [:join |
		wrapper := self wrapperClass on: join targetSelector inClass: join targetClass.
		wrapper ifNil: [self error: 'Failed to create wrapper.'].
		self qualifier setActivatorsFor: wrapper.
		self exception ifNotNil: [wrapper exception: self exception].
		self handlerBlock ifNotNil: [wrapper handlerBlock: self handlerBlock copy].
		self wrappers add: wrapper].!

wrapperClass

	^ AsHandlerWrapper! !


!AspectS.AsIntroductionAdvice class methodsFor: 'instance creation'!

qualifier: anAsAdviceQualifier pointcut: aPointcutBlockClosure introBlock: anIntroBlockClosure

	^ super new
		qualifier: anAsAdviceQualifier;
		pointcut: aPointcutBlockClosure;
		introBlock: anIntroBlockClosure! !

!AspectS.AsIntroductionAdvice methodsFor: 'accessing'!

introBlock
	"^ <BlockClosure>"

	^ introBlock!

introBlock: aBlockClosure

	introBlock := aBlockClosure.! !

!AspectS.AsIntroductionAdvice methodsFor: 'weaving'!

buildWrappers

	| wrapper |
	self pointcut value do: [:join |
		wrapper := self wrapperClass on: join targetSelector inClass: join targetClass.
		wrapper ifNil: [self error: 'Failed to create wrapper.'].
		self qualifier setActivatorsFor: wrapper.
		self introBlock ifNotNil: [wrapper introBlock: self introBlock copy].
		self wrappers add: wrapper].!

wrapperClass

	^ AsIntroductionWrapper! !


!AspectS.AsBeforeAfterAdvice class methodsFor: 'instance creation'!

qualifier: anAsAdviceQualifier pointcut: aPointcutBlockClosure afterBlock: anAfterBlockClosure

	^ self
		qualifier: anAsAdviceQualifier
		pointcut: aPointcutBlockClosure
		beforeBlock: nil
		afterBlock: anAfterBlockClosure!

qualifier: anAsAdviceQualifier pointcut: aPointcutBlockClosure beforeBlock: aBeforeBlockClosure

	^ self
		qualifier: anAsAdviceQualifier
		pointcut: aPointcutBlockClosure
		beforeBlock: aBeforeBlockClosure
		afterBlock: nil!

qualifier: anAsAdviceQualifier pointcut: aPointcutBlockClosure beforeBlock: aBeforeBlockClosure afterBlock: anAfterBlockClosure

	^ super new
		qualifier: anAsAdviceQualifier;
		pointcut: aPointcutBlockClosure;
		beforeBlock: aBeforeBlockClosure;
		afterBlock: anAfterBlockClosure! !

!AspectS.AsBeforeAfterAdvice methodsFor: 'accessing'!

afterBlock
	"^ <BlockClosure>"

	^ afterBlock!

afterBlock: aBlockClosure

	afterBlock := aBlockClosure.!

beforeBlock
	"^ <BlockClosure>"

	^ beforeBlock!

beforeBlock: aBlockClosure

	beforeBlock := aBlockClosure.! !

!AspectS.AsBeforeAfterAdvice methodsFor: 'weaving'!

buildWrappers

	| wrapper |
	self pointcut value do: [:join |
		wrapper := self wrapperClass on: join targetSelector inClass: join targetClass.
		wrapper ifNil: [self error: 'Failed to create wrapper.'].
		self qualifier setActivatorsFor: wrapper.
		self beforeBlock ifNotNil: [wrapper beforeBlock: self beforeBlock copy].
		self afterBlock ifNotNil: [wrapper afterBlock: self afterBlock copy].
		self wrappers add: wrapper].!

wrapperClass

	^ AsBeforeAfterWrapper! !


!Core.Behavior methodsFor: 'creating method dictionary'!

simpleAddSelector: selector withMethod: compiledMethod
	"Add the message selector with the corresponding compiled method
	 to the receiver's method dictionary."

	| prevMethod method instanceMethodsChanged |
	method := self validateMethod: compiledMethod forSelector: selector.
	(instanceMethodsChanged := method attributeMessages notNil)
		ifFalse: [instanceMethodsChanged :=
			(prevMethod := methodDict at: selector ifAbsent: []) notNil
				and: [prevMethod attributeMessages notNil]].
	methodDict at: selector put: method.
	self flushVMmethodCacheEntriesFor: selector.
	instanceMethodsChanged ifTrue: [self instanceMethodsChanged].! !

!Core.Behavior methodsFor: 'private'!

placeMethod: aCompiledMethod afterWrappers: anAsMethodWrapper

	| oldCompiledMethod oldSourcePointer lastWrapper sourcePointer |
	self flag: #rhi. "There are quite a few special cases T.B.D. later..."
	self flag: #rhi. "Preserve source pointer in old compiled method, just in case..."
	oldCompiledMethod := anAsMethodWrapper unwrappedMethod.
	oldSourcePointer := oldCompiledMethod sourcePointer.
	lastWrapper := anAsMethodWrapper.
	sourcePointer := aCompiledMethod sourcePointer.
	lastWrapper sourcePointer: sourcePointer.
	[lastWrapper clientMethod isAsMethodWrapper]
		whileTrue: [
			lastWrapper := lastWrapper clientMethod.
			lastWrapper sourcePointer: sourcePointer].
	lastWrapper clientMethod: aCompiledMethod.
	oldCompiledMethod sourcePointer: oldSourcePointer.! !

!Core.Behavior methodsFor: 'aspects'!

aspectClasses

	^ self aspects collect: [:each | each class]!

aspects

	^ (self wrappers collect: [:each | each aspect]) copyWithout: nil!

wrapperClasses

	^ self wrappers collect: [:each | each class]!

wrappers

	self flag: #rhi. "NAME CONFLICT with AsAdvice>>wrappers!!"
	^ self methodDictionary inject: Set new into: [:wrappers :each |
		wrappers addAll: each wrappersX; yourself]! !


!Core.Behavior methodsFor: 'creating method dictionary'!

addSelector: selector withMethod: compiledMethod
	"Add the message selector with the corresponding compiled method
	 to the receiver's method dictionary."

	| prevMethod method instanceMethodsChanged |
	method := self validateMethod: compiledMethod forSelector: selector.
	(instanceMethodsChanged := method attributeMessages notNil)
		ifFalse: [instanceMethodsChanged :=
			(prevMethod := methodDict at: selector ifAbsent: []) notNil
				and: [prevMethod attributeMessages notNil]].
	(prevMethod isAsMethodWrapper and: [method isAsMethodWrapper not])
		ifTrue: [self placeMethod: method afterWrappers: prevMethod]
		ifFalse: [methodDict at: selector put: method].
	self flushVMmethodCacheEntriesFor: selector.
	instanceMethodsChanged ifTrue: [self instanceMethodsChanged].! !


Core.Behavior reorganizeFromString: '(''initialize-release'' #localObsolete #obsolete)
(''accessing'' #asNameSpace #behaviorType #environment #format #fullName #instanceBehavior #methodDictionary #name #unambiguousName)
(''testing'' #hasImmediateInstances #instSize #isBehavior #isBits #isEphemeronClass #isFixed #isForClass #isForNameSpace #isGCSpecialClass #isLikeNameSpace #isMeta #isPointers #isSubclassOfAbsentClass #isVariable #isWeak #needsSafeRebinding #shouldBeRegistered #_isBehaviorOrProxy)
(''copying'' #postCopy)
(''printing'' #printHierarchy #printHierarchyWithStatics #printOn:)
(''creating class hierarchy'' #addSubclass: #addToSuper #assignSuperclass: #classBuilder #clearInstanceVariables #notificationOfFinishedClassModifications #removeFromSuper #removeSubclass: #superclass:)
(''creating method dictionary'' #addSelector:withMethod: #addSelectorUnsafe:withMethod: #methodDictionary: #removeSelector: #replaceMethodAt:withMethod: #simpleAddSelector:withMethod: #validateMethod:forSelector:)
(''instance creation'' #adoptInstance: #basicNew #basicNew: #basicNewInFixedSpace: #new #new: #newInFixedSpace:)
(''accessing class hierarchy'' #allSubclasses #allSuperclasses #commonSuperclass: #subclasses #subrequisites #superclass #withAllSubclasses #withAllSubclassesDo: #withAllSuperclasses)
(''accessing method dictionary'' #allSelectors #compiledMethodAt: #compiledMethodAt:ifAbsent: #enumerateMethods: #findMethod: #findSelector: #selectorAtMethod:ifAbsent: #selectorAtMethod:setClass: #selectorAtMethod:setClass:ifAbsent: #selectors #selectorsAndMethodsDo: #sourceCodeAt: #sourceCodeForMethod:at: #sourceMethodAt:)
(''accessing instances and variables'' #allClassVarNames #allGeneralInstances #allInstances #allInstancesWeakly: #allInstVarNames #allSharedPools #classPool #classVarNames #generalInstanceCount #instanceCount #instVarNames #localBindings #sharedPools #someInstance #subclassInstVarNames)
(''testing class hierarchy'' #includesBehavior: #inheritsFrom: #isDirectSubclassOf:)
(''testing method dictionary'' #canUnderstand: #fullScopeHas:ifTrue: #hasLocalMethods #hasMethods #includesSelector: #scopeHas:ifTrue: #whichClassIncludesSelector: #whichSelectorsAccess: #whichSelectorsAssign: #whichSelectorsRead: #whichSelectorsReferTo:)
(''compiling'' #bindingFor: #bindingFor:modifiers: #compile:notifying: #compile:notifying:ifFail: #compilerClass #decompile: #decompilerClass #evaluatorClass #fullBindingFor: #instanceMethodsChanged #localBindingFor: #localBindingNames #localNamesAndBindingsDo: #namesAndBindingsDo: #namesAndBindingsDo:modifiers: #oldBindingFor: #parserClass #poolHas:ifTrue: #protectedBindingFor:modifiers: #protectedNamesAndBindingsDo:modifiers: #recompile: #recompile:from: #simpleBindingFor: #sourceCodeTemplate)
(''enumerating'' #allGeneralInstancesDo: #allInstancesDo: #allSubclassesDo: #allSubInstancesDo:)
(''fileIn/Out'' #printMethod:on:)
(''private'' #accumulateInstVarNames: #allInstancesNoRetry: #behaviorTypeForFormat: #copyMethodDictionary #defaultSelectorForMethod: #flushVMmethodCache #flushVMmethodCacheEntriesFor: #getMethodDictionary #getSubclasses #handleFailedNew:size: #handleFailedNewInFixedSpace:size: #hasSameBehavior: #newInFixedSpaceNoRetry: #newNoRetry: #placeMethod:afterWrappers: #printSubclassesOn:level: #printSubclassesWithStaticsOn:level: #querySetNonArithmeticSpecialSelectorInlining: #removeSelectorSimply: #setInstanceFormat: #setSuperclass:)
(''constants'' #fixedFieldsMask #indexableMask #pointersMask)
(''recompiling'' #rebindAllMethods #rebindAllMethods: #rebindMethod:oldVariableNames: #rebindSelector: #rebindSelector:oldVariableNames:)
(''binary storage'' #allocateGeneralOn: #rebindLoadedMethod:oldVariableNames:)
(''user interface'' #inspectorCollaborators #inspectorHierarchies #protectedInstVarNames)
(''RefactoringBrowser'' #browserIcon #fullRootName #fullRootNameInto: #parseTreeFor: #whichClassDefinesInstVar: #whichClassDefinesSharedVariable: #whichClassSatisfies:)
(''probes'' #revertAllProbedMethods #revertAllProbedMethodsInTree)
(''Camp Smalltalk'' #sunitAllSelectors #sunitSelectors)
(''aspects'' #aspectClasses #aspects #wrapperClasses #wrappers)
'!

!AspectS.AsCounterSetTraceAspectTest methodsFor: 'running'!

testSetTrace

	| counter aspect |
	counter := AsCounter new.
	aspect := self aspectClass new.
	aspect install.
	self shouldnt: [
			aspect addReceiver: counter.
			counter
				n: 10;
				inc;
				n: 20;
				dec;
				n: -1.
			aspect removeReceiver: counter.
			counter n: 251.
		] raise: Exception.
	aspect uninstall.
	self assert: aspect trace = self expectedTrace.! !

!AspectS.AsCounterSetTraceAspectTest methodsFor: 'private'!

aspectClass

	^ AsCounterSetTraceAspect!

expectedTrace

	^ '
AsCounter>>n: before n = 0	after n = 10
AsCounter>>n: before n = 10	after n = 11
AsCounter>>n: before n = 11	after n = 20
AsCounter>>n: before n = 20	after n = 19
AsCounter>>n: before n = 19	after n = -1'! !


!AspectS.AsPrefixVisitorAlternativeAspect methodsFor: 'advice'!

adviceVisitLeaf

	^ AsIntroductionAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsLeaf targetSelector: #printPrefix)]
		introBlock: [:receiver :arguments :aspect :client |
			receiver value printString]!

adviceVisitNode

	^ AsIntroductionAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsNode targetSelector: #printPrefix)]
		introBlock: [:receiver :arguments :aspect :client |
			'(', receiver op asString, ' ',
				receiver first printPrefix, ' ',
					receiver second printPrefix, ')']! !


!AspectS.AsInfixVisitorAlternative2AspectTest methodsFor: 'running'!

testInfixVisitorAlternative

	self assert: self expectedTrace = self buildTree printInfix.! !

!AspectS.AsInfixVisitorAlternative2AspectTest methodsFor: 'private'!

aspectClass

	^ AsInfixVisitorAlternative2Aspect!

expectedTrace

	^ '(((1 + 2) * (3 - 4)) / 5)'! !


!AspectS.AsCFlowAllButFirstInstanceRGAWrapperTest methodsFor: 'running'!

setUp

	self
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.! !

!AspectS.AsCFlowAllButFirstInstanceRGAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ '
callNTimes-in: 4
callNTimes-in: 3
callNTimes-in: 2
callNTimes-in: 1
callNTimes-in: 0
callNTimes-out(0): 0
callNTimes-out(1): 1
callNTimes-out(2): 3
callNTimes-out(3): 6
callNTimes-out(4): 10'!

expectedObjectRecursionTrace

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverClassSpecificActivator;
		add: self wrapperClass cfAllButFirstInstanceActivator.! !


!AspectS.AsSenderGeneralHWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0.!

testNoSender

	| wrapper instance |
	instance := AsA new.
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	self assert: self result = 0.
	wrapper := self wrapperClass on: #signalNotFoundError inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: NotFoundError;
		handlerBlock: [:receiver :arguments :aspect :client :ex | 42];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 0.!

testSender

	| wrapper instance |
	instance := AsA new.
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	self assert: self result = 0.
	wrapper := self wrapperClass on: #signalNotFoundError inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: NotFoundError;
		handlerBlock: [:receiver :arguments :aspect :client :ex | 42];
		install.
	self aspekt addSenderClass: self class.
	self
		shouldnt: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 42.!

testSenderMoreGeneralClass

	| wrapper instance |
	instance := AsA new.
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	self assert: self result = 0.
	wrapper := self wrapperClass on: #signalNotFoundError inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: NotFoundError;
		handlerBlock: [:receiver :arguments :aspect :client :ex | 42];
		install.
	self aspekt addSenderClass: self class superclass.
	self
		shouldnt: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	self aspekt removeSenderClass: self class superclass.
	wrapper uninstall.
	self assert: self result = 42.!

testSenderWrongClass

	| wrapper instance |
	instance := AsA new.
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	self assert: self result = 0.
	wrapper := self wrapperClass on: #signalNotFoundError inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: NotFoundError;
		handlerBlock: [:receiver :arguments :aspect :client :ex | 42];
		install.
	self aspekt addSenderClass: Compiler.
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	self aspekt removeSenderClass: Compiler.
	wrapper uninstall.
	self assert: self result = 0.! !

!AspectS.AsSenderGeneralHWrapperTest methodsFor: 'private'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass senderClassSpecificActivator.! !




!AspectS.AsHandlerWrapper class methodsFor: 'class initialization'!

initialize
	"doIt: [self initialize]"

	super initialize.! !

!AspectS.AsHandlerWrapper methodsFor: 'accessing'!

exception
	"^ <Exception class>"

	^ exception!

exception: anExceptionClass

	exception := anExceptionClass.!

handlerBlock
	"^ <BlockClosure>"

	^ handlerBlock!

handlerBlock: aBlockClosure

	handlerBlock := aBlockClosure.! !

!AspectS.AsHandlerWrapper methodsFor: 'evaluating'!

valueWithReceiver: anObject arguments: anArrayOfObjects

	| client active |
	client := thisContext baseClient.
	active := self isActive.
	^ [
		self clientMethod valueWithReceiver: anObject arguments: anArrayOfObjects.
	] on: self exception do: [:ex |
		active
			ifTrue: [self handlerBlock copy valueWithArguments: (Array
					with: anObject
					with: anArrayOfObjects
					with: self aspect
					with: client
					with: ex)]
			ifFalse: [ex pass]]! !

!AspectS.AsHandlerWrapper methodsFor: 'initialization'!

class: aClass selector: aSymbol

	super class: aClass selector: aSymbol.
	self
		exception: Error;
		handlerBlock: [:receiver :arguments :aspekt :client :ex | ].! !

!AspectS.AsHandlerWrapper methodsFor: 'installation'!

uninstall

	self flag: #rhi. "self clientMethod ifNil: [^ self]."
	self flag: #rhi. "VW?: self handlerBlock instVarNamed: 'home' put: nil."
	self flag: #rhi. "self handlerBlock: nil."
	super uninstall.! !


!AspectS.AsPrefixVisitorAlternativeAspectTest methodsFor: 'running'!

testPrefixVisitorAlternative

	| tree infixAspect |
	tree := self buildTree.
	infixAspect := self aspectClass new.
	self should: [tree printPrefix] raise: Error.
	infixAspect install.
	self assert: self expectedTrace = tree printPrefix.
	infixAspect uninstall.
	self should: [tree printPrefix] raise: Error.! !

!AspectS.AsPrefixVisitorAlternativeAspectTest methodsFor: 'private'!

aspectClass

	^ AsPrefixVisitorAlternativeAspect!

buildTree

	^ AsNode
		first: (AsNode
			first: (AsNode
				first: (AsLeaf value: 1)
				op: #+
				second: (AsLeaf value: 2))
			op: #*
			second: (AsNode
				first: (AsLeaf value: 3)
				op: #-
				second: (AsLeaf value: 4)))
		op: #/
		second: (AsLeaf value: 5)!

expectedTrace

	^ '(/ (* (+ 1 2) (- 3 4)) 5)'! !


!AspectS.AsFactorial2TraceAspectTest methodsFor: 'running'!

testFactorialTrace

	| aspect fact |
	aspect := self aspectClass new.
	aspect install.
	fact := AsFactorial2 new factorial: 5.
	aspect uninstall.
	self assert: fact = 120.
	self assert: aspect trace = self expectedTrace.
	self assert: aspect traceFirst = self expectedTraceFirst.
	self assert: aspect traceAllButFirst = self expectedTraceAllButFirst.! !

!AspectS.AsFactorial2TraceAspectTest methodsFor: 'private'!

aspectClass

	^ AsFactorial2TraceAspect!

expectedTrace

	^ '
factorial2-in: 5
factorial2-in: 4
factorial2-in: 3
factorial2-in: 2
factorial2-in: 1
factorial2-in: 0
factorial2-out(0): 1
factorial2-out(1): 1
factorial2-out(2): 2
factorial2-out(3): 6
factorial2-out(4): 24
factorial2-out(5): 120'!

expectedTraceAllButFirst

	^ '
*factorial2-in: 4
*factorial2-in: 3
*factorial2-in: 2
*factorial2-in: 1
*factorial2-in: 0
*factorial2-out(0): 1
*factorial2-out(1): 1
*factorial2-out(2): 2
*factorial2-out(3): 6
*factorial2-out(4): 24'!

expectedTraceFirst

	^ '
#factorial2-in: 5
#factorial2-out(5): 120'! !


!AspectS.AsCFlowFirstClassSGHWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: self class.
	self
		shouldnt: [instance failInNTimes: 5]
		raise: Error.
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: instance class.
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: self class.
	self
		shouldnt: [instance createAndFailInNTimes: 5]
		raise: Error.
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: instance class.
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowFirstClassSGHWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
failInNTimes-n: 5'!

expectedMethodRecursionTrace3

	^ ''!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndFailInNTimes-n: 5'!

expectedObjectRecursionTrace3

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderClassSpecificActivator;
		add: self wrapperClass cfFirstClassActivator.! !


!AspectS.AsBeforeAfterWrapper class methodsFor: 'class initialization'!

initialize
	"doIt: [self initialize]"

	super initialize.! !

!AspectS.AsBeforeAfterWrapper methodsFor: 'accessing'!

afterBlock
	"^ <BlockClosure>"

	^ afterBlock!

afterBlock: aBlockClosure

	afterBlock := aBlockClosure.!

beforeBlock
	"^ <BlockClosure>"

	^ beforeBlock!

beforeBlock: aBlockClosure

	beforeBlock := aBlockClosure.! !

!AspectS.AsBeforeAfterWrapper methodsFor: 'evaluating'!

valueWithReceiver: anObject arguments: anArrayOfObjects

	| client active return |
	client := thisContext baseClient.
	active := self isActive.
	active ifTrue: [self beforeBlock copy valueWithArguments: (Array
			with: anObject
			with: anArrayOfObjects
			with: self aspect
			with: client)].
	return := self clientMethod valueWithReceiver: anObject arguments: anArrayOfObjects.
	active ifTrue: [self afterBlock copy valueWithArguments: (Array
			with: anObject
			with: anArrayOfObjects
			with: self aspect
			with: client
			with: return)].
	^ return! !

!AspectS.AsBeforeAfterWrapper methodsFor: 'initialization'!

class: aClass selector: aSymbol

	super class: aClass selector: aSymbol.
	self
		beforeBlock: [:receiver :arguments :aspekt :client | ];
		afterBlock: [:receiver :arguments :aspekt :client :return | ].! !

!AspectS.AsBeforeAfterWrapper methodsFor: 'installation'!

uninstall

	self flag: #rhi. "self clientMethod ifNil: [^ self]."
	self flag: #rhi. "VW?: self beforeBlock instVarNamed: 'home' put: nil."
	self flag: #rhi. "self beforeBlock: nil."
	self flag: #rhi. "VW?: self afterBlock instVarNamed: 'home' put: nil."
	self flag: #rhi. "self afterBlock: nil."
	super uninstall.! !


!AspectS.AsAroundAdvice class methodsFor: 'instance creation'!

qualifier: anAsAdviceQualifier pointcut: aPointcutBlockClosure aroundBlock: anAroundBlockClosure

	^ super new
		qualifier: anAsAdviceQualifier;
		pointcut: aPointcutBlockClosure;
		aroundBlock: anAroundBlockClosure! !

!AspectS.AsAroundAdvice methodsFor: 'accessing'!

aroundBlock
	"^ <BlockClosure>"

	^ aroundBlock!

aroundBlock: aBlockClosure

	aroundBlock := aBlockClosure.! !

!AspectS.AsAroundAdvice methodsFor: 'weaving'!

buildWrappers

	| wrapper |
	self pointcut value do: [:join |
		wrapper := self wrapperClass on: join targetSelector inClass: join targetClass.
		wrapper ifNil: [self error: 'Failed to create wrapper.'].
		self qualifier setActivatorsFor: wrapper.
		self aroundBlock ifNotNil: [wrapper aroundBlock: self aroundBlock copy].
		self wrappers add: wrapper].!

wrapperClass

	^ AsAroundWrapper! !


!AspectS.AsPrefixVisitorAspect methodsFor: 'visiting'!

visitNode: anAsNode

	self trace nextPutAll: '('.
	self trace nextPutAll: anAsNode op asString, ' '.
	anAsNode first acceptVisitor: self.
	self trace nextPutAll: ' '.
	anAsNode second acceptVisitor: self.
	self trace nextPutAll: ')'.! !


!AspectS.AsSenderSpecificHWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0.!

testNoSender

	| wrapper instance |
	instance := AsA new.
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	self assert: self result = 0.
	wrapper := self wrapperClass on: #signalNotFoundError inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: NotFoundError;
		handlerBlock: [:receiver :arguments :aspect :client :ex | 42];
		install.
	"*** self aspekt addSender: self. ***"
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 0.!

testSender

	| wrapper instance |
	instance := AsA new.
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	self assert: self result = 0.
	wrapper := self wrapperClass on: #signalNotFoundError inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: NotFoundError;
		handlerBlock: [:receiver :arguments :aspect :client :ex | 42];
		install.
	self aspekt addSender: self.
	self
		shouldnt: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = 42.! !

!AspectS.AsSenderSpecificHWrapperTest methodsFor: 'private'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass senderInstanceSpecificActivator.! !


!AspectS.AsCFlowAllButFirstClassRSAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.! !

!AspectS.AsCFlowAllButFirstClassRSAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
callNTimes-in: 4
callNTimes-in: 3
callNTimes-in: 2
callNTimes-in: 1
callNTimes-in: 0
callNTimes-out(0): 0
callNTimes-out(1): 1
callNTimes-out(2): 3
callNTimes-out(3): 6
callNTimes-out(4): 10'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverInstanceSpecificActivator;
		add: self wrapperClass cfAllButFirstClassActivator.! !



!AspectS.AsCFlowFirstInstanceRSAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.! !

!AspectS.AsCFlowFirstInstanceRSAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
callNTimes-in: 5
callNTimes-out(5): 15'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndCallNTimes-in: 5
createAndCallNTimes-out(5): 15'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverInstanceSpecificActivator;
		add: self wrapperClass cfFirstInstanceActivator.! !


!AspectS.AsAspectAnnotationsTest methodsFor: 'running'!

testAnnotationsForAt

	| aspect |
	aspect := self aspectClass new.
	self
		should: [aspect annotationsFor: self at: #value]
		raise: Error. "key not found"!

testAnnotationsForAtPut

	| aspect |
	aspect := self aspectClass new.
	aspect annotationsFor: self at: #value put: 3.
	aspect annotationsFor: self
		at: #value
		put: (aspect annotationsFor: self at: #value) + 4.
	self assert: aspect clientAnnotations size = 1.
	self assert: (aspect clientAnnotations keys includes: self).
	self assert: (aspect annotationsFor: self at: #value) == 7.!

testAnnotationsForAtPut2

	| aspect |
	aspect := self aspectClass new.
	aspect annotationsFor: self at: #value put: 3.
	aspect annotationsFor: self
		at: #value
		put: (aspect annotationsFor: self at: #value) + 4.
	aspect annotationsFor: self at: #anotherValue put: 69.
	aspect annotationsFor: aspect at: #aspect put: aspect.
	self assert: aspect clientAnnotations size = 2.
	self assert: (aspect clientAnnotations keys includes: self).
	self assert: (aspect clientAnnotations keys includes: aspect).
	self assert: (aspect annotationsFor: self at: #value) == 7.
	self assert: (aspect annotationsFor: self at: #anotherValue) == 69.
	self assert: (aspect annotationsFor: aspect at: #aspect) == aspect.!

testClientAnnotationsAt

	| aspect annotations |
	aspect := self aspectClass new.
	annotations := aspect clientAnnotationsAt: self.
	self assert: (annotations isMemberOf: IdentityDictionary).
	self assert: annotations isEmpty.! !

!AspectS.AsAspectAnnotationsTest methodsFor: 'private'!

aspectClass

	^ AsAspect! !


!AspectS.AsReceiverGeneralHWrapperTest methodsFor: 'running'!

setUp

	self result: 0.!

testException

	| wrapper instance |
	instance := AsA new.
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	self assert: self result = 0.
	wrapper := self wrapperClass on: #signalNotFoundError inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		exception: NotFoundError;
		handlerBlock: [:receiver :arguments :aspect :client :ex | 42];
		install.
	self
		shouldnt: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	wrapper uninstall.
	self assert: self result = 42.!

testInstallInstantiateUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper install.
	instance := AsA new.
	instance mOne.
	wrapper uninstall.
	instance mOne.!

testInstallUninstall

	| wrapper |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).
	wrapper install.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: self wrapperClass).
	wrapper uninstall.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).!

testInstantiateInstallUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	instance := AsA new.
	instance mOne.
	wrapper install.
	instance mOne.
	wrapper uninstall.
	instance mOne.!

testNoException

	| wrapper instance |
	instance := AsA new.
	self shouldnt: [self result: instance signalNoException] raise: Exception.
	self assert: self result = 69.
	wrapper := self wrapperClass on: #signalNoException inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		exception: Exception;
		handlerBlock: [:receiver :arguments :aspect :client :ex | 42];
		install.
	self shouldnt: [self result: instance signalNoException] raise: Exception.
	wrapper uninstall.
	self assert: self result = 69.!

testOtherException

	| wrapper instance |
	instance := AsA new.
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	self assert: self result = 0.
	wrapper := self wrapperClass on: #signalNotFoundError inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		exception: EndOfStreamNotification;
		handlerBlock: [:receiver :arguments :aspect :client :ex | 42];
		install.
	self
		should: [self result: instance signalNotFoundError]
		raise: NotFoundError.
	wrapper uninstall.
	self assert: self result = 0.! !

!AspectS.AsReceiverGeneralHWrapperTest methodsFor: 'private'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass receiverClassSpecificActivator.! !



!AspectS.AsCFlowFirstClassRSAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.! !

!AspectS.AsCFlowFirstClassRSAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
callNTimes-in: 5
callNTimes-out(5): 15'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndCallNTimes-in: 5
createAndCallNTimes-out(5): 15'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverInstanceSpecificActivator;
		add: self wrapperClass cfFirstClassActivator.! !


!AspectS.AsCFlowAllButFirstClassSGAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance callNTimes: 5).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance callNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance callNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance createAndCallNTimes: 5).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return :=clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowAllButFirstClassSGAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ ''!

expectedMethodRecursionTrace3

	^ '
callNTimes-in: 4
callNTimes-in: 3
callNTimes-in: 2
callNTimes-in: 1
callNTimes-in: 0
callNTimes-out(0): 0
callNTimes-out(1): 1
callNTimes-out(2): 3
callNTimes-out(3): 6
callNTimes-out(4): 10'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

expectedObjectRecursionTrace3

	^ '
createAndCallNTimes-in: 4
createAndCallNTimes-in: 3
createAndCallNTimes-in: 2
createAndCallNTimes-in: 1
createAndCallNTimes-in: 0
createAndCallNTimes-out(0): 0
createAndCallNTimes-out(1): 1
createAndCallNTimes-out(2): 3
createAndCallNTimes-out(3): 6
createAndCallNTimes-out(4): 10'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderClassSpecificActivator;
		add: self wrapperClass cfAllButFirstClassActivator.! !


!AspectS.AsCounterSetTraceAspect methodsFor: 'accessing'!

trace
	"^ <String>"

	^ trace!

trace: aString

	trace := aString.! !

!AspectS.AsCounterSetTraceAspect methodsFor: 'advice'!

adviceAutoReset

	^ AsBeforeAfterAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverInstanceSpecific))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsCounter targetSelector: #n:)]
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, receiver class name, '>>', 'n: before n = ', receiver n printString.
			self trace: self trace, msg.
			"Transcript show: msg"]
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String tab, 'after n = ', receiver n printString.
			self trace: self trace, msg.
			"Transcript show: msg"]! !

!AspectS.AsCounterSetTraceAspect methodsFor: 'initialization'!

initialize

	super initialize.
	self trace: String new.! !


!AspectS.AsCFlowFirstInstanceRGHWrapperTest methodsFor: 'running'!

setUp

	self trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		shouldnt: [instance failInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		shouldnt: [instance createAndFailInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace.! !

!AspectS.AsCFlowFirstInstanceRGHWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ '
failInNTimes-n: 5'!

expectedObjectRecursionTrace

	^ '
createAndFailInNTimes-n: 0'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverClassSpecificActivator;
		add: self wrapperClass cfFirstInstanceActivator.! !


!AspectS.AsSenderSpecificAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0.!

testInstallInstantiateUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		install.
	instance := AsA new.
	instance mOne.
	wrapper uninstall.
	instance mOne.!

testInstallUninstall

	| wrapper |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).
	wrapper
		aspect: self aspekt;
		install.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: self wrapperClass).
	wrapper uninstall.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).!

testInstantiateInstallUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	instance := AsA new.
	instance mOne.
	wrapper
		aspect: self aspekt;
		install.
	instance mOne.
	wrapper uninstall.
	instance mOne.!

testNoSender

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return |
			arguments at: 1 put: arguments first * 2.
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			return squared];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance addToX: 3).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: instance x = 3.
	self assert: self result = 3.!

testSender

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return |
			arguments at: 1 put: arguments first * 2.
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			return squared];
		install.
	self aspekt addSender: self.
	self result: (instance addToX: 3).
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: instance x = 6.
	self assert: self result = 36.! !

!AspectS.AsSenderSpecificAWrapperTest methodsFor: 'private'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass senderInstanceSpecificActivator.! !


!AspectS.AsCFlowFirstInstanceSSAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance callNTimes: 5).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSender: self.
	self result: (instance callNTimes: 5).
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSender: instance.
	self result: (instance callNTimes: 5).
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance createAndCallNTimes: 5).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSender: self.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self aspekt addSender: instance.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowFirstInstanceSSAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
callNTimes-in: 5
callNTimes-out(5): 15'!

expectedMethodRecursionTrace3

	^ ''!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndCallNTimes-in: 5
createAndCallNTimes-out(5): 15'!

expectedObjectRecursionTrace3

	^ '
createAndCallNTimes-in: 4
createAndCallNTimes-out(4): 10'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderInstanceSpecificActivator;
		add: self wrapperClass cfFirstInstanceActivator.! !


!AspectS.AsIntroductionWrapperTest methodsFor: 'running'!

testCanIntroduceInClass

	"Introduction into method wrappers NOT allowed."
	self deny: (self wrapperClass canIntroduce: #spunk inClass: self wrapperClass).

	"A message/method that is implemented by a class can NOT be (re-) introduced."
	self assert: ((AsA canUnderstand: #mOne)
		and: [(self wrapperClass canIntroduce: #mOne inClass: AsA) not]).

	"A message/method that is not understood by a mOne CAN be introduced."
	self assert: ((AsA canUnderstand: #ensure:) not
		and: [self wrapperClass canIntroduce: #ensure: inClass: AsA]).

	"A message/method that is understood but not implemented by a mOne CAN be introduced."
	self assert: (((AsB canUnderstand: #mOne)
		and: [(AsB includesSelector: #mOne) not])
			and: [self wrapperClass canIntroduce: #mOne inClass: AsB]).!

testClassInstVars

	self assert: self wrapperClass class instVarNames size = 0.
	self assert: self wrapperClass classVarNames size = 0.

	self assert: self wrapperClass protoMethods notNil.
	self assert: (self wrapperClass protoMethods isMemberOf: Dictionary).!

testDefiningWrappedDifferent

	| wrapper clientSelector wrappedClass |
	clientSelector := #mOne.
	wrappedClass := AsB.
	wrapper := self wrapperClass on: clientSelector inClass: wrappedClass.
	wrapper install.
	self assert: wrapper wrappedClass == wrappedClass.
	wrapper uninstall.!

testDefiningWrappedSame

	| wrapper clientSelector wrappedClass |
	clientSelector := #mOne.
	wrappedClass := AsA.
	wrapper := self wrapperClass on: clientSelector inClass: wrappedClass.
	self assert: wrapper isNil.!

testInstallUninstall

	| wrapper |
	wrapper := self wrapperClass on: #class inClass: AsA.
	self
		should: [AsA compiledMethodAt: #class]
		raise: Error.
	wrapper install.
	self assert: ((AsA compiledMethodAt: #class) isMemberOf: self wrapperClass).
	wrapper uninstall.
	self
		should: [AsA compiledMethodAt: #class]
		raise: Error.!

testNoProtoInstanceCount

	| allInstCount protoInstCount |
	self flag: #rhi. "VW?: self wrapperClass tempNameCache: nil."
	ObjectMemory garbageCollect.
	allInstCount := self wrapperClass allInstances size.
	protoInstCount := self wrapperClass protoMethods size.
	self assert: (allInstCount - protoInstCount) = 0.!

testOnInClass

	| wrapper clientSelector wrappedClass |
	clientSelector := #class.
	wrappedClass := AsA.
	wrapper := self wrapperClass on: clientSelector inClass: wrappedClass.
	self assert: wrapper clientSelector == clientSelector.
	self assert: wrapper clientMethod isNil.
	self assert: wrapper definingClass isNil.
	self assert: wrapper wrappedClass == wrappedClass.
	self assert: wrapper wrappingWrapper isNil.
	self assert: wrapper aspect isNil.
	self assert: wrapper advice isNil.
	self assert: (wrapper activators isMemberOf: Set).
	self assert: wrapper introBlock notNil.
	self assert: (wrapper realBasicAt: wrapper methodPosition) == wrapper.
	self assert: (wrapper realBasicAt: wrapper arrayPosition) == Array.
	wrapper uninstall.! !

!AspectS.AsIntroductionWrapperTest methodsFor: 'private'!

wrapperClass

	^ AsIntroductionWrapper! !


!AspectS.AsReceiverGeneralIWrapperTest methodsFor: 'running'!

setUp

	self result: 0.!

testInstallInstantiateUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper install.
	instance := AsA new.
	instance sixtyNine.
	wrapper uninstall.
	self
		should: [instance sixtyNine]
		raise: MessageNotUnderstood.!

testInstallUninstall

	| wrapper |
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	self
		should: [AsA compiledMethodAt: #class]
		raise: Error.
	wrapper install.
	self assert: ((AsA compiledMethodAt: #sixtyNine) isMemberOf: self wrapperClass).
	wrapper uninstall.
	self
		should: [AsA compiledMethodAt: #class]
		raise: Error.!

testInstantiateInstallUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	instance := AsA new.
	self
		should: [instance sixtyNine]
		raise: MessageNotUnderstood.
	wrapper install.
	instance sixtyNine.
	wrapper uninstall.
	self
		should: [instance sixtyNine]
		raise: MessageNotUnderstood.!

testSixtyNine

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		introBlock: [:receiver :arguments :aspect :client | 69];
		install.
	self result: (instance sixtyNine).
	wrapper uninstall.
	self assert: self result = 69.! !

!AspectS.AsReceiverGeneralIWrapperTest methodsFor: 'private'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass receiverClassSpecificActivator.! !


!AspectS.AsSenderGeneralIWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0.!

testInstallInstantiateUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		install.
	instance := AsA new.
	instance sixtyNine.
	wrapper uninstall.
	self
		should: [instance sixtyNine]
		raise: MessageNotUnderstood.!

testInstallUninstall

	| wrapper |
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	self
		should: [AsA compiledMethodAt: #class]
		raise: Error.
	wrapper
		aspect: self aspekt;
		install.
	self assert: ((AsA compiledMethodAt: #sixtyNine) isMemberOf: self wrapperClass).
	wrapper uninstall.
	self
		should: [AsA compiledMethodAt: #class]
		raise: Error.!

testInstantiateInstallUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	instance := AsA new.
	self
		should: [instance sixtyNine]
		raise: MessageNotUnderstood.
	wrapper
		aspect: self aspekt;
		install.
	instance sixtyNine.
	wrapper uninstall.
	self
		should: [instance sixtyNine]
		raise: MessageNotUnderstood.!

testNoSender

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		introBlock: [:receiver :arguments :aspect :client | 69];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance sixtyNine).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result isNil.!

testSender

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		introBlock: [:receiver :arguments :aspect :client | 69];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance sixtyNine).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result == 69.!

testSenderMoreGeneralClass

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		introBlock: [:receiver :arguments :aspect :client | 69];
		install.
	self aspekt addSenderClass: self class superclass.
	self result: (instance sixtyNine).
	self aspekt removeSenderClass: self class superclass.
	wrapper uninstall.
	self assert: self result == 69.!

testSenderWrongClass

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		introBlock: [:receiver :arguments :aspect :client | 69];
		install.
	self aspekt addSenderClass: Compiler.
	self result: (instance sixtyNine).
	self aspekt removeSenderClass: Compiler.
	wrapper uninstall.
	self assert: self result isNil.! !

!AspectS.AsSenderGeneralIWrapperTest methodsFor: 'private'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass senderClassSpecificActivator.! !


!AspectS.AsSenderSpecificIWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0.!

testInstallInstantiateUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		install.
	instance := AsA new.
	instance sixtyNine.
	wrapper uninstall.
	self
		should: [instance sixtyNine]
		raise: MessageNotUnderstood.!

testInstallUninstall

	| wrapper |
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	self
		should: [AsA compiledMethodAt: #class]
		raise: Error.
	wrapper
		aspect: self aspekt;
		install.
	self assert: ((AsA compiledMethodAt: #sixtyNine) isMemberOf: self wrapperClass).
	wrapper uninstall.
	self
		should: [AsA compiledMethodAt: #class]
		raise: Error.!

testInstantiateInstallUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	instance := AsA new.
	self
		should: [instance sixtyNine]
		raise: MessageNotUnderstood.
	wrapper
		aspect: self aspekt;
		install.
	instance sixtyNine.
	wrapper uninstall.
	self
		should: [instance sixtyNine]
		raise: MessageNotUnderstood.!

testNoSender

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		introBlock: [:receiver :arguments :aspect :client | 69];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance sixtyNine).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result isNil.!

testSender

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		introBlock: [:receiver :arguments :aspect :client | 69];
		install.
	self aspekt addSender: self.
	self result: (instance sixtyNine).
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result == 69.! !

!AspectS.AsSenderSpecificIWrapperTest methodsFor: 'private'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass senderInstanceSpecificActivator.! !


!AspectS.AsPostfixVisitorAlternativeAspectTest methodsFor: 'running'!

testPostfixVisitorAlternative

	| tree infixAspect |
	tree := self buildTree.
	infixAspect := self aspectClass new.
	self should: [tree printPostfix] raise: Error.
	infixAspect install.
	self assert: self expectedTrace = tree printPostfix.
	infixAspect uninstall.
	self should: [tree printPostfix] raise: Error.! !

!AspectS.AsPostfixVisitorAlternativeAspectTest methodsFor: 'private'!

aspectClass

	^ AsPostfixVisitorAlternativeAspect!

buildTree

	^ AsNode
		first: (AsNode
			first: (AsNode
				first: (AsLeaf value: 1)
				op: #+
				second: (AsLeaf value: 2))
			op: #*
			second: (AsNode
				first: (AsLeaf value: 3)
				op: #-
				second: (AsLeaf value: 4)))
		op: #/
		second: (AsLeaf value: 5)!

expectedTrace

	^ '(((1 2 +) (3 4 -) *) 5 /)'! !


!AspectS.AsCFlowFirstInstanceSSHWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSender: self. ***"
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: self.
	self
		shouldnt: [instance failInNTimes: 5]
		raise: Error.
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: instance.
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSender: self. ***"
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: self.
	self
		shouldnt: [instance createAndFailInNTimes: 5]
		raise: Error.
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: instance.
	self
		shouldnt: [instance createAndFailInNTimes: 5]
		raise: Error.
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowFirstInstanceSSHWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
failInNTimes-n: 5'!

expectedMethodRecursionTrace3

	^ ''!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndFailInNTimes-n: 5'!

expectedObjectRecursionTrace3

	^ '
createAndFailInNTimes-n: 4'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderInstanceSpecificActivator;
		add: self wrapperClass cfFirstInstanceActivator.! !


!AspectS.AsInfixVisitorAlternativeAspect methodsFor: 'advice'!

adviceVisitLeaf

	^ AsIntroductionAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsLeaf targetSelector: #printInfix)]
		introBlock: [:receiver :arguments :aspect :client |
			receiver value printString]!

adviceVisitNode

	^ AsIntroductionAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsNode targetSelector: #printInfix)]
		introBlock: [:receiver :arguments :aspect :client |
			'(', receiver first printInfix, ' ',
				receiver op asString, ' ',
					receiver second printInfix, ')']! !


!AspectS.AsCFlowFirstClassRSHWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		shouldnt: [instance failInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		shouldnt: [instance createAndFailInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self trace contents = self expectedObjectRecursionTrace2.! !

!AspectS.AsCFlowFirstClassRSHWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
failInNTimes-n: 5'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndFailInNTimes-n: 5'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverInstanceSpecificActivator;
		add: self wrapperClass cfFirstClassActivator.! !


!AspectS.AsCFlowAllButFirstClassRGAWrapperTest methodsFor: 'running'!

setUp

	self
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aroundBlock: [:receiver :arguments :aspect :client :clientMethod |
			| return msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return := clientMethod valueWithReceiver: receiver arguments: arguments.
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg."
			return];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.! !

!AspectS.AsCFlowAllButFirstClassRGAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ '
callNTimes-in: 4
callNTimes-in: 3
callNTimes-in: 2
callNTimes-in: 1
callNTimes-in: 0
callNTimes-out(0): 0
callNTimes-out(1): 1
callNTimes-out(2): 3
callNTimes-out(3): 6
callNTimes-out(4): 10'!

expectedObjectRecursionTrace

	^ '
createAndCallNTimes-in: 4
createAndCallNTimes-in: 3
createAndCallNTimes-in: 2
createAndCallNTimes-in: 1
createAndCallNTimes-in: 0
createAndCallNTimes-out(0): 0
createAndCallNTimes-out(1): 1
createAndCallNTimes-out(2): 3
createAndCallNTimes-out(3): 6
createAndCallNTimes-out(4): 10'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverClassSpecificActivator;
		add: self wrapperClass cfAllButFirstClassActivator.! !


!AspectS.AsReceiverSpecificIWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0.!

testInstallInstantiateUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		install.
	instance := AsA new.
	instance sixtyNine.
	wrapper uninstall.
	self
		should: [instance sixtyNine]
		raise: MessageNotUnderstood.!

testInstallUninstall

	| wrapper |
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	self
		should: [AsA compiledMethodAt: #class]
		raise: Error.
	wrapper
		aspect: self aspekt;
		install.
	self assert: ((AsA compiledMethodAt: #sixtyNine) isMemberOf: self wrapperClass).
	wrapper uninstall.
	self
		should: [AsA compiledMethodAt: #class]
		raise: Error.!

testInstantiateInstallUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	instance := AsA new.
	self
		should: [instance sixtyNine]
		raise: MessageNotUnderstood.
	wrapper
		aspect: self aspekt;
		install.
	instance sixtyNine.
	wrapper uninstall.
	self
		should: [instance sixtyNine]
		raise: MessageNotUnderstood.!

testSixtyNine

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		introBlock: [:receiver :arguments :aspect :client | 69];
		install.
	self result: (instance sixtyNine).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result isNil.!

testSixtyNine2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #sixtyNine inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		introBlock: [:receiver :arguments :aspect :client | 69];
		install.
	self result: (instance sixtyNine).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 69.! !

!AspectS.AsReceiverSpecificIWrapperTest methodsFor: 'private'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass receiverInstanceSpecificActivator.! !


!AspectS.AsCounterAutoResetAspectTest methodsFor: 'running'!

testAutoReset

	| counter aspect |
	counter := AsCounter new.
	aspect := self aspectClass new.
	aspect install.
	aspect threshold: 10.
	aspect addReceiver: counter.
	self assert: counter n = 0.
	counter inc; inc; inc; inc; inc; inc; inc; dec.
	self assert: counter n = 6.
	self assert: aspect count = 8.
	counter dec; inc.
	self assert: counter n = 0.
	self assert: aspect count = 0.
	counter dec; dec; dec; dec; dec; dec; dec; dec; dec.
	self assert: counter n = -9.
	self assert: aspect count = (aspect threshold - 1).
	counter dec.
	self assert: counter n = 0.
	self assert: aspect count = 0.
	aspect removeReceiver: counter.
	aspect uninstall.! !

!AspectS.AsCounterAutoResetAspectTest methodsFor: 'private'!

aspectClass

	^ AsCounterAutoResetAspect! !


!AspectS.AsPrefixVisitorAspectTest methodsFor: 'running'!

testPrefixTrace

	| aspect |
	aspect := self aspectClass new.
	aspect install.
	self buildTree acceptVisitor: aspect.
	aspect uninstall.
	self assert: aspect trace contents = self expectedTrace.! !

!AspectS.AsPrefixVisitorAspectTest methodsFor: 'private'!

aspectClass

	^ AsPrefixVisitorAspect!

buildTree

	^ AsNode
		first: (AsNode
			first: (AsNode
				first: (AsLeaf value: 1)
				op: #+
				second: (AsLeaf value: 2))
			op: #*
			second: (AsNode
				first: (AsLeaf value: 3)
				op: #-
				second: (AsLeaf value: 4)))
		op: #/
		second: (AsLeaf value: 5)!

expectedTrace

	^ '(/ (* (+ 1 2) (- 3 4)) 5)'! !


!AspectS.AsAdviceQualifier class methodsFor: 'accessing'!

constraints
	"^ <IdentityDictionary key: Symbol value: BlockContext>"

	^ constraints!

constraints: anIdentityDictionary

	constraints := anIdentityDictionary.! !

!AspectS.AsAdviceQualifier class methodsFor: 'class initialization'!

initialize
	"doIt: [self initialize]"

	self constraints: IdentityDictionary new.
	self constraints
		at: #attributesMustBePresent
			put: self constraintAttributesMustBePresent;
		at: #attributesMustBeValid
			put: self constraintAttributesMustBeValid;
		at: #onlyOneSenderOrReceiverAttribute
			put: self constraintOnlyOneSenderOrReceiverAttribute.! !

!AspectS.AsAdviceQualifier class methodsFor: 'constraints'!

constraintAttributesMustBePresent

	^ [:qualifier |
		(qualifier attributes isNil or: [qualifier attributes isEmpty])
			ifTrue: [self error: 'Missing advice qualifier attribute(s).']]!

constraintAttributesMustBeValid

	^ [:qualifier |
		| activatorKeys |
		activatorKeys := AsMethodWrapper protoActivators keys.
		(qualifier attributes allSatisfy: [:each | activatorKeys includes: each])
			ifFalse: [self error: 'Invalid advice qualifier attribute(s).']]!

constraintOnlyOneSenderOrReceiverAttribute

	^[:qualifier |
		| senderReceiverAttributes |
		senderReceiverAttributes := #(
			#receiverClassSpecific
			#receiverInstanceSpecific
			#senderClassSpecific
			#senderInstanceSpecific).
		(qualifier attributes count: [:each | senderReceiverAttributes includes: each]) ~= 1
			ifTrue: [self error: 'Missing or multiple sender-receiver attribute(s).']]! !

!AspectS.AsAdviceQualifier class methodsFor: 'instance creation'!

attributes: aCollection

	^ self new attributes: aCollection asSet! !

!AspectS.AsAdviceQualifier methodsFor: 'accessing'!

attributes
	"^ <Set of: Symbol>"

	^ attributes!

attributes: aSet

	attributes := aSet.! !

!AspectS.AsAdviceQualifier methodsFor: 'comparing'!

= anObject

	^ anObject isAsAdviceQualifier
		and: [self attributes = anObject attributes]!

hash

	^ self attributes hash! !

!AspectS.AsAdviceQualifier methodsFor: 'testing'!

isAsAdviceQualifier

	^ true! !

!AspectS.AsAdviceQualifier methodsFor: 'weaving'!

setActivatorsFor: anAsMethodWrapper

	self validate.
	self attributes do: [:attr |
		anAsMethodWrapper activators
			add: (AsMethodWrapper protoActivators at: attr) copy].!

validate

	| activatorKeys senderReceiverAttributes |
	self flag: #rhi. "Check constraints between attributes (requires, depends, excludes, ...)!!"
	self flag: #rhi. "Refactor!!"

	"--- Test if there are attributes at all. ---"
	(self attributes isNil or: [self attributes isEmpty])
		ifTrue: [self error: 'Missing advice qualifier attribute(s).'].

	"--- Test if all provided attributes are valid activator keys. ---"
	activatorKeys := AsMethodWrapper protoActivators keys.
	(self attributes allSatisfy: [:each | activatorKeys includes: each])
		ifFalse: [self error: 'Invalid advice qualifier attribute(s).'].

	"--- Test if there is exactly one sender/receiver attribute. ---"
	self flag: #rhi. "It would be interesting to allow a combination of these..."
	senderReceiverAttributes := #(
		#receiverClassSpecific
		#receiverInstanceSpecific
		#senderClassSpecific
		#senderInstanceSpecific).
	(self attributes count: [:each | senderReceiverAttributes includes: each]) ~= 1
		ifTrue: [self error: 'Missing or multiple sender-receiver attribute(s).'].! !


!AspectS.AsCFlowAllButFirstClassRSHWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		shouldnt: [instance failInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self trace contents = self expectedObjectRecursionTrace2.! !

!AspectS.AsCFlowAllButFirstClassRSHWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
failInNTimes-n: 0'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverInstanceSpecificActivator;
		add: self wrapperClass cfAllButFirstClassActivator.! !


!AspectS.AsMethodWrapperTest methodsFor: 'running'!

testArrayPosition0

	| expected actual |
	expected := 1.
	actual := (self wrapperClass createMethodFor: 0) arrayPosition.
	self assert: expected = actual.!

testArrayPosition1

	| expected actual |
	expected := 1.
	actual := (self wrapperClass createMethodFor: 1) arrayPosition.
	self assert: expected = actual.!

testArrayPosition2

	| expected actual |
	expected := 1.
	actual := (self wrapperClass createMethodFor: 2) arrayPosition.
	self assert: expected = actual.!

testAspectSpecificInstallOrder

	| wrapperA wrapperB wrapperBA wrapperBB method |
	(wrapperA := self wrapperClass on: #mOne inClass: AsA) aspect: AsAspectA new.
	(wrapperB := self wrapperClass on: #mOne inClass: AsA) aspect: AsAspectB new.
	(wrapperBA := self wrapperClass on: #mOne inClass: AsA) aspect: AsAspectBA new.
	(wrapperBB := self wrapperClass on: #mOne inClass: AsA) aspect: AsAspectBB new.
	method := AsA compiledMethodAt: #mOne.

	self assert: (method isMemberOf: CompiledMethod).

	wrapperA install.
	wrapperB install.
	wrapperBA install.
	wrapperBB install.

	self flag: #rhi. "The important part: BA before B, BB before B."
	self assert: (AsA compiledMethodAt: #mOne) == wrapperA.
	self assert: wrapperA clientMethod == wrapperBA.
	self assert: wrapperBA clientMethod == wrapperBB.
	self assert: wrapperBB clientMethod == wrapperB.
	self assert: wrapperB clientMethod == method.

	wrapperBB uninstall.
	wrapperBA uninstall.
	wrapperB uninstall.
	wrapperA uninstall.

	self assert: (AsA compiledMethodAt: #mOne) == method.!

testAspectSpecificInstallOrder2

	| wrapperA wrapperB wrapperBA wrapperBB method |
	(wrapperA := self wrapperClass on: #mOne inClass: AsA) aspect: AsAspectA new.
	(wrapperB := self wrapperClass on: #mOne inClass: AsA) aspect: AsAspectB new.
	(wrapperBA := self wrapperClass on: #mOne inClass: AsA) aspect: AsAspectBA new.
	(wrapperBB := self wrapperClass on: #mOne inClass: AsA) aspect: AsAspectBB new.
	method := AsA compiledMethodAt: #mOne.

	self assert: (method isMemberOf: CompiledMethod).

	wrapperA install.
	wrapperBA install.
	wrapperBB install.
	wrapperB install.

	self flag: #rhi. "The important part: BA before B, BB before B."
	self assert: (AsA compiledMethodAt: #mOne) == wrapperA.
	self assert: wrapperA clientMethod == wrapperBA.
	self assert: wrapperBA clientMethod == wrapperBB.
	self assert: wrapperBB clientMethod == wrapperB.
	self assert: wrapperB clientMethod == method.

	wrapperB uninstall.
	wrapperBB uninstall.
	wrapperBA uninstall.
	wrapperA uninstall.

	self assert: (AsA compiledMethodAt: #mOne) == method.!

testAspectSpecificInstallOrder3

	| wrapperA wrapperB wrapperBA wrapperBB method |
	(wrapperA := self wrapperClass on: #mOne inClass: AsA) aspect: AsAspectA new.
	(wrapperB := self wrapperClass on: #mOne inClass: AsA) aspect: AsAspectB new.
	(wrapperBA := self wrapperClass on: #mOne inClass: AsA) aspect: AsAspectBA new.
	(wrapperBB := self wrapperClass on: #mOne inClass: AsA) aspect: AsAspectBB new.
	method := AsA compiledMethodAt: #mOne.

	self assert: (method isMemberOf: CompiledMethod).

	wrapperB install.
	wrapperBB install.
	wrapperBA install.
	wrapperA install.

	self flag: #rhi. "The important part: BA before B, BB before B."
	self assert: (AsA compiledMethodAt: #mOne) == wrapperBB.
	self assert: wrapperBB clientMethod == wrapperBA.
	self assert: wrapperBA clientMethod == wrapperB.
	self assert: wrapperB clientMethod == wrapperA.
	self assert: wrapperA clientMethod == method.

	wrapperA uninstall.
	wrapperBA uninstall.
	wrapperBB uninstall.
	wrapperB uninstall.

	self assert: (AsA compiledMethodAt: #mOne) == method.!

testCanWrapInClass

	"Method wrappers can NOT be wrapped."
	self deny: (self wrapperClass canWrap: #spunk inClass: self wrapperClass).

	"BlockClosure>>valueAsUnwindBlockFrom: can NOT be wrapped."
	self deny: (self wrapperClass canWrap: #valueAsUnwindBlockFrom: inClass: BlockClosure).

	"BlockClosure>>ensure: can NOT be wrapped."
	self deny: (self wrapperClass canWrap: #ensure: inClass: BlockClosure).

	"CompiledMethod>>valueWithReceiver:arguments: can NOT be wrapped."
	self deny: (self wrapperClass
		canWrap: #valueWithReceiver:arguments: inClass: CompiledMethod).

	"A method that is not implemented by a class/object can NOT be wrapped."
	self assert: ((Object canUnderstand: #ensure:) not
		and: [(self wrapperClass canWrap: #ensure: inClass: Object) not]).

	"Certain primitives may NOT be wrapped."
	self assert: ((Object includesSelector: #at:put:)
		and: [(self wrapperClass canWrap: #at:put: inClass: Object) not]).
	self assert: ((Behavior includesSelector: #new:)
		and: [(self wrapperClass canWrap: #new: inClass: Behavior) not]).
	self assert: ((BlockClosure includesSelector: #value)
		and: [(self wrapperClass canWrap: #value inClass: BlockContext) not]).!

testChainRemoveLastFirst

	| wrapperOne wrapperTwo |
	wrapperOne := self wrapperClass on: #mOne inClass: AsA.
	wrapperTwo := self wrapperClass on: #mOne inClass: AsA.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).
	wrapperOne install.
	self assert: wrapperOne wrappingWrapper isNil.
	self assert: wrapperOne clientMethod notNil.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperOne.
	wrapperTwo install.
	self assert: wrapperOne wrappingWrapper == wrapperTwo.
	self assert: wrapperTwo wrappingWrapper isNil.
	self assert: wrapperTwo clientMethod == wrapperOne.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperTwo.
	wrapperTwo uninstall.
	self assert: wrapperOne wrappingWrapper isNil.
	self assert: wrapperOne clientMethod notNil.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperOne.
	self assert: wrapperTwo clientMethod isNil.
	wrapperOne uninstall.
	self assert: wrapperOne clientMethod isNil.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).!

testChainRemoveLastFirstHierarchy

	| wrapperOne wrapperTwo |
	wrapperOne := self wrapperClass on: #mOne inClass: AsA.
	wrapperTwo := self wrapperClass on: #mOne inClass: AsB.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).
	wrapperOne install.
	self assert: wrapperOne wrappingWrapper isNil.
	self assert: wrapperOne clientMethod notNil.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperOne.
	wrapperTwo install.
	self assert: wrapperOne wrappingWrapper == wrapperTwo.
	self assert: wrapperTwo wrappingWrapper isNil.
	self assert: wrapperTwo clientMethod == wrapperOne.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperOne.
	self assert: (AsB compiledMethodAt: #mOne) == wrapperTwo.
	wrapperTwo uninstall.
	self assert: wrapperOne wrappingWrapper isNil.
	self assert: wrapperOne clientMethod notNil.
	self assert: wrapperTwo clientMethod isNil.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperOne.
	self assert: (AsB compiledMethodAt: #mOne ifAbsent: [nil]) isNil.
	wrapperOne uninstall.
	self assert: wrapperOne clientMethod isNil.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).!

testChainRemoveMiddleFirst

	| wrapperOne wrapperTwo |
	wrapperOne := self wrapperClass on: #mOne inClass: AsA.
	wrapperTwo := self wrapperClass on: #mOne inClass: AsA.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).
	wrapperOne install.
	self assert: wrapperOne wrappingWrapper isNil.
	self assert: wrapperOne clientMethod notNil.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperOne.
	wrapperTwo install.
	self assert: wrapperOne wrappingWrapper == wrapperTwo.
	self assert: wrapperTwo wrappingWrapper isNil.
	self assert: wrapperTwo clientMethod == wrapperOne.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperTwo.
	wrapperOne uninstall.
	self assert: wrapperOne wrappingWrapper isNil.
	self assert: wrapperTwo clientMethod notNil.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperTwo.
	self assert: wrapperOne clientMethod isNil.
	wrapperTwo uninstall.
	self assert: wrapperTwo clientMethod isNil.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).!

testChainRemoveMiddleFirstHierarchy

	| wrapperOne wrapperTwo |
	wrapperOne := self wrapperClass on: #mOne inClass: AsA.
	wrapperTwo := self wrapperClass on: #mOne inClass: AsB.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).
	wrapperOne install.
	self assert: wrapperOne wrappingWrapper isNil.
	self assert: wrapperOne clientMethod notNil.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperOne.
	wrapperTwo install.
	self assert: wrapperOne wrappingWrapper == wrapperTwo.
	self assert: wrapperTwo wrappingWrapper isNil.
	self assert: wrapperTwo clientMethod == wrapperOne.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperOne.
	self assert: (AsB compiledMethodAt: #mOne) == wrapperTwo.
	wrapperOne uninstall.
	self assert: wrapperOne wrappingWrapper isNil.
	self assert: wrapperOne clientMethod isNil.
	self assert: wrapperTwo clientMethod notNil.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).
	self assert: (AsB compiledMethodAt: #mOne) == wrapperTwo.
	wrapperTwo uninstall.
	self assert: wrapperTwo clientMethod isNil.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).
	self assert: (AsB compiledMethodAt: #mOne ifAbsent: [nil]) isNil.!

testClassInstVars

	self assert: self wrapperClass class instVarNames size = 1.
	self assert: self wrapperClass classVarNames size = 1.

	self assert: self wrapperClass protoMethods notNil.
	self assert: (self wrapperClass protoMethods isMemberOf: Dictionary).!

testCodeString0

	| expected actual |
	expected := 'value
	| t |
	t := #Array new.
	^ #''The method wrapper should be inserted in this position!!'' valueWithReceiver: self arguments: t'.
	actual := self wrapperClass codeStringFor: 0.
	self assert: expected = actual.!

testCodeString1

	| expected actual |
	expected := 'value: t1
	| t |
	(t := #Array new: 1) at: 1 put: t1.
	^ #''The method wrapper should be inserted in this position!!'' valueWithReceiver: self arguments: t'.
	actual := self wrapperClass codeStringFor: 1.
	self assert: expected = actual.!

testCodeString2

	| expected actual |
	expected := 'value: t1 value: t2
	| t |
	(t := #Array new: 2) at: 1 put: t1; at: 2 put: t2.
	^ #''The method wrapper should be inserted in this position!!'' valueWithReceiver: self arguments: t'.
	actual := self wrapperClass codeStringFor: 2.
	self assert: expected = actual.!

testDefiningWrappedDifferent

	| wrapper clientSelector wrappedClass |
	clientSelector := #mOne.
	wrappedClass := AsB.
	wrapper := self wrapperClass on: clientSelector inClass: wrappedClass.
	wrapper install.
	self assert: wrapper definingClass == AsA.
	self assert: wrapper wrappedClass == wrappedClass.
	wrapper uninstall.!

testDefiningWrappedSame

	| wrapper clientSelector wrappedClass |
	clientSelector := #mOne.
	wrappedClass := AsA.
	wrapper := self wrapperClass on: clientSelector inClass: wrappedClass.
	wrapper install.
	self assert: wrapper definingClass == wrappedClass.
	self assert: wrapper wrappedClass == wrappedClass.
	wrapper uninstall.!

testDefiningWrappedSame2

	| wrapper clientSelector wrappedClass |
	clientSelector := #mTwo.
	wrappedClass := AsA.
	wrapper := self wrapperClass on: clientSelector inClass: wrappedClass.
	wrapper install.
	self assert: wrapper definingClass == wrappedClass.
	self assert: wrapper wrappedClass == wrappedClass.
	wrapper uninstall.!

testDefiningWrappedSame3

	| wrapper clientSelector wrappedClass |
	clientSelector := #mTwo.
	wrappedClass := AsB.
	wrapper := self wrapperClass on: clientSelector inClass: wrappedClass.
	wrapper install.
	self assert: wrapper definingClass == wrappedClass.
	self assert: wrapper wrappedClass == wrappedClass.
	wrapper uninstall.!

testDefiningWrappedSame4

	| wrapper clientSelector wrappedClass |
	clientSelector := #mThree.
	wrappedClass := AsB.
	wrapper := self wrapperClass on: clientSelector inClass: wrappedClass.
	wrapper install.
	self assert: wrapper definingClass == wrappedClass.
	self assert: wrapper wrappedClass == wrappedClass.
	wrapper uninstall.!

testInSequenceBeforeOrAt

	| wrapperA wrapperBA wrapperH wrapperI method |
	wrapperA := AsAroundWrapper on: #mOne inClass: AsA.
	wrapperBA := AsBeforeAfterWrapper on: #mOne inClass: AsA.
	wrapperH := AsHandlerWrapper on: #mOne inClass: AsA.
	wrapperI := AsIntroductionWrapper on: #mNegativeOne inClass: AsA.
	method := AsA compiledMethodAt: #mOne.
	self assert: (method isMemberOf: CompiledMethod).

	self assert: (wrapperA inSequenceBeforeOrAt: wrapperA).
	self assert: (wrapperA inSequenceBeforeOrAt: wrapperBA).
	self assert: (wrapperA inSequenceBeforeOrAt: wrapperH).
	self assert: (wrapperA inSequenceBeforeOrAt: wrapperI).
	self assert: (wrapperA inSequenceBeforeOrAt: method).

	self deny: (wrapperBA inSequenceBeforeOrAt: wrapperA).
	self assert: (wrapperBA inSequenceBeforeOrAt: wrapperBA).
	self assert: (wrapperBA inSequenceBeforeOrAt: wrapperH).
	self assert: (wrapperBA inSequenceBeforeOrAt: wrapperI).
	self assert: (wrapperBA inSequenceBeforeOrAt: method).

	self deny: (wrapperH inSequenceBeforeOrAt: wrapperA).
	self deny: (wrapperH inSequenceBeforeOrAt: wrapperBA).
	self assert: (wrapperH inSequenceBeforeOrAt: wrapperH).
	self assert: (wrapperH inSequenceBeforeOrAt: wrapperI).
	self assert: (wrapperH inSequenceBeforeOrAt: method).

	self deny: (wrapperI inSequenceBeforeOrAt: wrapperA).
	self deny: (wrapperI inSequenceBeforeOrAt: wrapperBA).
	self deny: (wrapperI inSequenceBeforeOrAt: wrapperH).
	self assert: (wrapperI inSequenceBeforeOrAt: wrapperI).
	self assert: (wrapperI inSequenceBeforeOrAt: method).!

testInstallUninstall

	| wrapper |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).
	wrapper install.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: self wrapperClass).
	wrapper uninstall.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).!

testMethodPosition0

	| expected actual |
	expected := 2.
	actual := (self wrapperClass createMethodFor: 0) methodPosition.
	self assert: expected = actual.!

testMethodPosition1

	| expected actual |
	expected := 2.
	actual := (self wrapperClass createMethodFor: 1) methodPosition.
	self assert: expected = actual.!

testMethodPosition2

	| expected actual |
	expected := 2.
	actual := (self wrapperClass createMethodFor: 2) methodPosition.
	self assert: expected = actual.!

testNoProtoInstanceCount

	| allInstCount protoInstCount |
	self flag: #rhi. "self wrapperClass tempNameCache: nil."
	ObjectMemory garbageCollect.
	allInstCount := self wrapperClass allInstances size.
	protoInstCount := self wrapperClass protoMethods size.
	self assert: (allInstCount - protoInstCount) = 0.!

testOnInClass

	| wrapper clientSelector wrappedClass |
	clientSelector := #mOne.
	wrappedClass := AsA.
	wrapper := self wrapperClass on: clientSelector inClass: wrappedClass.
	self assert: wrapper clientSelector == clientSelector.
	self assert: wrapper clientMethod isNil.
	self assert: wrapper definingClass isNil.
	self assert: wrapper wrappedClass == wrappedClass.
	self assert: wrapper wrappingWrapper isNil.
	self assert: wrapper aspect isNil.
	self assert: wrapper advice isNil.
	self assert: (wrapper activators isMemberOf: Set).
	self assert: (wrapper realBasicAt: wrapper methodPosition) == wrapper.
	self assert: (wrapper realBasicAt: wrapper arrayPosition) == Array.
	wrapper uninstall.!

testSourcePointersSame

	| wrapperOne wrapperTwo compiledMethod |
	wrapperOne := self wrapperClass on: #mOne inClass: AsA.
	wrapperTwo := self wrapperClass on: #mOne inClass: AsA.
	compiledMethod := AsA compiledMethodAt: #mOne.
	compiledMethod := AsA compiledMethodAt: #mOne.
	wrapperOne install.
	wrapperTwo install.
	self assert: wrapperTwo sourcePointer == wrapperOne sourcePointer.
	self assert: wrapperOne sourcePointer == compiledMethod sourcePointer.
	wrapperTwo uninstall.
	wrapperOne uninstall.!

testWasActive

	| wrapper |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self deny: wrapper wasActive.
	wrapper install.
	self deny: wrapper wasActive.
	wrapper uninstall.
	self assert: wrapper wasActive.
	self
		should: [wrapper install]
		raise: Error.!

testWrapperSequence

	self assert: self wrapperClass wrapperSequence = (OrderedCollection new
		add: AsAroundWrapper;
		add: AsBeforeAfterWrapper;
		add: AsHandlerWrapper;
		add: AsIntroductionWrapper;
		add: CompiledMethod;
		yourself).! !

!AspectS.AsMethodWrapperTest methodsFor: 'private'!

wrapperClass

	^ AsMethodWrapper! !


!AspectS.AsFactorial2 methodsFor: 'mathematical functions'!

factorial: anInteger

	anInteger = 0 ifTrue: [^ 1].
	anInteger > 0 ifTrue: [^ anInteger * (self factorial: anInteger - 1)].
	self error: 'Not valid for negative integers.'.! !


!AspectS.AsPrefixVisitorAlternative2AspectTest methodsFor: 'running'!

testPrefixVisitorAlternative

	self assert: self expectedTrace = self buildTree printPrefix.! !

!AspectS.AsPrefixVisitorAlternative2AspectTest methodsFor: 'private'!

aspectClass

	^ AsPrefixVisitorAlternative2Aspect!

expectedTrace

	^ '(/ (* (+ 1 2) (- 3 4)) 5)'! !


!AspectS.AsCounterAutoResetAspect methodsFor: 'accessing'!

count
	"^ <Integer>"

	^ count!

count: anInteger

	count := anInteger.!

threshold
	"^ <Integer>"

	^ threshold!

threshold: anInteger

	threshold := anInteger.! !

!AspectS.AsCounterAutoResetAspect methodsFor: 'advice'!

adviceAutoReset

	^ AsBeforeAfterAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverInstanceSpecific))
		pointcut: [OrderedCollection
			with: (AsJoinPointDescriptor targetClass: AsCounter targetSelector: #inc)
			with: (AsJoinPointDescriptor targetClass: AsCounter targetSelector: #dec)]
		afterBlock: [:receiver :arguments :aspect :client :return |
			self count: self count + 1.
			(self threshold = self count)
				ifTrue: [
					receiver n: 0.
					self count: 0]]! !

!AspectS.AsCounterAutoResetAspect methodsFor: 'initialization'!

initialize

	super initialize.
	self
		threshold: 0;
		count: 0.! !


!AspectS.AsLeaf class methodsFor: 'instance creation'!

value: anInteger

	^ self new value: anInteger! !

!AspectS.AsLeaf methodsFor: 'accessing'!

value
	"^ <Integer>"

	^ value!

value: anInteger

	value := anInteger.! !


!AspectS.AsBeforeAfterWrapperTest methodsFor: 'running'!

testClassInstVars

	self assert: self wrapperClass class instVarNames size = 0.
	self assert: self wrapperClass classVarNames size = 0.

	self assert: self wrapperClass protoMethods notNil.
	self assert: (self wrapperClass protoMethods isMemberOf: Dictionary).!

testNoProtoInstanceCount

	| allInstCount protoInstCount |
	self flag: #rhi. "VW?: self wrapperClass tempNameCache: nil."
	ObjectMemory garbageCollect.
	allInstCount := self wrapperClass allInstances size.
	protoInstCount := self wrapperClass protoMethods size.
	self assert: (allInstCount - protoInstCount) = 0.!

testSequenceWrappers

	| method wrapper wrapperA wrapperBA wrapperH |
	method := AsA compiledMethodAt: #mOne.
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	wrapperA := AsAroundWrapper on: #mOne inClass: AsA.
	wrapperBA := AsBeforeAfterWrapper on: #mOne inClass: AsA.
	wrapperH := AsHandlerWrapper on: #mOne inClass: AsA.
	self assert: (method isMemberOf: CompiledMethod).
	wrapper install.
	self assert: (AsA compiledMethodAt: #mOne) == wrapper.
	self assert: wrapper clientMethod == method.
	wrapperA install.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperA.
	self assert: wrapperA clientMethod == wrapper.
	self assert: wrapper clientMethod == method.
	wrapperBA install.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperA.
	self assert: wrapperA clientMethod == wrapperBA.
	self assert: wrapperBA clientMethod == wrapper.
	self assert: wrapper clientMethod == method.
	wrapperH install.
	self assert: (AsA compiledMethodAt: #mOne) == wrapperA.
	self assert: wrapperA clientMethod == wrapperBA.
	self assert: wrapperBA clientMethod == wrapper.
	self assert: wrapper clientMethod == wrapperH.
	self assert: wrapperH clientMethod == method.
	wrapperH uninstall.
	wrapperBA uninstall.
	wrapperA uninstall.
	wrapper uninstall.
	self assert: (AsA compiledMethodAt: #mOne) == method.! !

!AspectS.AsBeforeAfterWrapperTest methodsFor: 'private'!

wrapperClass

	^ AsBeforeAfterWrapper! !


!AspectS.AsCFlowFirstClassSSBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance callNTimes: 5).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: self.
	self result: (instance callNTimes: 5).
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: instance.
	self result: (instance callNTimes: 5).
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance createAndCallNTimes: 5).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: self.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: instance.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowFirstClassSSBAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
callNTimes-in: 5
callNTimes-out(5): 15'!

expectedMethodRecursionTrace3

	^ ''!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndCallNTimes-in: 5
createAndCallNTimes-out(5): 15'!

expectedObjectRecursionTrace3

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderInstanceSpecificActivator;
		add: self wrapperClass cfFirstClassActivator.! !


!AspectS.AsReceiverGeneralBAWrapperTest methodsFor: 'running'!

setUp

	self result: 0.!

testAfter

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		afterBlock: [:receiver :arguments :aspect :client :return | self result: self result + 4];
		install.
	instance mOne.
	wrapper uninstall.
	self assert: self result = 4.!

testBefore

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		beforeBlock: [:receiver :arguments :aspect :client | self result: self result + 3];
		install.
	instance mOne.
	wrapper uninstall.
	self assert: self result = 3.!

testBeforeAfter

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		beforeBlock: [:receiver :arguments :aspect :client | self result: self result + 3];
		afterBlock: [:receiver :arguments :aspect :client :return | self result: self result + 4];
		install.
	instance mOne.
	wrapper uninstall.
	self assert: self result = 7.!

testBeforeAfterWithChangedArgument

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		beforeBlock: [:receiver :arguments :aspect :client |
			arguments at: 1 put: (arguments first raisedTo: 4)];
		afterBlock: [:receiver :arguments :aspect :client :return |
			receiver x: receiver x + (arguments first raisedTo: 3)];
		install.
	self result: (instance addToX: 2).
	wrapper uninstall.
	self assert: self result = 16. "0 + 2^4"
	self assert: instance x = 4112. "0 + 2^4+ (2^4)^3"!

testBeforeAfterWithReceiver

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		beforeBlock: [:receiver :arguments :aspect :client | receiver x: receiver x + 3];
		afterBlock: [:receiver :arguments :aspect :client :return | receiver x: receiver x + 4];
		install.
	self result: (instance addToX: 2).
	wrapper uninstall.
	self assert: self result = 5.
	self assert: instance x = 9.!

testBeforeAfterWithReceiverAndArgument

	| wrapper instance |
	instance := AsA new.
	instance x: 0.
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		beforeBlock: [:receiver :arguments :aspect :client |
			receiver x: receiver x + (arguments first raisedTo: 2)];
		afterBlock: [:receiver :arguments :aspect :client :return |
			receiver x: receiver x + (arguments first raisedTo: 3)];
		install.
	self result: (instance addToX: 2).
	wrapper uninstall.
	self assert: self result = 6. "0 + 2^2 + 2"
	self assert: instance x = 14. "0 + 2^2 + 2 + 2^3"!

testFailAfterBefore

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		beforeBlock: [:receiver :arguments :aspect :client | self result: self result + 3];
		afterBlock: [:receiver :arguments :aspect :client :return | self result: self result + 4];
		install.
	self
		should: [instance failInNTimes: 0]
		raise: Error.
	wrapper uninstall.
	self assert: self result = 3.!

testInstallInstantiateUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	wrapper install.
	instance := AsA new.
	instance mOne.
	wrapper uninstall.
	instance mOne.!

testInstallUninstall

	| wrapper |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).
	wrapper install.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: self wrapperClass).
	wrapper uninstall.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).!

testInstantiateInstallUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	instance := AsA new.
	instance mOne.
	wrapper install.
	instance mOne.
	wrapper uninstall.
	instance mOne.!

testRecompile

	| wrapper instance originalSource |
	instance := AsA new.
	wrapper := self wrapperClass on: #mCompile inClass: AsA.
	self setActivatorsFor: wrapper.
	originalSource := (AsA compiledMethodAt: #mCompile) getSource string.
	self assert: instance mCompile = 'jin'.
	wrapper
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: 'bu', return];
		install.
	self assert: instance mCompile = 'bujin'.
	AsA compile: 'mCompile ^ ''do'' copy' classified: 'debugging' notifying: nil.
	self assert: instance mCompile = 'budo'.
	AsA compile: originalSource classified: 'debugging' notifying: nil.
	self assert: instance mCompile = 'bujin'.
	wrapper uninstall.
	self assert: instance mCompile = 'jin'.!

testRecompileSubstitute

	| wrapper instance originalMethod originalSourcePointer |
	instance := AsA new.
	wrapper := self wrapperClass on: #mCompile inClass: AsA.
	self setActivatorsFor: wrapper.
	originalMethod := AsA compiledMethodAt: #mCompile.
	originalSourcePointer := originalMethod sourcePointer.
	self assert: instance mCompile = 'jin'.
	wrapper
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: 'bu', return];
		install.
	self assert: instance mCompile = 'bujin'.
	AsA compile: 'mCompile ^ ''do'' copy' classified: 'debugging' notifying: nil.
	self assert: instance mCompile = 'budo'.
	wrapper uninstall.
	AsA addSelector: #mCompile withMethod: originalMethod.
	self assert: instance mCompile = 'jin'.
	self assert: originalMethod sourcePointer = originalSourcePointer.!

testRecompileSubstituteX

	| wrapper instance originalMethod originalSourcePointer |
	instance := AsA new.
	wrapper := self wrapperClass on: #mCompile inClass: AsA.
	self setActivatorsFor: wrapper.
	originalMethod := AsA compiledMethodAt: #mCompile.
	originalSourcePointer := originalMethod sourcePointer.
	self assert: instance mCompile = 'jin'.
	wrapper
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: 'bu', return];
		install.
	self assert: instance mCompile = 'bujin'.
	AsA compile: 'mCompile ^ ''do'' copy' classified: 'debugging' notifying: nil.
	self assert: instance mCompile = 'budo'.
	AsA addSelector: #mCompile withMethod: originalMethod.
	self assert: instance mCompile = 'bujin'.
	wrapper uninstall.
	self assert: instance mCompile = 'jin'.
	self assert: originalMethod sourcePointer = originalSourcePointer.!

testRecompileX

	| wrapper instance originalSource |
	instance := AsA new.
	wrapper := self wrapperClass on: #mCompile inClass: AsA.
	self setActivatorsFor: wrapper.
	originalSource := (AsA compiledMethodAt: #mCompile) getSource string.
	self assert: instance mCompile = 'jin'.
	wrapper
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: 'bu', return];
		install.
	self assert: instance mCompile = 'bujin'.
	AsA compile: 'mCompile ^ ''do'' copy' classified: 'debugging' notifying: nil.
	self assert: instance mCompile = 'budo'.
	wrapper uninstall.
	AsA compile: originalSource classified: 'debugging' notifying: nil.
	self assert: instance mCompile = 'jin'.! !

!AspectS.AsReceiverGeneralBAWrapperTest methodsFor: 'private'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass receiverClassSpecificActivator.! !


!AspectS.AsCFlowFirstSuperSGBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: ''.!

testTraceWithoutWrappersAsA

	self assert: (AsA new recAndDefClass = self expectedTraceWithoutWrappersAsA).!

testTraceWithoutWrappersAsB

	self assert: (AsB new recAndDefClass = self expectedTraceWithoutWrappersAsB).!

testTraceWithWrappersAsA

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: instance recAndDefClass.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAsA.!

testTraceWithWrappersAsA2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self aspekt addSenderClass: self class.
	self result: instance recAndDefClass.
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAsA2.!

testTraceWithWrappersAsA3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self aspekt addSenderClass: instance class.
	self result: instance recAndDefClass.
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAsA3.!

testTraceWithWrappersAsB

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: instance recAndDefClass.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAsB.!

testTraceWithWrappersAsB2

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self aspekt addSenderClass: self class.
	self result: instance recAndDefClass.
	self aspekt removeSenderClass: self class.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAsB2.!

testTraceWithWrappersAsB3

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self aspekt addSenderClass: instance class.
	self result: instance recAndDefClass.
	self aspekt removeSenderClass: instance class.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAsB3.!

testTraceWithWrappersFirstSuperAsA

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: instance recAndDefClass.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsA.!

testTraceWithWrappersFirstSuperAsA2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self aspekt addSenderClass: self class.
	self result: instance recAndDefClass.
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsA2.!

testTraceWithWrappersFirstSuperAsA3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self aspekt addSenderClass: instance class.
	self result: instance recAndDefClass.
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsA3.!

testTraceWithWrappersFirstSuperAsB

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: instance recAndDefClass.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsB.!

testTraceWithWrappersFirstSuperAsB2

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self aspekt addSenderClass: self class.
	self result: instance recAndDefClass.
	self aspekt removeSenderClass: self class.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsB2.!

testTraceWithWrappersFirstSuperAsB3

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self aspekt addSenderClass: instance class.
	self result: instance recAndDefClass.
	self aspekt removeSenderClass: instance class.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsB3.! !

!AspectS.AsCFlowFirstSuperSGBAWrapperTest methodsFor: 'private'!

expectedTraceWithoutWrappersAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithoutWrappersAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsA2

	^ self wrapperTrace, 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsA3

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsB2

	^ self wrapperTrace, 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsB3

	^ 'rec:AsB(def:AsB)--[super]-->', self wrapperTrace, 'rec:AsB(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsA2

	^ self wrapperTrace, 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsA3

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsB2

	^ self wrapperTrace, 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsB3

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

setActivatorsWithoutSuperFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass senderClassSpecificActivator.!

setActivatorsWithSuperFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderClassSpecificActivator;
		add: self wrapperClass cfFirstSuperActivator.!

wrapperTrace

	^ '==[wrapper]==>'! !


!AspectS.AsCFlowAllButFirstSuperRGBAWrapperTest methodsFor: 'running'!

setUp

	self result: ''.!

testTraceWithoutWrappersAsA

	self assert: (AsA new recAndDefClass = self expectedTraceWithoutWrappersAsA).!

testTraceWithoutWrappersAsB

	self assert: (AsB new recAndDefClass = self expectedTraceWithoutWrappersAsB).!

testTraceWithWrappersAllButFirstSuperAsA

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self result: instance recAndDefClass.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsA.!

testTraceWithWrappersAllButFirstSuperAsB

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		afterBlock: afterBlock;
		advice: advice;
		install.
	self result: instance recAndDefClass.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsB.!

testTraceWithWrappersAsA

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self result: instance recAndDefClass.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAsA.!

testTraceWithWrappersAsB

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		afterBlock: afterBlock;
		advice: advice;
		install.
	self result: instance recAndDefClass.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAsB.! !

!AspectS.AsCFlowAllButFirstSuperRGBAWrapperTest methodsFor: 'private'!

expectedTraceWithoutWrappersAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithoutWrappersAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsB

	^ 'rec:AsB(def:AsB)--[super]-->', self wrapperTrace, 'rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsA

	^ self wrapperTrace, 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsB

	^ self wrapperTrace, 'rec:AsB(def:AsB)--[super]-->', self wrapperTrace, 'rec:AsB(def:AsA)'!

setActivatorsWithoutSuperFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass receiverClassSpecificActivator.!

setActivatorsWithSuperFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverClassSpecificActivator;
		add: self wrapperClass cfAllButFirstSuperActivator.!

wrapperTrace

	^ '==[wrapper]==>'! !


!AspectS.AsCFlowFirstSuperRSBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: ''.!

testTraceWithoutWrappersAsA

	self assert: (AsA new recAndDefClass = self expectedTraceWithoutWrappersAsA).!

testTraceWithoutWrappersAsB

	self assert: (AsB new recAndDefClass = self expectedTraceWithoutWrappersAsB).!

testTraceWithWrappersAsA

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self result: instance recAndDefClass.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = self expectedTraceWithWrappersAsA.!

testTraceWithWrappersAsA2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self result: instance recAndDefClass.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = self expectedTraceWithWrappersAsA2.!

testTraceWithWrappersAsB

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	"*** self aspekt addReceiver: instance. ***"
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self result: instance recAndDefClass.
	wrapperB uninstall.
	wrapperA uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = self expectedTraceWithWrappersAsB.!

testTraceWithWrappersAsB2

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	self aspekt addReceiver: instance.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self result: instance recAndDefClass.
	wrapperB uninstall.
	wrapperA uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = self expectedTraceWithWrappersAsB2.!

testTraceWithWrappersFirstSuperAsA

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self result: instance recAndDefClass.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsA.!

testTraceWithWrappersFirstSuperAsA2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self result: instance recAndDefClass.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsA2.!

testTraceWithWrappersFirstSuperAsB

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	"*** self aspekt addReceiver: instance. ***"
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self result: instance recAndDefClass.
	wrapperB uninstall.
	wrapperA uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsB.!

testTraceWithWrappersFirstSuperAsB2

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	self aspekt addReceiver: instance.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self result: instance recAndDefClass.
	wrapperB uninstall.
	wrapperA uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsB2.! !

!AspectS.AsCFlowFirstSuperRSBAWrapperTest methodsFor: 'private'!

expectedTraceWithoutWrappersAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithoutWrappersAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsA2

	^ self wrapperTrace, 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsB2

	^ self wrapperTrace, 'rec:AsB(def:AsB)--[super]-->', self wrapperTrace, 'rec:AsB(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsA2

	^ self wrapperTrace, 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsB2

	^ self wrapperTrace, 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

setActivatorsWithoutSuperFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass receiverInstanceSpecificActivator.!

setActivatorsWithSuperFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverInstanceSpecificActivator;
		add: self wrapperClass cfFirstSuperActivator.!

wrapperTrace

	^ '==[wrapper]==>'! !


!AspectS.AsCFlowFirstSuperRGBAWrapperTest methodsFor: 'running'!

setUp

	self result: ''.!

testTraceWithoutWrappersAsA

	self assert: (AsA new recAndDefClass = self expectedTraceWithoutWrappersAsA).!

testTraceWithoutWrappersAsB

	self assert: (AsB new recAndDefClass = self expectedTraceWithoutWrappersAsB).!

testTraceWithWrappersAsA

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self result: instance recAndDefClass.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAsA.!

testTraceWithWrappersAsB

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		afterBlock: afterBlock;
		advice: advice;
		install.
	self result: instance recAndDefClass.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAsB.!

testTraceWithWrappersFirstSuperAsA

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self result: instance recAndDefClass.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsA.!

testTraceWithWrappersFirstSuperAsB

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		afterBlock: afterBlock;
		advice: advice;
		install.
	self result: instance recAndDefClass.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsB.! !

!AspectS.AsCFlowFirstSuperRGBAWrapperTest methodsFor: 'private'!

expectedTraceWithoutWrappersAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithoutWrappersAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsA

	^ self wrapperTrace, 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsB

	^ self wrapperTrace, 'rec:AsB(def:AsB)--[super]-->', self wrapperTrace, 'rec:AsB(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsA

	^ self wrapperTrace, 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsB

	^ self wrapperTrace, 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

setActivatorsWithoutSuperFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass receiverClassSpecificActivator.!

setActivatorsWithSuperFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverClassSpecificActivator;
		add: self wrapperClass cfFirstSuperActivator.!

wrapperTrace

	^ '==[wrapper]==>'! !


!AspectS.AsCFlowAllButFirstInstanceRSBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.! !

!AspectS.AsCFlowAllButFirstInstanceRSBAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
callNTimes-in: 4
callNTimes-in: 3
callNTimes-in: 2
callNTimes-in: 1
callNTimes-in: 0
callNTimes-out(0): 0
callNTimes-out(1): 1
callNTimes-out(2): 3
callNTimes-out(3): 6
callNTimes-out(4): 10'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverInstanceSpecificActivator;
		add: self wrapperClass cfAllButFirstInstanceActivator.! !


!AspectS.AsCFlowFirstInstanceRSBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.! !

!AspectS.AsCFlowFirstInstanceRSBAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
callNTimes-in: 5
callNTimes-out(5): 15'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndCallNTimes-in: 5
createAndCallNTimes-out(5): 15'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverInstanceSpecificActivator;
		add: self wrapperClass cfFirstInstanceActivator.! !


!AspectS.AsCFlowAllButFirstSuperRSBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: ''.!

testTraceWithoutWrappersAsA

	self assert: (AsA new recAndDefClass = self expectedTraceWithoutWrappersAsA).!

testTraceWithoutWrappersAsB

	self assert: (AsB new recAndDefClass = self expectedTraceWithoutWrappersAsB).!

testTraceWithWrappersAllButFirstSuperAsA

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self result: instance recAndDefClass.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsA.!

testTraceWithWrappersAllButFirstSuperAsA2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self result: instance recAndDefClass.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsA2.!

testTraceWithWrappersAllButFirstSuperAsB

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	"*** self aspekt addReceiver: instance. ***"
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self result: instance recAndDefClass.
	wrapperB uninstall.
	wrapperA uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsB.!

testTraceWithWrappersAllButFirstSuperAsB2

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	self aspekt addReceiver: instance.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self result: instance recAndDefClass.
	wrapperB uninstall.
	wrapperA uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsB2.!

testTraceWithWrappersAsA

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self result: instance recAndDefClass.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = self expectedTraceWithWrappersAsA.!

testTraceWithWrappersAsA2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self result: instance recAndDefClass.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = self expectedTraceWithWrappersAsA2.!

testTraceWithWrappersAsB

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	"*** self aspekt addReceiver: instance. ***"
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self result: instance recAndDefClass.
	wrapperB uninstall.
	wrapperA uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = self expectedTraceWithWrappersAsB.!

testTraceWithWrappersAsB2

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	self aspekt addReceiver: instance.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self result: instance recAndDefClass.
	wrapperB uninstall.
	wrapperA uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = self expectedTraceWithWrappersAsB2.! !

!AspectS.AsCFlowAllButFirstSuperRSBAWrapperTest methodsFor: 'private'!

expectedTraceWithoutWrappersAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithoutWrappersAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsA2

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsB2

	^ 'rec:AsB(def:AsB)--[super]-->', self wrapperTrace, 'rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsA2

	^ self wrapperTrace, 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsB2

	^ self wrapperTrace, 'rec:AsB(def:AsB)--[super]-->', self wrapperTrace, 'rec:AsB(def:AsA)'!

setActivatorsWithoutSuperFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass receiverInstanceSpecificActivator.!

setActivatorsWithSuperFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverInstanceSpecificActivator;
		add: self wrapperClass cfAllButFirstSuperActivator.!

wrapperTrace

	^ '==[wrapper]==>'! !


!AspectS.AsCFlowFirstClassRGBAWrapperTest methodsFor: 'running'!

setUp

	self
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.! !

!AspectS.AsCFlowFirstClassRGBAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ '
callNTimes-in: 5
callNTimes-out(5): 15'!

expectedObjectRecursionTrace

	^ '
createAndCallNTimes-in: 5
createAndCallNTimes-out(5): 15'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverClassSpecificActivator;
		add: self wrapperClass cfFirstClassActivator.! !


!AspectS.AsCFlowAllButFirstSuperSGBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: ''.!

testTraceWithoutWrappersAsA

	self assert: (AsA new recAndDefClass = self expectedTraceWithoutWrappersAsA).!

testTraceWithoutWrappersAsB

	self assert: (AsB new recAndDefClass = self expectedTraceWithoutWrappersAsB).!

testTraceWithWrappersAllButFirstSuperAsA

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: instance recAndDefClass.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsA.!

testTraceWithWrappersAllButFirstSuperAsA2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self aspekt addSenderClass: self class.
	self result: instance recAndDefClass.
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsA2.!

testTraceWithWrappersAllButFirstSuperAsA3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self aspekt addSenderClass: instance class.
	self result: instance recAndDefClass.
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsA3.!

testTraceWithWrappersAllButFirstSuperAsB

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: instance recAndDefClass.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsB.!

testTraceWithWrappersAllButFirstSuperAsB2

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self aspekt addSenderClass: self class.
	self result: instance recAndDefClass.
	self aspekt removeSenderClass: self class.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsB2.!

testTraceWithWrappersAllButFirstSuperAsB3

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self aspekt addSenderClass: instance class.
	self result: instance recAndDefClass.
	self aspekt removeSenderClass: instance class.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsB3.!

testTraceWithWrappersAsA

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: instance recAndDefClass.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAsA.!

testTraceWithWrappersAsA2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self aspekt addSenderClass: self class.
	self result: instance recAndDefClass.
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAsA2.!

testTraceWithWrappersAsA3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self aspekt addSenderClass: instance class.
	self result: instance recAndDefClass.
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAsA3.!

testTraceWithWrappersAsB

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: instance recAndDefClass.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAsB.!

testTraceWithWrappersAsB2

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self aspekt addSenderClass: self class.
	self result: instance recAndDefClass.
	self aspekt removeSenderClass: self class.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAsB2.!

testTraceWithWrappersAsB3

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self aspekt addSenderClass: instance class.
	self result: instance recAndDefClass.
	self aspekt removeSenderClass: instance class.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAsB3.! !

!AspectS.AsCFlowAllButFirstSuperSGBAWrapperTest methodsFor: 'private'!

expectedTraceWithoutWrappersAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithoutWrappersAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsA2

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsA3

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsB2

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsB3

	^ 'rec:AsB(def:AsB)--[super]-->', self wrapperTrace, 'rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsA2

	^ self wrapperTrace, 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsA3

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsB2

	^ self wrapperTrace, 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsB3

	^ 'rec:AsB(def:AsB)--[super]-->', self wrapperTrace, 'rec:AsB(def:AsA)'!

setActivatorsWithoutSuperFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass senderClassSpecificActivator.!

setActivatorsWithSuperFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderClassSpecificActivator;
		add: self wrapperClass cfAllButFirstSuperActivator.!

wrapperTrace

	^ '==[wrapper]==>'! !


!AspectS.AsCFlowAllButFirstClassSSBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance callNTimes: 5).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: self.
	self result: (instance callNTimes: 5).
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: instance.
	self result: (instance callNTimes: 5).
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance createAndCallNTimes: 5).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: self.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: instance.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowAllButFirstClassSSBAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ ''!

expectedMethodRecursionTrace3

	^ '
callNTimes-in: 4
callNTimes-in: 3
callNTimes-in: 2
callNTimes-in: 1
callNTimes-in: 0
callNTimes-out(0): 0
callNTimes-out(1): 1
callNTimes-out(2): 3
callNTimes-out(3): 6
callNTimes-out(4): 10'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

expectedObjectRecursionTrace3

	^ '
createAndCallNTimes-in: 4
createAndCallNTimes-out(4): 10'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderInstanceSpecificActivator;
		add: self wrapperClass cfAllButFirstClassActivator.! !


!AspectS.AsCFlowFirstInstanceSGBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance callNTimes: 5).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance callNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance callNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance createAndCallNTimes: 5).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowFirstInstanceSGBAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
callNTimes-in: 5
callNTimes-out(5): 15'!

expectedMethodRecursionTrace3

	^ ''!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndCallNTimes-in: 5
createAndCallNTimes-out(5): 15'!

expectedObjectRecursionTrace3

	^ '
createAndCallNTimes-in: 4
createAndCallNTimes-in: 3
createAndCallNTimes-in: 2
createAndCallNTimes-in: 1
createAndCallNTimes-in: 0
createAndCallNTimes-out(0): 0
createAndCallNTimes-out(1): 1
createAndCallNTimes-out(2): 3
createAndCallNTimes-out(3): 6
createAndCallNTimes-out(4): 10'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderClassSpecificActivator;
		add: self wrapperClass cfFirstInstanceActivator.! !


!AspectS.AsCFlowAllButFirstClassSGBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance callNTimes: 5).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance callNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance callNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance createAndCallNTimes: 5).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowAllButFirstClassSGBAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ ''!

expectedMethodRecursionTrace3

	^ '
callNTimes-in: 4
callNTimes-in: 3
callNTimes-in: 2
callNTimes-in: 1
callNTimes-in: 0
callNTimes-out(0): 0
callNTimes-out(1): 1
callNTimes-out(2): 3
callNTimes-out(3): 6
callNTimes-out(4): 10'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

expectedObjectRecursionTrace3

	^ '
createAndCallNTimes-in: 4
createAndCallNTimes-in: 3
createAndCallNTimes-in: 2
createAndCallNTimes-in: 1
createAndCallNTimes-in: 0
createAndCallNTimes-out(0): 0
createAndCallNTimes-out(1): 1
createAndCallNTimes-out(2): 3
createAndCallNTimes-out(3): 6
createAndCallNTimes-out(4): 10'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderClassSpecificActivator;
		add: self wrapperClass cfAllButFirstClassActivator.! !


!AspectS.AsCFlowFirstInstanceRGBAWrapperTest methodsFor: 'running'!

setUp

	self
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.! !

!AspectS.AsCFlowFirstInstanceRGBAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ '
callNTimes-in: 5
callNTimes-out(5): 15'!

expectedObjectRecursionTrace

	^ '
createAndCallNTimes-in: 5
createAndCallNTimes-in: 4
createAndCallNTimes-in: 3
createAndCallNTimes-in: 2
createAndCallNTimes-in: 1
createAndCallNTimes-in: 0
createAndCallNTimes-out(0): 0
createAndCallNTimes-out(1): 1
createAndCallNTimes-out(2): 3
createAndCallNTimes-out(3): 6
createAndCallNTimes-out(4): 10
createAndCallNTimes-out(5): 15'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverClassSpecificActivator;
		add: self wrapperClass cfFirstInstanceActivator.! !


!AspectS.AsReceiverSpecificBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0.!

testAfter

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return | self result: self result + 4];
		install.
	instance mOne.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 0.!

testAfter2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return | self result: self result + 4];
		install.
	instance mOne.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 4.!

testBefore

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client | self result: self result + 3];
		install.
	instance mOne.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 0.!

testBefore2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client | self result: self result + 3];
		install.
	instance mOne.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 3.!

testBeforeAfter

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client | self result: self result + 3];
		afterBlock: [:receiver :arguments :aspect :client :return | self result: self result + 4];
		install.
	instance mOne.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 0.!

testBeforeAfter2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client | self result: self result + 3];
		afterBlock: [:receiver :arguments :aspect :client :return | self result: self result + 4];
		install.
	instance mOne.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 7.!

testBeforeAfterWithChangedArgument

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	instance x: 0.
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			arguments at: 1 put: (arguments first raisedTo: 4)];
		afterBlock: [:receiver :arguments :aspect :client :return |
			receiver x: receiver x + (arguments first raisedTo: 3)];
		install.
	self result: (instance addToX: 2).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 2.
	self assert: instance x = 2.!

testBeforeAfterWithChangedArgument2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	instance x: 0.
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			arguments at: 1 put: (arguments first raisedTo: 4)];
		afterBlock: [:receiver :arguments :aspect :client :return |
			receiver x: receiver x + (arguments first raisedTo: 3)];
		install.
	self result: (instance addToX: 2).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 16. "0 + 2^4"
	self assert: instance x = 4112. "0 + 2^4+ (2^4)^3"!

testBeforeAfterWithReceiver

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	instance x: 0.
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client | receiver x: receiver x + 3];
		afterBlock: [:receiver :arguments :aspect :client :return | receiver x: receiver x + 4];
		install.
	self result: (instance addToX: 2).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 2.
	self assert: instance x = 2.!

testBeforeAfterWithReceiver2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	instance x: 0.
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client | receiver x: receiver x + 3];
		afterBlock: [:receiver :arguments :aspect :client :return | receiver x: receiver x + 4];
		install.
	self result: (instance addToX: 2).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 5.
	self assert: instance x = 9.!

testBeforeAfterWithReceiverAndArgument

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	instance x: 0.
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			receiver x: receiver x + (arguments first raisedTo: 2)];
		afterBlock: [:receiver :arguments :aspect :client :return |
			receiver x: receiver x + (arguments first raisedTo: 3)];
		install.
	self result: (instance addToX: 2).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 2.
	self assert: instance x = 2.!

testBeforeAfterWithReceiverAndArgument2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	instance x: 0.
	wrapper := self wrapperClass on: #addToX: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			receiver x: receiver x + (arguments first raisedTo: 2)];
		afterBlock: [:receiver :arguments :aspect :client :return |
			receiver x: receiver x + (arguments first raisedTo: 3)];
		install.
	self result: (instance addToX: 2).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 6. "0 + 2^2 + 2"
	self assert: instance x = 14. "0 + 2^2 + 2 + 2^3"!

testFailAfterBefore

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client | self result: self result + 3];
		afterBlock: [:receiver :arguments :aspect :client :return | self result: self result + 4];
		install.
	self
		should: [instance failInNTimes: 0]
		raise: Error.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 0.!

testFailAfterBefore2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client | self result: self result + 3];
		afterBlock: [:receiver :arguments :aspect :client :return | self result: self result + 4];
		install.
	self
		should: [instance failInNTimes: 0]
		raise: Error.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 3.!

testInstallInstantiateUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		install.
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	instance mOne.
	"*** self aspekt removeReceiver: instance. ***"
	wrapper uninstall.
	instance mOne.!

testInstallInstantiateUninstall2

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		install.
	instance := AsA new.
	self aspekt addReceiver: instance.
	instance mOne.
	self aspekt removeReceiver: instance.
	wrapper uninstall.
	instance mOne.!

testInstallUninstall

	| wrapper |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).
	wrapper
		aspect: self aspekt;
		install.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: self wrapperClass).
	wrapper uninstall.
	self assert: ((AsA compiledMethodAt: #mOne) isMemberOf: CompiledMethod).!

testInstantiateInstallUninstall

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	instance := AsA new.
	instance mOne.
	wrapper
		aspect: self aspekt;
		install.
	"*** self aspekt addReceiver: instance. ***"
	instance mOne.
	"*** self aspekt removeReceiver: instance. ***"
	wrapper uninstall.
	instance mOne.!

testInstantiateInstallUninstall2

	| wrapper instance |
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	instance := AsA new.
	instance mOne.
	wrapper
		aspect: self aspekt;
		install.
	self aspekt addReceiver: instance.
	instance mOne.
	self aspekt removeReceiver: instance.
	wrapper uninstall.
	instance mOne.!

testRecompile

	| wrapper instance originalSource |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #mCompile inClass: AsA.
	self setActivatorsFor: wrapper.
	originalSource := (AsA compiledMethodAt: #mCompile) getSource string.
	self assert: instance mCompile = 'jin'.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: 'bu', return];
		install.
	self deny: instance mCompile = 'bujin'.
	self assert: instance mCompile = 'jin'.
	AsA compile: 'mCompile ^ ''do'' copy' classified: 'debugging' notifying: nil.
	self deny: instance mCompile = 'budo'.
	self assert: instance mCompile = 'do'.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	AsA compile: originalSource classified: 'debugging' notifying: nil.
	self assert: instance mCompile = 'jin'.!

testRecompile2

	| wrapper instance originalSource |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #mCompile inClass: AsA.
	self setActivatorsFor: wrapper.
	originalSource := (AsA compiledMethodAt: #mCompile) getSource string.
	self assert: instance mCompile = 'jin'.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: 'bu', return];
		install.
	self assert: instance mCompile = 'bujin'.
	AsA compile: 'mCompile ^ ''do'' copy' classified: 'debugging' notifying: nil.
	self assert: instance mCompile = 'budo'.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	AsA compile: originalSource classified: 'debugging' notifying: nil.
	self assert: instance mCompile = 'jin'.!

testRecompileSubstitute

	| wrapper instance originalMethod originalSourcePointer |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #mCompile inClass: AsA.
	self setActivatorsFor: wrapper.
	originalMethod := AsA compiledMethodAt: #mCompile.
	originalSourcePointer := originalMethod sourcePointer.
	self assert: instance mCompile = 'jin'.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: 'bu', return];
		install.
	self deny: instance mCompile = 'bujin'.
	self assert: instance mCompile = 'jin'.
	AsA compile: 'mCompile ^ ''do'' copy' classified: 'debugging' notifying: nil.
	self deny: instance mCompile = 'budo'.
	self assert: instance mCompile = 'do'.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	AsA addSelector: #mCompile withMethod: originalMethod.
	self assert: instance mCompile = 'jin'.
	self assert: originalMethod sourcePointer = originalSourcePointer.!

testRecompileSubstitute2

	| wrapper instance originalMethod originalSourcePointer |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #mCompile inClass: AsA.
	self setActivatorsFor: wrapper.
	originalMethod := AsA compiledMethodAt: #mCompile.
	originalSourcePointer := originalMethod sourcePointer.
	self assert: instance mCompile = 'jin'.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: 'bu', return];
		install.
	self assert: instance mCompile = 'bujin'.
	AsA compile: 'mCompile ^ ''do'' copy' classified: 'debugging' notifying: nil.
	self assert: instance mCompile = 'budo'.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	AsA addSelector: #mCompile withMethod: originalMethod.
	self assert: instance mCompile = 'jin'.
	self assert: originalMethod sourcePointer = originalSourcePointer.!

testRecompileSubstituteX

	| wrapper instance originalMethod originalSourcePointer |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #mCompile inClass: AsA.
	self setActivatorsFor: wrapper.
	originalMethod := AsA compiledMethodAt: #mCompile.
	originalSourcePointer := originalMethod sourcePointer.
	self assert: instance mCompile = 'jin'.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: 'bu', return];
		install.
	self deny: instance mCompile = 'bujin'.
	self assert: instance mCompile = 'jin'.
	AsA compile: 'mCompile ^ ''do'' copy' classified: 'debugging' notifying: nil.
	self deny: instance mCompile = 'budo'.
	self assert: instance mCompile = 'do'.
	AsA addSelector: #mCompile withMethod: originalMethod.
	self deny: instance mCompile = 'bujin'.
	self assert: instance mCompile = 'jin'.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: instance mCompile = 'jin'.
	self assert: originalMethod sourcePointer = originalSourcePointer.!

testRecompileSubstituteX2

	| wrapper instance originalMethod originalSourcePointer |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #mCompile inClass: AsA.
	self setActivatorsFor: wrapper.
	originalMethod := AsA compiledMethodAt: #mCompile.
	originalSourcePointer := originalMethod sourcePointer.
	self assert: instance mCompile = 'jin'.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: 'bu', return];
		install.
	self assert: instance mCompile = 'bujin'.
	AsA compile: 'mCompile ^ ''do'' copy' classified: 'debugging' notifying: nil.
	self assert: instance mCompile = 'budo'.
	AsA addSelector: #mCompile withMethod: originalMethod.
	self assert: instance mCompile = 'bujin'.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: instance mCompile = 'jin'.
	self assert: originalMethod sourcePointer = originalSourcePointer.!

testRecompileX

	| wrapper instance originalSource |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #mCompile inClass: AsA.
	self setActivatorsFor: wrapper.
	originalSource := (AsA compiledMethodAt: #mCompile) getSource string.
	self assert: instance mCompile = 'jin'.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: 'bu', return];
		install.
	self deny: instance mCompile = 'bujin'.
	self assert: instance mCompile = 'jin'.
	AsA compile: 'mCompile ^ ''do'' copy' classified: 'debugging' notifying: nil.
	self deny: instance mCompile = 'budo'.
	self assert: instance mCompile = 'do'.
	AsA compile: originalSource classified: 'debugging' notifying: nil.
	self deny: instance mCompile = 'bujin'.
	self assert: instance mCompile = 'jin'.
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: instance mCompile = 'jin'.!

testRecompileX2

	| wrapper instance originalSource |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #mCompile inClass: AsA.
	self setActivatorsFor: wrapper.
	originalSource := (AsA compiledMethodAt: #mCompile) getSource string.
	self assert: instance mCompile = 'jin'.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: 'bu', return];
		install.
	self assert: instance mCompile = 'bujin'.
	AsA compile: 'mCompile ^ ''do'' copy' classified: 'debugging' notifying: nil.
	self assert: instance mCompile = 'budo'.
	AsA compile: originalSource classified: 'debugging' notifying: nil.
	self assert: instance mCompile = 'bujin'.
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: instance mCompile = 'jin'.! !

!AspectS.AsReceiverSpecificBAWrapperTest methodsFor: 'private'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass receiverInstanceSpecificActivator.! !


!AspectS.AsSenderSpecificBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0.!

testFailAfterBefore

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client | self result: self result + 3];
		afterBlock: [:receiver :arguments :aspect :client :return | self result: self result + 4];
		install.
	self aspekt addSender: self.
	self
		should: [instance failInNTimes: 0]
		raise: Error.
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = 3.!

testNoSender

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client | self result: self result + 3];
		afterBlock: [:receiver :arguments :aspect :client :return | self result: self result + 4];
		install.
	"*** self aspekt addSender: self. ***"
	instance mOne.
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 0.!

testSender

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client | self result: self result + 3];
		afterBlock: [:receiver :arguments :aspect :client :return | self result: self result + 4];
		install.
	self aspekt addSender: self.
	instance mOne.
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = 7.! !

!AspectS.AsSenderSpecificBAWrapperTest methodsFor: 'private'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass senderInstanceSpecificActivator.! !


!AspectS.AsCFlowAllButFirstInstanceSSBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance callNTimes: 5).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: self.
	self result: (instance callNTimes: 5).
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: instance.
	self result: (instance callNTimes: 5).
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance createAndCallNTimes: 5).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowAllButFirstInstanceSSBAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ ''!

expectedMethodRecursionTrace3

	^ '
callNTimes-in: 4
callNTimes-in: 3
callNTimes-in: 2
callNTimes-in: 1
callNTimes-in: 0
callNTimes-out(0): 0
callNTimes-out(1): 1
callNTimes-out(2): 3
callNTimes-out(3): 6
callNTimes-out(4): 10'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

expectedObjectRecursionTrace3

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderInstanceSpecificActivator;
		add: self wrapperClass cfAllButFirstInstanceActivator.! !


!AspectS.AsCFlowFirstClassRSBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.! !

!AspectS.AsCFlowFirstClassRSBAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
callNTimes-in: 5
callNTimes-out(5): 15'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndCallNTimes-in: 5
createAndCallNTimes-out(5): 15'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverInstanceSpecificActivator;
		add: self wrapperClass cfFirstClassActivator.! !


!AspectS.AsCFlowAllButFirstSuperSSBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: ''.!

testTraceWithoutWrappersAsA

	self assert: (AsA new recAndDefClass = self expectedTraceWithoutWrappersAsA).!

testTraceWithoutWrappersAsB

	self assert: (AsB new recAndDefClass = self expectedTraceWithoutWrappersAsB).!

testTraceWithWrappersAllButFirstSuperAsA

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	"*** self aspekt addSender: self. ***"
	self result: instance recAndDefClass.
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsA.!

testTraceWithWrappersAllButFirstSuperAsA2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self aspekt addSender: self.
	self result: instance recAndDefClass.
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsA2.!

testTraceWithWrappersAllButFirstSuperAsA3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self aspekt addSender: instance.
	self result: instance recAndDefClass.
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsA3.!

testTraceWithWrappersAllButFirstSuperAsB

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	"*** self aspekt addSender: self. ***"
	self result: instance recAndDefClass.
	"*** self aspekt removeSender: self. ***"
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsB.!

testTraceWithWrappersAllButFirstSuperAsB2

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self aspekt addSender: self.
	self result: instance recAndDefClass.
	self aspekt removeSender: self.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsB2.!

testTraceWithWrappersAllButFirstSuperAsB3

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self aspekt addSender: instance.
	self result: instance recAndDefClass.
	self aspekt removeSender: instance.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAllButFirstSuperAsB3.!

testTraceWithWrappersAsA

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	"*** self aspekt addSender: self. ***"
	self result: instance recAndDefClass.
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAsA.!

testTraceWithWrappersAsA2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self aspekt addSender: self.
	self result: instance recAndDefClass.
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAsA2.!

testTraceWithWrappersAsA3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self aspekt addSender: instance.
	self result: instance recAndDefClass.
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAsA3.!

testTraceWithWrappersAsB

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	"*** self aspekt addSender: self. ***"
	self result: instance recAndDefClass.
	"*** self aspekt removeSender: self. ***"
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAsB.!

testTraceWithWrappersAsB2

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self aspekt addSender: self.
	self result: instance recAndDefClass.
	self aspekt removeSender: self.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAsB2.!

testTraceWithWrappersAsB3

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self aspekt addSender: instance.
	self result: instance recAndDefClass.
	self aspekt removeSender: instance.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAsB3.! !

!AspectS.AsCFlowAllButFirstSuperSSBAWrapperTest methodsFor: 'private'!

expectedTraceWithoutWrappersAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithoutWrappersAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsA2

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsA3

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsB2

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAllButFirstSuperAsB3

	^ 'rec:AsB(def:AsB)--[super]-->', self wrapperTrace, 'rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsA2

	^ self wrapperTrace, 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsA3

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsB2

	^ self wrapperTrace, 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsB3

	^ 'rec:AsB(def:AsB)--[super]-->', self wrapperTrace, 'rec:AsB(def:AsA)'!

setActivatorsWithoutSuperFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass senderInstanceSpecificActivator.!

setActivatorsWithSuperFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderInstanceSpecificActivator;
		add: self wrapperClass cfAllButFirstSuperActivator.!

wrapperTrace

	^ '==[wrapper]==>'! !


!AspectS.AsCFlowAllButFirstClassRGBAWrapperTest methodsFor: 'running'!

setUp

	self
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.! !

!AspectS.AsCFlowAllButFirstClassRGBAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ '
callNTimes-in: 4
callNTimes-in: 3
callNTimes-in: 2
callNTimes-in: 1
callNTimes-in: 0
callNTimes-out(0): 0
callNTimes-out(1): 1
callNTimes-out(2): 3
callNTimes-out(3): 6
callNTimes-out(4): 10'!

expectedObjectRecursionTrace

	^ '
createAndCallNTimes-in: 4
createAndCallNTimes-in: 3
createAndCallNTimes-in: 2
createAndCallNTimes-in: 1
createAndCallNTimes-in: 0
createAndCallNTimes-out(0): 0
createAndCallNTimes-out(1): 1
createAndCallNTimes-out(2): 3
createAndCallNTimes-out(3): 6
createAndCallNTimes-out(4): 10'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverClassSpecificActivator;
		add: self wrapperClass cfAllButFirstClassActivator.! !


!AspectS.AsCFlowAllButFirstInstanceRGBAWrapperTest methodsFor: 'running'!

setUp

	self
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.! !

!AspectS.AsCFlowAllButFirstInstanceRGBAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ '
callNTimes-in: 4
callNTimes-in: 3
callNTimes-in: 2
callNTimes-in: 1
callNTimes-in: 0
callNTimes-out(0): 0
callNTimes-out(1): 1
callNTimes-out(2): 3
callNTimes-out(3): 6
callNTimes-out(4): 10'!

expectedObjectRecursionTrace

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverClassSpecificActivator;
		add: self wrapperClass cfAllButFirstInstanceActivator.! !


!AspectS.AsCFlowFirstInstanceSSBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance callNTimes: 5).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: self.
	self result: (instance callNTimes: 5).
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: instance.
	self result: (instance callNTimes: 5).
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSender: self. ***"
	self result: (instance createAndCallNTimes: 5).
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: self.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSender: instance.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowFirstInstanceSSBAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
callNTimes-in: 5
callNTimes-out(5): 15'!

expectedMethodRecursionTrace3

	^ ''!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndCallNTimes-in: 5
createAndCallNTimes-out(5): 15'!

expectedObjectRecursionTrace3

	^ '
createAndCallNTimes-in: 4
createAndCallNTimes-out(4): 10'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderInstanceSpecificActivator;
		add: self wrapperClass cfFirstInstanceActivator.! !


!AspectS.AsCFlowFirstClassSGBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance callNTimes: 5).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance callNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance callNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance createAndCallNTimes: 5).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowFirstClassSGBAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
callNTimes-in: 5
callNTimes-out(5): 15'!

expectedMethodRecursionTrace3

	^ ''!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndCallNTimes-in: 5
createAndCallNTimes-out(5): 15'!

expectedObjectRecursionTrace3

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderClassSpecificActivator;
		add: self wrapperClass cfFirstClassActivator.! !


!AspectS.AsCFlowAllButFirstClassRSBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance callNTimes: 5).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	"*** self aspekt addReceiver: instance. ***"
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	"*** self aspekt removeReceiver: instance. ***"
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	self aspekt addReceiver: instance.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self result: (instance createAndCallNTimes: 5).
	wrapper uninstall.
	self aspekt removeReceiver: instance.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.! !

!AspectS.AsCFlowAllButFirstClassRSBAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
callNTimes-in: 4
callNTimes-in: 3
callNTimes-in: 2
callNTimes-in: 1
callNTimes-in: 0
callNTimes-out(0): 0
callNTimes-out(1): 1
callNTimes-out(2): 3
callNTimes-out(3): 6
callNTimes-out(4): 10'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass receiverInstanceSpecificActivator;
		add: self wrapperClass cfAllButFirstClassActivator.! !


!AspectS.AsCFlowFirstSuperSSBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: ''.!

testTraceWithoutWrappersAsA

	self assert: (AsA new recAndDefClass = self expectedTraceWithoutWrappersAsA).!

testTraceWithoutWrappersAsB

	self assert: (AsB new recAndDefClass = self expectedTraceWithoutWrappersAsB).!

testTraceWithWrappersAsA

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	"*** self aspekt addSender: self. ***"
	self result: instance recAndDefClass.
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAsA.!

testTraceWithWrappersAsA2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self aspekt addSender: self.
	self result: instance recAndDefClass.
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAsA2.!

testTraceWithWrappersAsA3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self aspekt addSender: instance.
	self result: instance recAndDefClass.
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersAsA3.!

testTraceWithWrappersAsB

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	"*** self aspekt addSender: self. ***"
	self result: instance recAndDefClass.
	"*** self aspekt removeSender: self. ***"
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAsB.!

testTraceWithWrappersAsB2

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self aspekt addSender: self.
	self result: instance recAndDefClass.
	self aspekt removeSender: self.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAsB2.!

testTraceWithWrappersAsB3

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithoutSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithoutSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self aspekt addSender: instance.
	self result: instance recAndDefClass.
	self aspekt removeSender: instance.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersAsB3.!

testTraceWithWrappersFirstSuperAsA

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	"*** self aspekt addSender: self. ***"
	self result: instance recAndDefClass.
	"*** self aspekt removeSender: self. ***"
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsA.!

testTraceWithWrappersFirstSuperAsA2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self aspekt addSender: self.
	self result: instance recAndDefClass.
	self aspekt removeSender: self.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsA2.!

testTraceWithWrappersFirstSuperAsA3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapper.
	wrapper
		aspect: self aspekt;
		afterBlock: [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return];
		install.
	self aspekt addSender: instance.
	self result: instance recAndDefClass.
	self aspekt removeSender: instance.
	wrapper uninstall.
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsA3.!

testTraceWithWrappersFirstSuperAsB

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	"*** self aspekt addSender: self. ***"
	self result: instance recAndDefClass.
	"*** self aspekt removeSender: self. ***"
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsB.!

testTraceWithWrappersFirstSuperAsB2

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self aspekt addSender: self.
	self result: instance recAndDefClass.
	self aspekt removeSender: self.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsB2.!

testTraceWithWrappersFirstSuperAsB3

	| wrapperA wrapperB afterBlock advice instance |
	instance := AsB new.
	afterBlock := [:receiver :arguments :aspect :client :return |
			return become: self wrapperTrace, return].
	advice := AsAdvice new.
	wrapperA := self wrapperClass on: #recAndDefClass inClass: AsA.
	self setActivatorsWithSuperFor: wrapperA.
	wrapperA
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	wrapperB := self wrapperClass on: #recAndDefClass inClass: AsB.
	self setActivatorsWithSuperFor: wrapperB.
	wrapperB
		aspect: self aspekt;
		afterBlock: afterBlock;
		advice: advice;
		install.
	self aspekt addSender: instance.
	self result: instance recAndDefClass.
	self aspekt removeSender: instance.
	wrapperB uninstall.
	wrapperA uninstall.
	self assert: self result = self expectedTraceWithWrappersFirstSuperAsB3.! !

!AspectS.AsCFlowFirstSuperSSBAWrapperTest methodsFor: 'private'!

expectedTraceWithoutWrappersAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithoutWrappersAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsA2

	^ self wrapperTrace, 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsA3

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsB2

	^ self wrapperTrace, 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersAsB3

	^ 'rec:AsB(def:AsB)--[super]-->', self wrapperTrace, 'rec:AsB(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsA

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsA2

	^ self wrapperTrace, 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsA3

	^ 'rec:AsA(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsB

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsB2

	^ self wrapperTrace, 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

expectedTraceWithWrappersFirstSuperAsB3

	^ 'rec:AsB(def:AsB)--[super]-->rec:AsB(def:AsA)'!

setActivatorsWithoutSuperFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass senderInstanceSpecificActivator.!

setActivatorsWithSuperFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderInstanceSpecificActivator;
		add: self wrapperClass cfFirstSuperActivator.!

wrapperTrace

	^ '==[wrapper]==>'! !


!AspectS.AsCFlowAllButFirstInstanceSGBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance callNTimes: 5).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance callNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #callNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'callNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'callNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance callNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self result: (instance createAndCallNTimes: 5).
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: self class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndCallNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client |
			| msg |
			msg := String cr, 'createAndCallNTimes-in: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		afterBlock: [:receiver :arguments :aspect :client :return |
			| msg |
			msg := String cr, 'createAndCallNTimes-out(', arguments first printString, '): ',
				return printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: instance class.
	self result: (instance createAndCallNTimes: 5).
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self result = 15.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowAllButFirstInstanceSGBAWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ ''!

expectedMethodRecursionTrace3

	^ '
callNTimes-in: 4
callNTimes-in: 3
callNTimes-in: 2
callNTimes-in: 1
callNTimes-in: 0
callNTimes-out(0): 0
callNTimes-out(1): 1
callNTimes-out(2): 3
callNTimes-out(3): 6
callNTimes-out(4): 10'!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ ''!

expectedObjectRecursionTrace3

	^ ''!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderClassSpecificActivator;
		add: self wrapperClass cfAllButFirstInstanceActivator.! !


!AspectS.AsSenderGeneralBAWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		result: 0.!

testFailAfterBefore

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client | self result: self result + 3];
		afterBlock: [:receiver :arguments :aspect :client :return | self result: self result + 4];
		install.
	self aspekt addSenderClass: self class.
	self
		should: [instance failInNTimes: 0]
		raise: Error.
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 3.!

testNoSender

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client | self result: self result + 3];
		afterBlock: [:receiver :arguments :aspect :client :return | self result: self result + 4];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	instance mOne.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self result = 0.!

testSender

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client | self result: self result + 3];
		afterBlock: [:receiver :arguments :aspect :client :return | self result: self result + 4];
		install.
	self aspekt addSenderClass: self class.
	instance mOne.
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self result = 7.!

testSenderMoreGeneralClass

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client | self result: self result + 3];
		afterBlock: [:receiver :arguments :aspect :client :return | self result: self result + 4];
		install.
	self aspekt addSenderClass: self class superclass.
	instance mOne.
	self aspekt removeSenderClass: self class superclass.
	wrapper uninstall.
	self assert: self result = 7.!

testSenderWrongClass

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #mOne inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		beforeBlock: [:receiver :arguments :aspect :client | self result: self result + 3];
		afterBlock: [:receiver :arguments :aspect :client :return | self result: self result + 4];
		install.
	self aspekt addSenderClass: Compiler.
	instance mOne.
	self aspekt removeSenderClass: Compiler.
	wrapper uninstall.
	self assert: self result = 0.! !

!AspectS.AsSenderGeneralBAWrapperTest methodsFor: 'private'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators add: self wrapperClass senderClassSpecificActivator.! !



!Core.ArrayedCollection class methodsFor: 'instance creation'!

with: firstObject with: secondObject with: thirdObject with: fourthObject with: fifthObject
	"Answer a new instance of ArrayedCollection, containing the five 
	arguments as the elements."

	| newCollection |
	newCollection := self new: 5.
	newCollection at: 1 put: firstObject.
	newCollection at: 2 put: secondObject.
	newCollection at: 3 put: thirdObject.
	newCollection at: 4 put: fourthObject.
	newCollection at: 5 put: fifthObject.
	^newCollection! !


!AspectS.AsInfixVisitorAspectTest methodsFor: 'running'!

testInfixTrace

	| aspect |
	aspect := self aspectClass new.
	aspect install.
	self buildTree acceptVisitor: aspect.
	aspect uninstall.
	self assert: aspect trace contents = self expectedTrace.! !

!AspectS.AsInfixVisitorAspectTest methodsFor: 'private'!

aspectClass

	^ AsInfixVisitorAspect!

buildTree

	^ AsNode
		first: (AsNode
			first: (AsNode
				first: (AsLeaf value: 1)
				op: #+
				second: (AsLeaf value: 2))
			op: #*
			second: (AsNode
				first: (AsLeaf value: 3)
				op: #-
				second: (AsLeaf value: 4)))
		op: #/
		second: (AsLeaf value: 5)!

expectedTrace

	^ '(((1 + 2) * (3 - 4)) / 5)'! !


!AspectS.AsCFlowFirstInstanceSGHWrapperTest methodsFor: 'running'!

setUp

	self
		aspekt: AsAspect new;
		trace: (WriteStream on: String new).!

testMethodRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace.!

testMethodRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: self class.
	self
		shouldnt: [instance failInNTimes: 5]
		raise: Error.
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace2.!

testMethodRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #failInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'failInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: instance class.
	self
		should: [instance failInNTimes: 5]
		raise: Error.
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self trace contents = self expectedMethodRecursionTrace3.!

testObjectRecursionTrace

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	"*** self aspekt addSenderClass: self class. ***"
	self
		should: [instance createAndFailInNTimes: 5]
		raise: Error.
	"*** self aspekt removeSenderClass: self class. ***"
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace.!

testObjectRecursionTrace2

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: self class.
	self
		shouldnt: [instance createAndFailInNTimes: 5]
		raise: Error.
	self aspekt removeSenderClass: self class.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace2.!

testObjectRecursionTrace3

	| wrapper instance |
	instance := AsA new.
	wrapper := self wrapperClass on: #createAndFailInNTimes: inClass: AsA.
	self setActivatorsFor: wrapper.
	wrapper
		aspect: self aspekt;
		exception: Error;
		handlerBlock: [:receiver :arguments :aspect :client :ex |
			| msg |
			msg := String cr, 'createAndFailInNTimes-n: ', arguments first printString.
			self trace nextPutAll: msg.
			"Transcript show: msg"];
		install.
	self aspekt addSenderClass: instance class.
	self
		shouldnt: [instance createAndFailInNTimes: 5]
		raise: Error.
	self aspekt removeSenderClass: instance class.
	wrapper uninstall.
	self assert: self trace contents = self expectedObjectRecursionTrace3.! !

!AspectS.AsCFlowFirstInstanceSGHWrapperTest methodsFor: 'private'!

expectedMethodRecursionTrace

	^ ''!

expectedMethodRecursionTrace2

	^ '
failInNTimes-n: 5'!

expectedMethodRecursionTrace3

	^ ''!

expectedObjectRecursionTrace

	^ ''!

expectedObjectRecursionTrace2

	^ '
createAndFailInNTimes-n: 5'!

expectedObjectRecursionTrace3

	^ '
createAndFailInNTimes-n: 0'!

setActivatorsFor: anAsMethodWrapper

	anAsMethodWrapper activators
		add: self wrapperClass senderClassSpecificActivator;
		add: self wrapperClass cfFirstInstanceActivator.! !


!AspectS.AsWindowMousingProjectAspect methodsFor: 'advice'!

adviceEventDoubleClick

	^ AsBeforeAfterAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific projectSpecific))
		pointcut: [
			WindowSensor withAllSubclasses
				select: [:each | each includesSelector: #eventDoubleClick:]
				thenCollect: [:each | AsJoinPointDescriptor targetClass: each targetSelector: #eventDoubleClick:]]
		beforeBlock: [:receiver :arguments :aspect :client |
			self showHeader: '>>> EventDoubleClick >>>' receiver: receiver event: arguments first]!

adviceEventEnter

	^ AsBeforeAfterAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific projectSpecific))
		pointcut: [
			WindowSensor withAllSubclasses
				select: [:each | each includesSelector: #eventEnter:]
				thenCollect: [:each | AsJoinPointDescriptor targetClass: each targetSelector: #eventEnter:]]
		beforeBlock: [:receiver :arguments :aspect :client |
			self showHeader: '>>> EventEnter >>>' receiver: receiver event: arguments first]!

adviceEventExit

	^ AsBeforeAfterAdvice
		qualifier: (AsAdviceQualifier attributes: #(receiverClassSpecific projectSpecific))
		pointcut: [
			WindowSensor withAllSubclasses
				select: [:each | each includesSelector: #eventExit:]
				thenCollect: [:each | AsJoinPointDescriptor targetClass: each targetSelector: #eventExit:]]
		beforeBlock: [:receiver :arguments :aspect :client |
			self showHeader: '>>> EventExit >>>' receiver: receiver event: arguments first]! !

!AspectS.AsWindowMousingProjectAspect methodsFor: 'private'!

showHeader: aString receiver: anEventSensor event: anArray

	Transcript
		cr; show: aString;
		cr; tab; show: anEventSensor printString;
		cr; tab; show: anArray printString.! !


!AspectS.AsPrefixVisitorAlternative2Aspect methodsFor: 'intros'!

nodeIntro: anAsNode

	^ '(', anAsNode op asString, ' ', anAsNode first printPrefix, ' ', anAsNode second printPrefix, ')'! !

!AspectS.AsPrefixVisitorAlternative2Aspect methodsFor: 'pointcut'!

printSelector

	^ #printPrefix! !


#{AspectS.AsMethodWrapper} initialize!

#{AspectS.AsAroundWrapper} initialize!

#{AspectS.AsIntroductionWrapper} initialize!

#{AspectS.AsHandlerWrapper} initialize!

#{AspectS.AsBeforeAfterWrapper} initialize!

#{AspectS.AsAdviceQualifier} initialize!


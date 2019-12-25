(HPSVM.VMMaker new
	initializeAllExternal;
	generateExternalPlugins)

("24bpp testing"
| i w j |
w := VisualLauncher someInstance builder window asImage.
i := w asImage.
j := Image extent: i extent depth: 24 palette: i palette.
HPSVM.BitBltSimulator24bpp new
	setInterpreter: InterpreterProxy new;
	initialiseModule;
	primitiveCopyBits: ((RasterOp toImage: j) sourceImage: i; combinationRule: 3).
j)

("CLUT Testing - simulated"
| w i wb box |
w := VisualLauncher someInstance builder window.
i := w asImage.
wb := WarpBlt toImage: i.
wb clipRect: (box := (w bounds) insetBy: (40@60 corner: 40@20)).
wb source: ToolbarIconLibrary systemBrowser20x20 image.
wb combinationRule: WarpBlt over.
wb sourceQuad: (wb source boundingBox innerCorners) destRect: box.
HPSVM.BitBltSimulator new
	setInterpreter: InterpreterProxy new;
	initialiseModule;
	primitiveWarpBits: wb smoothing: 1.
i displayOn: w graphicsContext at: 0@0)
("CLUT Testing"
| w i wb box |
w := VisualLauncher someInstance builder window.
i := w asImage.
wb := WarpBlt toImage: i.
wb clipRect: (box := (w bounds) insetBy: (40@60 corner: 40@20)).
wb source: ToolbarIconLibrary systemBrowser20x20 image.
wb combinationRule: WarpBlt over.
wb sourceQuad: (wb source boundingBox innerCorners) destRect: box;
	warpBitsSmoothing: 2.
i displayOn: w graphicsContext at: 0@0)

(HPSVM.VMMaker new
	initializeAllInternal;
	generateInternalPlugins)
(ExternalLibrary unloadAll)
(VMMaker new
	initializeAllExternal;
	generateExternalPlugins)
(VMMaker new
	initializeAllInternal;
	generateInternalPlugins)
(|mc|
mc := MethodCollector new.
((mc searchClassHierarchy: CCodeGenerator) & ((mc methodsSelect: [:m| (m refersToLiteral: $;) or: [m allLiterals anySatisfy: [:l| l isString and: [l includes: $;]]]]))) browseSelect)

16rABCD 43981 storeStringRadix: 3 '3r2020022221'

26r10 26
36rZ 35

(| ws wd i w wb |
ws := VisualLauncher someInstance builder window.
wd := Examples.STAMPLoggingTool someInstance builder window.
i := ws asImage.
w := i copy.
wb := WarpBlt destinationImage: w sourceImage: i halftoneImage: nil combinationRule: RasterOp over destOrigin: 0@0 sourceOrigin: 0@0 halftonePhase: 0@0 extent: w extent clipRect: w bounds.
wb sourceQuad: (Array with: w width // 2 @0 with: 0@w height // 2 with: (w width // 2)@w height with: w width@w height // 2) destRect: w bounds.
HPSVM.BitBltSimulation doPrimitive: #warpBits receiver: wb arguments: #(1 nil).
w displayOn: wd graphicsContext at: 0@0)

(| ws wd i w |
ws := VisualLauncher someInstance builder window.
wd := Examples.STAMPLoggingTool someInstance builder window.
i := ws asImage.
w := i copy.
(WarpBlt destinationImage: w sourceImage: i halftoneImage: nil combinationRule: RasterOp over destOrigin: 0@0 sourceOrigin: 0@0 halftonePhase: 0@0 extent: w extent clipRect: w bounds)
	sourceQuad: (Array with: w width // 2 @0 with: 0@w height // 2 with: (w width // 2)@w height with: w width@w height // 2) destRect: w bounds;
	warpBitsSmoothing: 1 sourceMap: nil.
w displayOn: wd graphicsContext at: 0@0)

(| ws wd i w b |
ws := VisualLauncher someInstance builder window.
wd := Examples.STAMPLoggingTool someInstance builder window.
i := ws asImage.
w := i copy.
b := w boundingBox insetBy: (-100 asPoint corner: 100).
(WarpBlt destinationImage: w sourceImage: i halftoneImage: nil combinationRule: RasterOp over destOrigin: 0@0 sourceOrigin: 0@0 halftonePhase: 0@0 extent: w extent clipRect: w bounds)
	sourceQuad: (Array with: b width // 2 @0 with: 0@b height // 2 with: (b width // 2)@b height with: (b width@b height / 1.5) rounded) destRect: w bounds;
	warpBitsSmoothing: 1 sourceMap: nil.
w displayOn: wd graphicsContext at: 0@0)

(| ws wd i w |
ws := VisualLauncher someInstance builder window.
wd := Examples.STAMPLoggingTool someInstance builder window.
i := ws asImage.
w := i copy.
(WarpBlt destinationImage: w sourceImage: i halftoneImage: nil combinationRule: RasterOp over destOrigin: 0@0 sourceOrigin: 0@0 halftonePhase: 0@0 extent: w extent clipRect: w bounds)
	sourceQuad: ((1 to: 4) collect: [:j| | p | Cursor crossHair showWhile: [ws sensor waitButton. p := ws sensor cursorPoint]. ws sensor waitNoButton. p]) destRect: w bounds;
	warpBitsSmoothing: 2 sourceMap: nil.
w displayOn: wd graphicsContext at: 0@0)

("CLUT Testing - simulated"
| w i wb box |
w := VisualLauncher someInstance builder window.
i := w asImage.
wb := WarpBlt toImage: i.
wb clipRect: (box := (w bounds) insetBy: (40@60 corner: 40@20)).
wb source: ToolbarIconLibrary systemBrowser20x20 image.
wb combinationRule: WarpBlt over.
wb sourceQuad: (wb source boundingBox innerCorners) destRect: box.
HPSVM.BitBltSimulator new
	setInterpreter: InterpreterProxy new;
	initialiseModule;
	primitiveWarpBits: wb smoothing: 2.
i displayOn: w graphicsContext at: 0@0)
("The Squeak Mandala simulated deep"
| w i wb box p0 p pts |
w := VisualLauncher someInstance builder window.
i := w asImage.
wb := WarpBlt toImage: i.
wb clipRect: (box := (w bounds) insetBy: (40@60 corner: 40@20)).
wb source: i.
wb combinationRule: WarpBlt over.
p0 := box center.
[w sensor anyButtonPressed] whileFalse:
	[p := w sensor cursorPoint.
	pts := (box insetBy: p y - p0 y) innerCorners
			collect: [:pt | pt rotateBy: p x - p0 x / 50.0 about: p0].
	wb sourceQuad: pts destRect: box.
	HPSVM.BitBltSimulator new
		setInterpreter: InterpreterProxy new;
		initialiseModule;
		primitiveWarpBits: wb smoothing: 2.
	i displayOn: w graphicsContext at: 0@0].
w sensor waitNoButton)

("The Squeak Mandala simulated 8bit"
| w i wb box p0 p pts j |
w := VisualLauncher someInstance builder window.
j := w asImage.
i := Image extent: j extent depth: 8 palette: nil.
wb := WarpBlt toImage: i.
wb setDestImage: i.
wb clipRect: (box := (w bounds) insetBy: 40).
wb source: i.
wb combinationRule: WarpBlt over.
p0 := box center.
[w sensor anyButtonPressed] whileFalse:
	[p := w sensor cursorPoint.
	pts := (box insetBy: p y - p0 y) innerCorners
			collect: [:pt | pt rotateBy: p x - p0 x / 50.0 about: p0].
	wb sourceQuad: pts destRect: box.
	HPSVM.BitBltSimulator doPrimitive: #warpBits receiver: wb arguments: #(1).
	i displayOn: w graphicsContext at: 0@0].
w sensor waitNoButton)

("The Squeak Mandala"
| w i wb box p0 p pts |
w := VisualLauncher someInstance builder window.
i := w asImage.
wb := WarpBlt toImage: i.
wb clipRect: (box := (w bounds) insetBy: (40@60 corner: 40@20)).
wb source: i.
wb combinationRule: WarpBlt over.
p0 := box center.
[w sensor anyButtonPressed] whileFalse:
	[p := w sensor cursorPoint.
	pts := (box insetBy: p y - p0 y) innerCorners
			collect: [:pt | pt rotateBy: p x - p0 x / 50.0 about: p0].
	wb sourceQuad: pts destRect: box;
		warpBitsSmoothing: 2.
	i displayOn: w graphicsContext at: 0@0].
w sensor waitNoButton)

(#(1 2 4 8 16 24 32) do:
	[:depth| | leDepth |
	leDepth := depth < 8 ifTrue: [depth negated] ifFalse: [depth].
	RasterOp bitBltExampleDestDepth: depth sourceDepth: depth toWindow: VisualLauncher someInstance builder window where: 0@0.
	(Dialog confirm: depth printString) ifFalse: [^self]])

("Using the primitive module:"
 #(1 2 4 8 16 24 32) do:
	[:depth| | leDepth |
	leDepth := depth < 8 ifTrue: [depth negated] ifFalse: [depth].
	RasterOp primBitBltExampleDestDepth: depth sourceDepth: depth toWindow: VisualLauncher someInstance builder window where: 0@0.
	 RasterOp primBitBltExampleDestDepth: depth sourceDepth: depth toWindow: VisualLauncher someInstance builder window where: 40*4 + 8@0.
	 RasterOp primBitBltExampleDestDepth: leDepth sourceDepth: leDepth toWindow: VisualLauncher someInstance builder window where: 40*8 + 16@0.
	 RasterOp primBitBltExampleDestDepth: depth sourceDepth: leDepth toWindow: Examples.STAMPLoggingTool someInstance builder window where: 0@0.
	 RasterOp primBitBltExampleDestDepth: leDepth sourceDepth: depth toWindow: Examples.STAMPLoggingTool someInstance builder window where: 40*4 + 8@0.
	(Dialog confirm: depth printString) ifFalse: [^self]])

("Performance measurements"
| w1 w2 |
w1 := VisualLauncher someInstance builder window.
w2 := Examples.STAMPLoggingTool someInstance builder window.
TimeProfiler profile: [ #(1 2 4 8 16 32) do:
	[:depth| | leDepth |
	leDepth := depth < 8 ifTrue: [depth negated] ifFalse: [depth].
	RasterOp primBitBltExampleDestDepth: depth sourceDepth: depth toWindow: w1 where: 0@0.
	 RasterOp primBitBltExampleDestDepth: depth sourceDepth: depth toWindow: w1 where: 40*4 + 8@0.
	 RasterOp primBitBltExampleDestDepth: leDepth sourceDepth: leDepth toWindow: w1 where: 40*8 + 16@0.
	 RasterOp primBitBltExampleDestDepth: depth sourceDepth: leDepth toWindow: w2 where: 0@0.
	 RasterOp primBitBltExampleDestDepth: leDepth sourceDepth: depth toWindow: w2 where: 40*4 + 8@0]])

("Using the simulation:"
 #(1 2 4 8 16 24 32) do:
	[:depth| | leDepth |
	leDepth := depth < 8 ifTrue: [depth negated] ifFalse: [depth].
	RasterOp bitBltExampleDestDepth: depth sourceDepth: depth toWindow: VisualLauncher someInstance builder window where: 0@0.
	 RasterOp bitBltExampleDestDepth: depth sourceDepth: depth toWindow: VisualLauncher someInstance builder window where: 40*4 + 8@0.
	 RasterOp bitBltExampleDestDepth: leDepth sourceDepth: leDepth toWindow: VisualLauncher someInstance builder window where: 40*8 + 16@0.
	 RasterOp bitBltExampleDestDepth: depth sourceDepth: leDepth toWindow: Examples.STAMPLoggingTool someInstance builder window where: 0@0.
	 RasterOp bitBltExampleDestDepth: leDepth sourceDepth: depth toWindow: Examples.STAMPLoggingTool someInstance builder window where: 40*4 + 8@0.
	(Dialog confirm: depth printString) ifFalse: [^self]])

(#(2 4 8 16 24) do:
	[:depth| | leDepth |
	leDepth := depth < 8 ifTrue: [depth negated] ifFalse: [depth].
	 HPSVM.BitBltSimulator bitBltExampleDestDepth: depth sourceDepth: depth / 2 toWindow: VisualLauncher someInstance builder window where: 40*4 + 8@0.
	 HPSVM.BitBltSimulator bitBltExampleDestDepth: leDepth sourceDepth: leDepth / 2 toWindow: VisualLauncher someInstance builder window where: 40*8 + 16@0.
	 HPSVM.BitBltSimulator bitBltExampleDestDepth: depth sourceDepth: leDepth / 2 toWindow: Examples.STAMPLoggingTool someInstance builder window where: 0@0.
	 HPSVM.BitBltSimulator bitBltExampleDestDepth: leDepth sourceDepth: depth / 2 toWindow: Examples.STAMPLoggingTool someInstance builder window where: 40*4 + 8@0.
	(Dialog confirm: depth printString) ifFalse: [^self]])

("Using the simulation:"
 #(1 2 4 8 16 24 32) do:
	[:depth| | leDepth |
	leDepth := depth < 8 ifTrue: [depth negated] ifFalse: [depth].
	HPSVM.BitBltSimulator bitBltExampleDestDepth: depth sourceDepth: depth toWindow: VisualLauncher someInstance builder window where: 0@0.
	 HPSVM.BitBltSimulator bitBltExampleDestDepth: depth sourceDepth: depth toWindow: VisualLauncher someInstance builder window where: 40*4 + 8@0.
	 HPSVM.BitBltSimulator bitBltExampleDestDepth: leDepth sourceDepth: leDepth toWindow: VisualLauncher someInstance builder window where: 40*8 + 16@0.
	 HPSVM.BitBltSimulator bitBltExampleDestDepth: depth sourceDepth: leDepth toWindow: Examples.STAMPLoggingTool someInstance builder window where: 0@0.
	 HPSVM.BitBltSimulator bitBltExampleDestDepth: leDepth sourceDepth: depth toWindow: Examples.STAMPLoggingTool someInstance builder window where: 40*4 + 8@0.
	(Dialog confirm: depth printString) ifFalse: [^self]])

#(1 2 4 8 16 24 32) collect: [:d| ((((Image extent: 32@1 depth: d palette: nil) atPoint: 0@0 put: (2 raisedTo: d) - 1; bits) changeClassTo: UninterpretedBytes) unsignedLongAt: 1) printStringRadix: 2] #('10000000' '11000000' '11110000' '11111111' '1111111111111111' '111111111111111111111111' '11111111111111111111111111111111')

| mc |
mc := MethodCollector new.
((HPSVM.BitBltSimulation instVarNames select: [:ea| '*MSB*' match: ea] thenCollect: [:ea| (mc instVarUse: ea access: #read) & (mc instVarUse: (ea copyReplaceAll: 'MSB' with: 'Depth')access: #read)]) fold: [:a :b| a | b]) browseSelect

ToDo: Make HPSVM BitBlt work with RasterOp & then extend RasterOp with WarpRasterOp In Squeak pitch == stride (check this)

(| mc | mc := MethodCollector new. ((mc referencesTo: #{Symbol} binding) & (mc referencesTo: #isMemberOf:)) browseSelect)


(NamedChangeSet changeSetList select: [:cs| 'VM*' match: cs name]) do:
	[:cs|
	cs objectChanges copy keysAndValuesDo:
		[:k :v|
		(BindingReference pathString: 'SqueakVM.', k) isDefined ifTrue:
			[cs objectChanges removeKey: k; at: 'SqueakVM.', k put: v]]]


BindingReference pathString: 'SqueakVM.', 'TestCClass2.VectSize'
(MethodCollector new methodsSelect: [:m| #(1100 1101) includes: m primitiveNumber]) browseSelect

("The classic BitBlt example to test combination rules using RasterOp"
| p lei bei |
p := MonoMappedPalette withColors: (Array with: ColorValue white with: ColorValue black).
lei := Image extent: 34@34 depth: 1 bitsPerPixel: -1 palette: p.
bei := Image extent: 34@34 depth: 1 bitsPerPixel: 1 palette: p.
9 to: 24 do: [:y| 9 to: 24 do: [:x| bei atX: x y: y put: (lei atX: x y: y put: 1)]].
lei displayOn: VisualLauncher someInstance builder window graphicsContext at: 0@0.
bei displayOn: VisualLauncher someInstance builder window graphicsContext at: 160@0.
lei bits = bei bits)

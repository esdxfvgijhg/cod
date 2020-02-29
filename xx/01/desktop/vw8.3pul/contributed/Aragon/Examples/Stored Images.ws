
	"Execute the expressions below"

	StoredImage example1.

	"Let's have a look at StoredImage class>>worldSpec in canvas painter.
	Be sure to open PropertyTool."
	UIPainter new openOnClass: StoredImage andSelector: #worldSpec.

	(StoredImage on: 'world.bmp') displayOn: Window currentWindow graphicsContext.
	(StoredImage forVisual: '@world.bmp') displayOn: Window currentWindow graphicsContext.

	"These expressions display opaque images, where the background area is masked out"
	(StoredOpaqueImage on: 'molecule.bmp') displayOn: Window currentWindow graphicsContext.
	(StoredImage forVisual: '@@molecule.bmp') displayOn: Window currentWindow graphicsContext.

	"But this again doesn't mask out background area"
	(StoredImage forVisual: '@molecule.bmp') displayOn: Window currentWindow graphicsContext.
	(StoredImage forVisual: '@clrwheel.bmp') displayOn: Window currentWindow graphicsContext.

		"==> Note, that @@ stands for opaque images (figure+mask), 
		where a single @ character stands for a simple stored image without mask."

	"We should first clean the display area now:"
	Window currentWindow refresh.
	
	"Now we take some GIF images, that includs transparency information themselves, 
	so there's no need to provide and handle an seperate shape mask:"
	(StoredImage forVisual: '@clrwheel.gif') displayOn: Window currentWindow graphicsContext.
	(StoredImage forVisual: '@Find.gif') displayOn: Window currentWindow graphicsContext at: 24@24.

	"Finally it's time to flush all the images loaded"
	StoredImage flushImageCache.

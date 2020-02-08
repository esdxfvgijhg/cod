SeptIles0: SeptIles0.occ  SeptIlesData0.occ  nodes-test-include.occ
	kroc -lcourse  SeptIles0.occ 

cinema: SeptIles0
	./SeptIles0
	ffmpeg  -i image%d.ppm SeptIles0.mp4
	
clean:
	rm -rf image*
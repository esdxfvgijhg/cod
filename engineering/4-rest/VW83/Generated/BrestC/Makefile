BrestC0: BrestC0.occ  BrestCData0.occ  nodes-test-include.occ
	kroc -lcourse  BrestC0.occ 

cinema: BrestC0
	./BrestC0
	ffmpeg  -i image%d.ppm BrestC0.mp4
	
clean:
	rm -rf image*
Ouessant0: Ouessant0.occ nodes-test-include.occ
	kroc  -lcourse Ouessant0.occ

cinema: Ouessant0
	./Ouessant0
	ffmpeg -i image%d.ppm Ouessant0.mp4

clean:
	rm -f  image* cinem* Ouessant0  Ouessant0.mp4



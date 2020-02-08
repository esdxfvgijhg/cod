
Rade30x300: Rade30x300.occ nodes-test-include.occ
	kroc -lcourse Rade30x300.occ

cinema: Rade30x300
	./Rade30x300
	ffmpeg -i image%d.ppm Rade30x300.mp4

clean:
	rm -f  image* cinem* Rade30x300



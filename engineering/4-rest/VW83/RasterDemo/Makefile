
Rade30x300: Rade30x300.occ nodes-test-include.occ
	kroc -lcourse Rade30x300.occ

cinema: Rade30x300
	./Rade30x300
	avconv -i image%d.ppm cinema.mp4

clean:
	rm -f  image* cinem* Rade30x300



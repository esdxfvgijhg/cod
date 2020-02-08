#CFLAGS += -std=gnu++11
MARMOTEDIR=$(PROGRAMPATH)/a-09-markov/.marmote
INCLUDEDIR=$(MARMOTEDIR)/include
LIBDIR=$(MARMOTEDIR)/lib


CPPCOMPILER = g++
RFLAGS = -DWITH_R -I$(TOOLSPATH)/R -I/usr/share/R/include -I$(TOOLSPATH)/R/Rcpp/include -I$(TOOLSPATH)/R/RInside/include -L$(TOOLSPATH)/R -lR  -L$(TOOLSPATH)/R/RInside/lib -lRInside -Wl,-rpath,$(TOOLSPATH)/R/RInside/lib
CFLAGS += -ansi -Wall -pedantic -g
#VAL=valgrind --leak-check=full --show-leak-kinds=all
LIBS += -L/usr/lib/x86_64-linux-gnu -lboost_system
LIBRARIES=$(addprefix -l, MarmoteCore Xborne psi boost_thread boost_filesystem)
APPLIS= example1 example2 example3 example4 example5 example6 example7

all: $(APPLIS)

%: %.cpp
	$(CPPCOMPILER) -no-pie $(CFLAGS) $(RFLAGS) -I$(INCLUDEDIR) $^ -o $@ -L$(LIBDIR) $(LIBS) $(LIBRARIES)
	
clean:
	/bin/rm $(APPLIS)


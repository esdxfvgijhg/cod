# Choice of Marmote library: distrib/installed or development
ifdef DISTRIB
MARMOTEDIR=/usr/local/marmotecore
INCLUDEDIR=$(MARMOTEDIR)/include
else ifdef LOCAL
INCLUDEDIR=$(MARMOTEDIR)/include
else
MARMOTEDIR=/home/aghiles/Downloads/MAR/marmotecore
INCLUDEDIR=$(MARMOTEDIR)/include
endif
LIBDIR=$(MARMOTEDIR)/lib

# Flag for interaction with R
ifdef WITH_R
RFLAGS = -DWITH_R -I/usr/include/R -I/usr/lib64/R/library/Rcpp/include -I/usr/lib64/R/library/RInside/include -L/usr/lib64/R/lib -lR  -L/usr/lib64/R/library/RInside/lib -lRInside -Wl,-rpath,/usr/lib64/R/library/RInside/lib
else
RFLAGS = 
endif

# Choice of C compiler and options
ifeq ($(OS),Windows_NT)
CFLAGS += -std=gnu++11
endif

CPPCOMPILER = g++
#CPPCOMPILER=clang++ -v
#CPPCOMPILER=/usr/bin/g++-4.8
#CPPCOMPILER=/usr/bin/g++-4.9

CFLAGS += -ansi -Wall -pedantic -g
VAL=valgrind --leak-check=full --show-leak-kinds=all

LIBS += -L/usr/lib/x86_64-linux-gnu -lboost_system
LIBRARIES=$(addprefix -l, MarmoteCore Xborne psi boost_thread boost_filesystem)
APPLIS= example1 example2 example3 example4 example5 example6 example7

all: $(APPLIS)

%: %.cpp
	$(CPPCOMPILER) $(CFLAGS) -I$(INCLUDEDIR) $^ -o $@ -L$(LIBDIR) $(LIBRARIES)

clean:
	/bin/rm $(APPLIS)

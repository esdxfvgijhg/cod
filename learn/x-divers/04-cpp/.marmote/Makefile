GPPCOMPILER=g++

cat := $(if $(filter $(OS),Windows_NT),type,cat)
DISTDIR=marmoteapplis_1.2.0

all:
#	cd Alain; make
#	cd Issam; make
#	cd Coupling; make
#	cd SmartStation; make
#	cd Queues; make
#	cd MitraniHysteresis; make
#	cd Epidemics; make
	cd Examples/Basic; make

tarball_distrib:
	@/bin/rm -rf $(DISTDIR)
	@/bin/mkdir $(DISTDIR)
	@/bin/mkdir $(DISTDIR)/Examples
	@/bin/mkdir $(DISTDIR)/Examples/Basic
	@/bin/cp -p Examples/Basic/*.cpp $(DISTDIR)/Examples/Basic
	@/bin/cp -p Examples/Basic/Makefile $(DISTDIR)/Examples/Basic
	@/bin/cp -p Examples/Basic/*.mcl $(DISTDIR)/Examples/Basic
	@/bin/cp -p Makefile $(DISTDIR)/
ifdef WITH_R
endif
	@tar cvzf $(DISTDIR).tgz ./$(DISTDIR) > /dev/null
	@/bin/rm -rf $(DISTDIR)

clean:
	cd Alain; make clean
	cd Issam; make clean
	cd Coupling; make clean
	cd SmartStation; make clean
	cd Queues; make clean
	cd MitraniHysteresis; make clean
	cd Epidemics; make clean
	cd Examples/Basic; make clean

help:
	@echo make [all] [clean] [help]

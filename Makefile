#
#  Makefile for Sting
#

GPRBUILD=gprbuild
GPRCLEAN=gprclean

GPRFILE=sting.gpr
DAEMON=stingd
GPROPTS=

pre:
	mkdir -p obj/{test,release,debug}

precompile: pre
	gnatmake -gnatc -gnat05 -P $(GPRFILE)

test: precompile
	$(GPRBUILD) -p $(GPRFILE) -Xmode=test
	@echo
	@echo "Running tests...."
	@echo "------------------------------"
	./sting_testrunner
	@echo "------------------------------"
	@echo

sting: precompile
	$(GPRBUILD) -p $(GPRFILE)

release: precompile
	$(GPRBUILD) -p $(GPRFILE) -Xmode=release

clean:
	$(GPRCLEAN) $(GPRFILE)
	rm -rf obj $(DAEMON)


.PHONY: pre clean test precompile release

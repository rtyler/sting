#
#  Makefile for Sting
#

GPRBUILD=gprbuild
GPRCLEAN=gprclean

GPRFILE=sting.gpr
DAEMON=stingd
GPROPTS=

pre:
	mkdir -p build obj

precompile: pre
	gnatmake -gnatc -gnat05 -P $(GPRFILE)

test: precompile sting
	@echo "======="
	@echo
	@./$(DAEMON)
	@echo
	@echo "======="

sting: precompile
	$(GPRBUILD) -p $(GPRFILE) $(GPROPTS)

release: precompile
	GPROPTS='-X"mode=release"'
	$(MAKE) sting

clean:
	$(GPRCLEAN) $(GPRFILE)
	rm -rf build obj $(DAEMON)


.PHONY: pre clean test precompile release

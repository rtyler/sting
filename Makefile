#
#  Makefile for Sting
#

GPRBUILD=gprbuild
GPRCLEAN=gprclean

GPRFILE=sting.gpr

pre:
	mkdir -p build obj

precompile: pre
	gnatmake -gnatc -gnat05 -P $(GPRFILE)

test: precompile sting
	@echo "======="
	@echo
	@./main

sting: precompile
	$(GPRBUILD) -p $(GPRFILE)

clean:
	$(GPRCLEAN) $(GPRFILE)
	rm -rf build obj


.PHONY: pre clean test precompile

#
#  Makefile for Sting
#

GPRBUILD=gprbuild
GPRCLEAN=gprclean

GPRFILE=sting.gpr
DAEMON=stingd
TEST_RUNNER=test_runner
COVERAGE_LIST=coveragefiles.txt

pre:
	mkdir -p bin obj/{test,release,debug}

precompile: pre
	gnatmake -gnatc -gnat05 -P $(GPRFILE)

prepare_coverage: pre
	find ./src -iname "*.adb" -type f \
		| grep -v "main.adb" > $(COVERAGE_LIST)


test: prepare_coverage
	$(GPRBUILD) -p $(GPRFILE) -Xmode=test
	@echo
	@echo "Running tests...."
	@echo "------------------------------"
	@./bin/$(TEST_RUNNER)
	@echo "------------------------------"
	@echo
	@echo "Coverage Report: "
	@echo "------------------------------"
	@gcov -f -o obj/test @$(COVERAGE_LIST)

sting: precompile
	$(GPRBUILD) -p $(GPRFILE)

release: precompile
	$(GPRBUILD) -p $(GPRFILE) -Xmode=release

clean: pre
	$(GPRCLEAN) $(GPRFILE)
	rm -rf obj biu $(COVERAGE_LIST) *.gcov


.PHONY: pre clean test precompile release test prepare_coverage

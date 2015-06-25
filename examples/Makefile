default: all

LIB := integers/target/debug/libintegers.dylib
LD_LIBRARY_PATH := $(dir ${LIB})

${LIB}: integers/src/lib.rs
	cd integers && cargo build

integers/c-example: integers/src/main.c ${LIB}
	gcc --std=c11 -o $@ $< -L $(dir ${LIB}) -lintegers

test-output:
	mkdir -p $@

test-output/c-test: integers/c-example test-output
	$< > $@

test-output/rb-test: integers/src/main.rb test-output ${LIB}
	LD_LIBRARY_PATH=${LD_LIBRARY_PATH} ruby $< > $@

test-output/py-test: integers/src/main.py test-output ${LIB}
	LD_LIBRARY_PATH=${LD_LIBRARY_PATH} python $< > $@

.PHONY: integers-c-test
integers-c-test: test-output/c-test
	diff -q integers/expected-output $<

.PHONY: integers-rb-test
integers-rb-test: test-output/rb-test
	diff -q integers/expected-output $<

.PHONY: integers-py-test
integers-py-test: test-output/py-test
	diff -q integers/expected-output $<

all: integers-c-test integers-rb-test integers-py-test

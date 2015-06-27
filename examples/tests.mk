LIB_${d}      := ${d}/target/debug/lib${LIB_NAME_${d}}.dylib
LIB_DIR_${d}  := ${dir ${LIB_${d}}}
TEST_DIR_${d} := ${TEST_DIR}/${d}

${LIB_${d}}: DIR := ${d}
${LIB_${d}}: ${d}/src/lib.rs
	cd ${DIR} && cargo build

${d}/c-example: LIB_DIR := ${LIB_DIR_${d}}
${d}/c-example: LIB_NAME := ${LIB_NAME_${d}}
${d}/c-example: ${d}/src/main.c ${LIB_${d}}
	clang --std=c11 -o $@ $< -L ${LIB_DIR} -l${LIB_NAME}

${TEST_DIR_${d}}:
	mkdir -p $@

${TEST_DIR_${d}}/c-test: LIB_DIR := ${LIB_DIR_${d}}
${TEST_DIR_${d}}/c-test: ${d}/c-example ${TEST_DIR_${d}}
	LD_LIBRARY_PATH=${LIB_DIR} $< > $@

${TEST_DIR_${d}}/rb-test: LIB_DIR := ${LIB_DIR_${d}}
${TEST_DIR_${d}}/rb-test: ${d}/src/main.rb ${TEST_DIR_${d}} ${LIB_${d}}
	LD_LIBRARY_PATH=${LIB_DIR} bundle exec ruby $< > $@

${TEST_DIR_${d}}/py-test: LIB_DIR := ${LIB_DIR_${d}}
${TEST_DIR_${d}}/py-test: ${d}/src/main.py ${TEST_DIR_${d}} ${LIB_${d}}
	LD_LIBRARY_PATH=${LIB_DIR} python $< > $@

.PHONY: c-test_${d}
c-test_${d}: EXPECTED := ${d}/expected-output
c-test_${d}: ${TEST_DIR_${d}}/c-test
	diff -q ${EXPECTED} $<

.PHONY: rb-test_${d}
rb-test_${d}: EXPECTED := ${d}/expected-output
rb-test_${d}: ${TEST_DIR_${d}}/rb-test
	diff -q ${EXPECTED} $<

.PHONY: py-test_${d}
py-test_${d}: EXPECTED := ${d}/expected-output
py-test_${d}: ${TEST_DIR_${d}}/py-test
	diff -q ${EXPECTED} $<

all: c-test_${d} rb-test_${d} py-test_${d}

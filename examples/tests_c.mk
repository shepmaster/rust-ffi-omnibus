include ${COMMON_TEST_RULES}

${d}/c-example: LIB_DIR := ${LIB_DIR_${d}}
${d}/c-example: LIB_NAME := ${LIB_NAME_${d}}
${d}/c-example: ${d}/src/main.c ${LIB_${d}}
	clang --std=c11 -o $@ $< -L ${LIB_DIR} -l${LIB_NAME}

${TEST_DIR_${d}}/c-test: LIB_DIR := ${LIB_DIR_${d}}
${TEST_DIR_${d}}/c-test: ${d}/c-example ${TEST_DIR_${d}}
	LD_LIBRARY_PATH=${LIB_DIR} $< > $@

.PHONY: c-test_${d}
c-test_${d}: EXPECTED := ${d}/expected-output
c-test_${d}: ${TEST_DIR_${d}}/c-test
	diff -q ${EXPECTED} $<

all: c-test_${d}

include ${COMMON_TEST_RULES}

${TEST_DIR_${d}}/nodejs-test: LIB_DIR := ${LIB_DIR_${d}}
${TEST_DIR_${d}}/nodejs-test: ${d}/src/main.js ${TEST_DIR_${d}} ${LIB_${d}}
	LD_LIBRARY_PATH=${LIB_DIR} node $< > $@

.PHONY: nodejs-test_${d}
nodejs-test_${d}: EXPECTED := ${d}/expected-output
nodejs-test_${d}: ${TEST_DIR_${d}}/nodejs-test
	diff -q ${EXPECTED} $<

nodejs: nodejs-test_${d}


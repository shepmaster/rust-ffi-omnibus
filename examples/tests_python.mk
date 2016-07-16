include ${COMMON_TEST_RULES}

${TEST_DIR_${d}}/python-test: LIB_DIR := ${LIB_DIR_${d}}
${TEST_DIR_${d}}/python-test: ${d}/src/main.py ${TEST_DIR_${d}} ${LIB_${d}}
	LD_LIBRARY_PATH=${LIB_DIR} python3 $< > $@

.PHONY: python-test_${d}
python-test_${d}: EXPECTED := ${d}/expected-output
python-test_${d}: ${TEST_DIR_${d}}/python-test
	diff -q ${EXPECTED} $<

python: python-test_${d}

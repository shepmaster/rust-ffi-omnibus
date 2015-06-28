include ${COMMON_TEST_RULES}

${TEST_DIR_${d}}/ruby-test: LIB_DIR := ${LIB_DIR_${d}}
${TEST_DIR_${d}}/ruby-test: ${d}/src/main.rb ${TEST_DIR_${d}} ${LIB_${d}}
	LD_LIBRARY_PATH=${LIB_DIR} bundle exec ruby $< > $@

.PHONY: ruby-test_${d}
ruby-test_${d}: EXPECTED := ${d}/expected-output
ruby-test_${d}: ${TEST_DIR_${d}}/ruby-test
	diff -q ${EXPECTED} $<

all: ruby-test_${d}

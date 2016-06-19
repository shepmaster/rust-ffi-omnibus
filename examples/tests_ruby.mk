include ${COMMON_TEST_RULES}

# System-wide packages need to be installed. We run the appropriate
# package manager and leave a small cookie file to indicate
# success. The execution depends on the cookie file.

ifndef RUBY_DEPENDENCIES

RUBY_DEPENDENCIES := .ruby-dependencies

${RUBY_DEPENDENCIES}: Gemfile Gemfile.lock
	bundle install
	touch $@

endif

${TEST_DIR_${d}}/ruby-test: LIB_DIR := ${LIB_DIR_${d}}
${TEST_DIR_${d}}/ruby-test: ${d}/src/main.rb ${TEST_DIR_${d}} ${LIB_${d}} ${RUBY_DEPENDENCIES}
	bundle exec bash -c "LD_LIBRARY_PATH=${LIB_DIR} ruby $<" > $@

.PHONY: ruby-test_${d}
ruby-test_${d}: EXPECTED := ${d}/expected-output
ruby-test_${d}: ${TEST_DIR_${d}}/ruby-test
	diff -q ${EXPECTED} $<

ruby: ruby-test_${d}

include ${COMMON_TEST_RULES}

# System-wide packages need to be installed. We run the appropriate
# package manager and leave a small cookie file to indicate
# success. The execution depends on the cookie file.

ifndef PERL_DEPENDENCIES

PERL_DEPENDENCIES := .perl-dependencies

${PERL_DEPENDENCIES}: cpanfile
	cpanm --installdeps -L local .
	touch $@

endif

${TEST_DIR_${d}}/perl-test: LIB_DIR := ${LIB_DIR_${d}}
${TEST_DIR_${d}}/perl-test: ${d}/src/main.pl ${TEST_DIR_${d}} ${LIB_${d}} ${PERL_DEPENDENCIES}
	LD_LIBRARY_PATH=${LIB_DIR} perl -Ilocal/lib $< > $@

.PHONY: perl-test_${d}
perl-test_${d}: EXPECTED := ${d}/expected-output
perl-test_${d}: ${TEST_DIR_${d}}/perl-test
	diff -q ${EXPECTED} $<

perl: perl-test_${d}

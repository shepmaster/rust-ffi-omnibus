include ${COMMON_TEST_RULES}

# The value of `d` changes between the time the target is evaluated
# and the time it is run. To work around this, *target-specific*
# variables are used.

# Compile the example. All dependencies must be explicitly listed.
${d}/c-example: LIB_DIR := ${LIB_DIR_${d}}
${d}/c-example: LIB_NAME := ${LIB_NAME_${d}}
${d}/c-example: ${d}/src/main.c ${LIB_${d}}
	clang -std=c11 -pedantic -Wall -Werror -o $@ $< -L ${LIB_DIR} -l${LIB_NAME}

# Save the example output into a file by running it
${TEST_DIR_${d}}/c-test: LIB_DIR := ${LIB_DIR_${d}}
${TEST_DIR_${d}}/c-test: ${d}/c-example ${TEST_DIR_${d}}
	LD_LIBRARY_PATH=${LIB_DIR} $< > $@

# Compare the example output with the expected output. This does not
# produce any files, so it is marked `PHONY`.
.PHONY: c-test_${d}
c-test_${d}: EXPECTED := ${d}/expected-output
c-test_${d}: ${TEST_DIR_${d}}/c-test
	diff -q ${EXPECTED} $<

# Add this example's test target to the global list for this language.
c: c-test_${d}

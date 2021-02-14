include ${COMMON_TEST_RULES}

# The value of `d` changes between the time the target is evaluated
# and the time it is run. To work around this, *target-specific*
# variables are used.

# Compile the example. All dependencies must be explicitly listed.
${d}/zig-example: LIB_DIR := ${LIB_DIR_${d}}
${d}/zig-example: LIB_NAME := ${LIB_NAME_${d}}
${d}/zig-example: ${d}/src/main.zig ${LIB_${d}}
	zig build-exe -femit-bin=$@ $< -L ${LIB_DIR} -l${LIB_NAME} -lc

# Save the example output into a file by running it
${TEST_DIR_${d}}/zig-test: LIB_DIR := ${LIB_DIR_${d}}
${TEST_DIR_${d}}/zig-test: ${d}/zig-example ${TEST_DIR_${d}}
	LD_LIBRARY_PATH=${LIB_DIR} $< > $@

# Compare the example output with the expected output. This does not
# produce any files, so it is marked `PHONY`.
.PHONY: zig-test_${d}
zig-test_${d}: EXPECTED := ${d}/expected-output
zig-test_${d}: ${TEST_DIR_${d}}/zig-test
	diff -q ${EXPECTED} $<

# Add this example's test target to the global list for this language.
zig: zig-test_${d}

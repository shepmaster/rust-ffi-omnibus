# This file should be included from a language-specific test file. It
# defines rules to build the Rust example, as well as variables for
# shared components. It is safe to be included multiple times in the
# same directory, but must be included at least once.

ifndef LIB_${d}

# The path to the shared library
LIB_${d}      := ${d}/target/debug/$(call shared_lib,${LIB_NAME_${d}})
# The directory containing the shared library
LIB_DIR_${d}  := ${dir ${LIB_${d}}}
# The directory to keep example output
TEST_DIR_${d} := ${TEST_DIR}/${d}

${LIB_${d}}: DIR := ${d}
${LIB_${d}}: ${d}/src/lib.rs
	cd ${DIR} && cargo build

${TEST_DIR_${d}}:
	mkdir -p $@

endif

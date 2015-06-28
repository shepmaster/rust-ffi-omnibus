ifndef LIB_${d}

LIB_${d}      := ${d}/target/debug/$(call shared_lib,${LIB_NAME_${d}})
LIB_DIR_${d}  := ${dir ${LIB_${d}}}
TEST_DIR_${d} := ${TEST_DIR}/${d}

${LIB_${d}}: DIR := ${d}
${LIB_${d}}: ${d}/src/lib.rs
	cd ${DIR} && cargo build

${TEST_DIR_${d}}:
	mkdir -p $@

endif

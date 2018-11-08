include ${COMMON_TEST_RULES}

${TEST_DIR_${d}}/julia-test: LIB_DIR := ${LIB_DIR_${d}}
${TEST_DIR_${d}}/julia-test: ${d}/src/main.jl ${TEST_DIR_${d}} ${LIB_${d}}
	LD_LIBRARY_PATH=${LIB_DIR} julia $< > $@

.PHONY: julia-test_${d}
julia-test_${d}: EXPECTED := ${d}/expected-output
julia-test_${d}: ${TEST_DIR_${d}}/julia-test
	diff -q ${EXPECTED} $<

julia: julia-test_${d}

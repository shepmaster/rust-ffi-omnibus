${d}/csharp-example: LIB := ${LIB_${d}}
${d}/csharp-example: ${d}/src/main.cs ${LIB_${d}}
	mcs $< -out:$@

${TEST_DIR_${d}}/csharp-test: LIB_DIR := ${LIB_DIR_${d}}
${TEST_DIR_${d}}/csharp-test: ${d}/csharp-example ${TEST_DIR_${d}}
	LD_LIBRARY_PATH=${LIB_DIR} mono $< > $@

.PHONY: csharp-test_${d}
csharp-test_${d}: EXPECTED := ${d}/expected-output
csharp-test_${d}: ${TEST_DIR_${d}}/csharp-test
	diff -q ${EXPECTED} $<

csharp: csharp-test_${d}

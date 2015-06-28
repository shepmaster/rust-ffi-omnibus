${d}/haskell-example: LIB := ${LIB_${d}}
${d}/haskell-example: ${d}/src/main.hs ${LIB_${d}}
	ghc $< ${LIB} -o $@

${TEST_DIR_${d}}/haskell-test: LIB_DIR := ${LIB_DIR_${d}}
${TEST_DIR_${d}}/haskell-test: ${d}/haskell-example ${TEST_DIR_${d}}
	LD_LIBRARY_PATH=${LIB_DIR} $< > $@

.PHONY: haskell-test_${d}
haskell-test_${d}: EXPECTED := ${d}/expected-output
haskell-test_${d}: ${TEST_DIR_${d}}/haskell-test
	diff -q ${EXPECTED} $<

haskell: haskell-test_${d}

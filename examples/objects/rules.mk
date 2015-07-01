sp             := ${sp}.x
dirstack_${sp} := ${d}
d              := ${dir}

LIB_NAME_${d} := objects
include ${TEST_C}
include ${TEST_RUBY}
include ${TEST_PYTHON}
include ${TEST_HASKELL}
include ${TEST_NODEJS}

d  := ${dirstack_${sp}}
sp := ${basename ${sp}}

sp             := ${sp}.x
dirstack_${sp} := ${d}
d              := ${dir}

LIB_NAME_${d} := tuples
include ${TEST_C}
include ${TEST_RUBY}
include ${TEST_PYTHON}
include ${TEST_NODEJS}
include ${TEST_CSHARP}

d  := ${dirstack_${sp}}
sp := ${basename ${sp}}

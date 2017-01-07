sp             := ${sp}.x
dirstack_${sp} := ${d}
d              := ${dir}

LIB_NAME_${d} := vector_return
include ${TEST_C}
include ${TEST_PYTHON}
include ${TEST_NODEJS}

d  := ${dirstack_${sp}}
sp := ${basename ${sp}}

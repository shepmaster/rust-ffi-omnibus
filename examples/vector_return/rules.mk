sp             := ${sp}.x
dirstack_${sp} := ${d}
d              := ${dir}

LIB_NAME_${d} := vector_return
include ${TEST_ALL_LANGUAGES}

d  := ${dirstack_${sp}}
sp := ${basename ${sp}}

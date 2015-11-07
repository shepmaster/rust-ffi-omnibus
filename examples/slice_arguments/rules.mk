sp             := ${sp}.x
dirstack_${sp} := ${d}
d              := ${dir}

LIB_NAME_${d} := slice_arguments
include ${TEST_ALL_LANGUAGES}
include ${TEST_CSHARP}

d  := ${dirstack_${sp}}
sp := ${basename ${sp}}

sp             := ${sp}.x
dirstack_${sp} := ${d}
d              := ${dir}

LIB_NAME_${d} := string_arguments
include ${TEST_ALL_LANGUAGES}

d  := ${dirstack_${sp}}
sp := ${basename ${sp}}

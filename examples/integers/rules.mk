sp             := ${sp}.x
dirstack_${sp} := ${d}
d              := ${dir}

LIB_NAME_${d} := integers
include ${COMMON_TEST_RULES}

d  := ${dirstack_${sp}}
sp := ${basename ${sp}}

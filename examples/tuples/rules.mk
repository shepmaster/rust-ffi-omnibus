sp             := ${sp}.x
dirstack_${sp} := ${d}
d              := ${dir}

LIB_NAME_${d} := tuples
include ${TEST_C}
include ${TEST_RUBY}
include ${TEST_PYTHON}
include ${TEST_NODEJS}

ifneq (${RUNNING_IN_TRAVIS_CI},true)
include ${TEST_CSHARP}
endif

d  := ${dirstack_${sp}}
sp := ${basename ${sp}}

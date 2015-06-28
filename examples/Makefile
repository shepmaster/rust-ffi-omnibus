default: all
.PHONY: default

# Different platforms have different rules for shared library names
OS := $(shell uname)
ifeq (${OS},Darwin)
shared_lib = lib${1}.dylib
else ifeq (${OS},Linux)
shared_lib = lib${1}.so
else
$(error Unknown platform, please define how shared libraries are named)
endif

TEST_DIR := test-output

COMMON_TEST_RULES := tests.mk
TEST_C := tests_c.mk
TEST_RUBY := tests_ruby.mk
TEST_PYTHON := tests_python.mk
TEST_HASKELL := tests_haskell.mk
TEST_ALL_LANGUAGES := tests_all.mk

dir := integers
include ${dir}/rules.mk
dir := string_arguments
include ${dir}/rules.mk
dir := slice_arguments
include ${dir}/rules.mk

all: c ruby python haskell
.PHONY: all

# Test only a single language
#
# These rules are here for documentation. The implementations will be
# filled out by the respective tests_X.mk file

c:
ruby:
python:
haskell:

.PHONY: c ruby python haskell

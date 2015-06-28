default: all
.PHONY: default

TEST_DIR := test-output

COMMON_TEST_RULES := tests.mk
TEST_C := tests_c.mk
TEST_RUBY := tests_ruby.mk
TEST_PYTHON := tests_python.mk
TEST_ALL_LANGUAGES := tests_all.mk

dir := integers
include ${dir}/rules.mk
dir := string_arguments
include ${dir}/rules.mk
dir := slice_arguments
include ${dir}/rules.mk

all: c ruby python
.PHONY: all

# Test only a single language
#
# These rules are here for documentation. The implementations will be
# filled out by the respective tests_X.mk file

c:
ruby:
python:

.PHONY: c ruby python

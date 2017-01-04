default: all
.PHONY: default

# Implementor notes
#
# This is a non-recursive Makefile. The major difference between a
# non-recursive and recursive is that a single non-recursive Make
# process contains the entire dependency tree.
#
# Practically, that means that every directory-specific target and
# variable needs to be namespaced. The variable `d` can be included in
# the variable name to provide this namespacing.
#
# Additionally, a set of includable Makefiles are provided, one for
# each language. These can be included in each example's
# `rules.mk`. These are the workhorse of the Make process, as they
# define the targets to build and test each language's example.
#
# Review `tests_c.mk` for a documented example.
#
# For further reference, review [*Recursive Make Considered
# Harmful*][rec-make] and an [implementation guide][impl].
#
# [rec-make]: http://aegis.sourceforge.net/auug97.pdf
# [impl]: http://evbergen.home.xs4all.nl/nonrecursive-make.html

# Delete partially built files from erroring targets
.DELETE_ON_ERROR:

# Different platforms have different rules for shared library names
OS := $(shell uname)
ifeq (${OS},Darwin)
shared_lib = lib${1}.dylib
else ifeq (${OS},Linux)
shared_lib = lib${1}.so
else ifeq (${OS},OpenBSD)
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
TEST_NODEJS := tests_nodejs.mk
TEST_CSHARP := tests_csharp.mk
TEST_ALL_LANGUAGES := tests_all.mk

dir := integers
include ${dir}/rules.mk
dir := string_arguments
include ${dir}/rules.mk
dir := slice_arguments
include ${dir}/rules.mk
dir := tuples
include ${dir}/rules.mk
dir := objects
include ${dir}/rules.mk
dir := string_return
include ${dir}/rules.mk
dir := vector_return
include ${dir}/rules.mk

all: c ruby python haskell nodejs csharp
.PHONY: all

# Test only a single language
#
# These rules are here for documentation. The implementations will be
# filled out by the respective tests_X.mk file

c:
ruby:
python:
haskell:
nodejs:
csharp:

.PHONY: c ruby python haskell nodejs csharp

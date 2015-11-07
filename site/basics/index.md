---
layout: default
examples: ../examples/integers/
title: Basics
---

# Basics

It's assumed that you are familiar with the basics of Rust and the
language you will be calling from. You should have read the
[official FFI documentation][official], but some basics will be
covered here.

## Rust

All Rust examples will use [Cargo] and the [libc crate][libc]. Each
example has the following boilerplate in `Cargo.toml`:

{% example Cargo.toml %}

`crate-type = ["dylib"]` creates a dynamically linked library.
Check out the Cargo documentation for
[dynamic or static libraries][dyn-stat] for more information.

## C

All C examples will be compiled using the C11 standard.

## Ruby

All Ruby examples will use Ruby 2.2 and the [FFI gem][gem].

## Python

All Python examples will use Python 2.7 and the [ctypes library][ctypes].

## Haskell

All Haskell examples will use GHC 7.10 with the `ForeignFunctionInterface`
language extension and only the `base` library which comes with GHC.

## Node.js

All node.js examples will use node 0.12 and the [ffi package][node-ffi].

## C\#

All C# examples will compile with Mono 2.10 (Travis CI) and 4.2. It is
assumed that this code will work with the Microsoft CLR frameworks,
but this is untested.

## Running Examples

When running examples, you need to ensure the Rust dynamic library
can be located by the system.

With most shells on Mac OS X and Linux, this can be done by prefixing
commands with `LD_LIBRARY_PATH=target/debug`.  For example, to run a
Python example, you might use
`LD_LIBRARY_PATH=target/debug python src/main.py` from the example
directory.

On Windows, the simplest course of action is to copy the compiled
dynamic library into the current working directory before running the
examples.  You only need the `.dll` file.  Also note that when
running Python examples, you may wish to use `py` instead of
`python`, especially if you have multiple versions of Python
installed.

[official]: https://doc.rust-lang.org/book/ffi.html
[Cargo]: https://crates.io/
[libc]: http://doc.rust-lang.org/libc/libc/index.html
[dyn-stat]: http://doc.crates.io/manifest.html#building-dynamic-or-static-libraries
[gem]: https://github.com/ffi/ffi
[ctypes]: https://docs.python.org/2/library/ctypes.html
[node-ffi]: https://www.npmjs.com/package/node-ffi

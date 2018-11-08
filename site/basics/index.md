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

`crate-type = ["cdylib"]` creates a dynamically linked library.
Check out the Cargo documentation for
[dynamic or static libraries][dyn-stat] for more information.

`cdylib` was [introduced in RFC 1510][rfc1510] and improves on the
existing `dylib` with reduced file size and fewer exported symbols. It
was [implemented in Rust 1.10][rust-1.10]; if you are using earlier
versions, it is encouraged that you upgrade, but you can also use
`dylib` with minimal ill effects.

Some examples are so minimal that they don't use any features from the
Rust standard library. This triggers a [known issue][rust-18807] and
linking will fail. The only workaround is to include an exported but
unused function that does use something from the standard
library. These functions are called
`fix_linking_when_not_using_stdlib` and can be safely removed for any
larger project.

## C

All C examples will be compiled using the C11 standard.

## Ruby

All Ruby examples will use Ruby 2.5 and the [FFI gem][gem].

## Python

All Python examples will use Python 3.7 and the [ctypes library][ctypes].

## Haskell

All Haskell examples will use GHC 8.4 with the `ForeignFunctionInterface`
language extension and only the `base` library which comes with GHC.

## Node.js

All Node.js examples will use Node.js 8.12 and the [ffi package][node-ffi].

## C\#

All C# examples will compile with Mono 5.14. It is assumed that this
code will work with the Microsoft CLR frameworks, but this is
untested.

## Julia

All Julia examples will use Julia 1.0, and rely on the language's
built-in [C function calling capabilities][julia-c]. They might also
work on v0.7, but this version is untested.

## Running Examples

When running examples, you need to ensure the Rust dynamic library
can be located by the system.

With most shells on macOS and Linux, this can be done by prefixing
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
[rfc1510]: https://github.com/rust-lang/rfcs/blob/master/text/1510-cdylib.md
[rust-1.10]: https://blog.rust-lang.org/2016/07/07/Rust-1.10.html
[rust-18807]: https://github.com/rust-lang/rust/issues/18807
[gem]: https://github.com/ffi/ffi
[ctypes]: https://docs.python.org/3/library/ctypes.html
[node-ffi]: https://www.npmjs.com/package/node-ffi
[julia-c]: https://docs.julialang.org/en/v1/manual/calling-c-and-fortran-code
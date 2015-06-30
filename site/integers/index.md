---
layout: default
examples: ../examples/integers/
---

# Passing and returning integers

Integers are the "hello world!" of FFI, as they are generally much
easier to pass across the boundary. Let's create a library that adds
two signed 32-bit numbers.

{% example src/lib.rs %}

Compile this with `cargo build`, which will produce a library in
`target/debug/`. The exact filename depends on your platform:

| Platform | Pattern    |
|----------|------------|
| Windows  | *.dll      |
| OS X     | lib*.dylib |
| Linux    | lib*.so    |

## C

{% example src/main.c %}

We start by declaring an `extern` function with the proper argument
and return types. This can then be compiled and linked against the
Rust library using `gcc --std=c11 -o c-example src/main.c -L
target/debug/ -lintegers`.

As noted in the basics section, this can be run on Mac OS X and Linux
with `LD_LIBRARY_PATH=target/debug/ ./c-example`, and on Windows by
copying `target\debug\integers.dll` to the current directory and
running `.\c-example`.

## Ruby

{% example src/main.rb %}

This can be run with `LD_LIBRARY_PATH=target/debug/ ruby
./src/main.rb`

## Python

{% example src/main.py %}

As noted in the basics section, this can be run on Mac OS X and Linux
with `LD_LIBRARY_PATH=target/debug/ python src/main.py`, and on
Windows by copying `target\debug\integers.dll` to the current
directory and running `py src\main.py`.

## Haskell

{% example src/main.hs %}

We have to enable the `ForeignFunctionInterface` language extension and
import the relevant low-level types before we can include a
`foreign import` declaration. This includes the calling convention
(`ccall`), the symbol name (`"addition"`), the corresponding Haskell
name (`addition`), and the type of the function. This function is
effectively pure, so we don't include `IO` in the type, but an
observably impure function would want to return an `IO` value to
indicate that it has side-effects.

This can be compiled using
`ghc src/main.hs target/debug/libintegers.so -o haskell-example`.

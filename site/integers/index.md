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

| Platform | Extension |
|----------|-----------|
| Windows  | .dll      |
| OS X     | .dylib    |
| Linux    | .so       |

## C

{% example src/main.c %}

We start by declaring an `extern` function with the proper argument
and return types. This can then be compiled and linked against the
Rust library using `gcc --std=c11 -o c-example src/main.c -L
target/debug/ -lintegers`.

## Ruby

{% example src/main.rb %}

This can be run with `LD_LIBRARY_PATH=target/debug/ ruby
./src/main.rb`

## Python

{% example src/main.py %}

This can be run with `LD_LIBRARY_PATH=target/debug python src/main.py`.

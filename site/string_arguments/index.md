---
layout: default
examples: ../examples/string_arguments/
title: String Arguments
---

# Rust functions with string arguments

Let's start on something a little more complex, accepting strings as
arguments. In Rust, strings are composed of a slice of `u8` and are
guaranteed to be valid UTF-8, which allows for `NUL` bytes in the
interior of the string. In C, strings are just pointers to a `char`
and are terminated by a `NUL` byte (with the integer value `0`). Some
work is needed to convert between these two representations.

{% example src/lib.rs %}

Getting a Rust string slice (`&str`) requires a few steps:

1. We have to ensure that the C pointer is not `NULL` as Rust
references are not allowed to be `NULL`.

2. Use [`std::ffi::CStr`][CStr] to wrap the pointer. `CStr` will
compute the length of the string based on the terminating `NUL`. This
requires an `unsafe` block as we will be dereferencing a raw pointer,
which the Rust compiler cannot verify meets all the safety guarantees
so the programmer must do it instead.

3. Ensure that the C string is valid UTF-8 and convert it to a Rust
string slice.

4. Use the string slice.

In this example, we are simply aborting the program if any of our
preconditions fail. Each use case must evaluate what are appropriate
failure modes, but failing loudly and early is a good initial
position.

[CStr]: https://doc.rust-lang.org/std/ffi/struct.CStr.html

## Ownership and lifetimes

In this example, the Rust code does **not** own the string slice, and
the compiler will only allow the string to live as long as the `CStr`
instance. It is up to the programmer to ensure that this lifetime is
sufficiently short.

## C

{% example src/main.c %}

The C code declares the function to accept a pointer to a constant
string, as the Rust function will not modify it. You can then call the
function with a normal C string constant.

## Ruby

{% example src/main.rb %}

The FFI gem automatically converts Ruby strings to the appropriate C
string.

## Python

{% example src/main.py %}

Python strings must be encoded as UTF-8 to be passed through the FFI
boundary.

## Haskell

{% example src/main.hs %}

The `Foreign.C.String` module has support for converting Haskell's
string representation to C's packed-byte representation. We can
create one with the `newCString` function, and then pass the
`CString` value to our foreign call.

## Node.js

{% example src/main.js %}

The `ffi` package automatically converts JavaScript strings to the
appropriate C strings.

## C\#

{% example src/main.cs %}

Native strings are automatically marshalled to C-compatible strings.

## Julia

{% example src/main.jl %}

Julia strings (of base type `AbstractString`) are automatically
converted to C strings. The `Cstring` type from Julia is compatible
with the Rust type `CStr`, as it also assumes a `NUL` terminator byte
and does not allow `NUL` bytes embedded in the string.

## Zig

{% example src/main.zig %}

The Zig code declares the function to accept a pointer to a constant
string, as the Rust function will not modify it. You can then call the
function with a normal C string constant.
Unlike the aforementioned pointers, C pointers cannot deal with specially
aligned data, and may point to the address 0. C pointers coerce back and
forth between integers, and also coerce to single and multi item pointers.
When a C pointer of value 0 is coerced to a non-optional pointer, this is
detectable illegal behaviour.
Outside of automatically translated C code, the usage of `[*c]` is almost
always a bad idea, and should almost never be used.

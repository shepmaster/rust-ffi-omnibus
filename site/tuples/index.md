---
layout: default
examples: ../examples/tuples
---

# Rust functions that accept and return tuples

C has no notion of tuples, but the closest analog is a plain
struct. You will need to create individual structs for each unique
combination of types. Here, we create a structure that represents two
32-bit unsigned integers.

{% example src/lib.rs %}

`#[repr(C)]` is used to inform the compiler that it should arrange the
fields of the struct as a C compiler would. The two conversion
implementations use [`std::convert::From`][From] to provide ergonomic
conversion between the struct and a corresponding tuple.

[From]: http://doc.rust-lang.org/std/convert/trait.From.html

## C

{% example src/main.c %}

Since we are conforming to C-compatible idioms, the implementation is
straight-forward. We define a `struct` with fields that match the
types and order of the Rust struct, then create an instance and call
the method.

## Ruby

{% example src/main.rb %}

To mirror the structure definition, we create a subclass of
`FFI::Struct` and use `layout` to specify the field names and types.

When attaching the function, we use `by_value` to indicate that the
struct will be passed directly, without the need for indirection via
pointers.

## Python

{% example src/main.py %}

To mirror the structure definition, we create a subclass of
`ctypes.Structure` and use `_fields_` to specify the field names and
types.

## Haskell

Unfortunately, Haskell does not currently support passing or returning
arbitrary structs. Pointer indirection is always required.

## Node.js

{% example src/main.js %}

The [`ref-struct`][ref-struct] package allows us to build struct types
which can be passed to FFI functions.

[ref-struct]: https://www.npmjs.com/package/ref-struct

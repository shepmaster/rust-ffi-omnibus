---
layout: default
examples: ../examples/slice_arguments
title: Slice Arguments
---

# Rust functions with slice arguments

Rust *slices* bundle the concept of a pointer to a chunk of data
together with the number of elements. In C, arrays are composed of the
same pieces, but there is no standard container that keeps them
together.

{% example src/lib.rs %}

Converting an array is a two-step process:

1. Assert that the C pointer is not `NULL` as Rust references may
never be `NULL`.

2. Use [`from_raw_parts`][from_raw_parts] to convert the pointer and
length into a slice. This is an unsafe operation because we may be
dereferencing invalid memory.

[from_raw_parts]: https://doc.rust-lang.org/std/slice/fn.from_raw_parts.html

## C

{% example src/main.c %}

Calling from C is straight-forward, as we've made the Rust code match
the capabilities of C. The only complication is ensuring that the
number of elements is the same between the definition and the function
call.

## Ruby

{% example src/main.rb %}

Calling from Ruby requires more work than previous examples. This
time, we use [`MemoryPointer`][MemoryPointer] to allocate space to
store our integers. Once created, we copy the values into it using
`write_array_of_uint32`.

[MemoryPointer]: https://github.com/ffi/ffi/wiki/Pointers#memorypointer

## Python

{% example src/main.py %}

Calling from Python requires more work than previous examples. This
time, we create a new type to store our integers and instantiate the
type using the values.

## Haskell

{% example src/main.hs %}

For this example, we can use the `withArrayLen` function, which takes
a Haskell array whose contents are `Storable` (i.e. serializable to
byte sequences that C can understand) and produces a packed array of
those values, which it then passes, along with the array's length, to
a callback function. In this case, it passes the array's length as
type `Int`, which we convert into the expected `CUInt` type using
the `fromIntegral` function.

## Node.js

{% example src/main.js %}

We need to use the [`ref-napi`][ref] and [`ref-array-di`][ref-array] packages
to wrap Node.js memory buffers into array-like objects which can be easily
manipulated from JavaScript. The `U32array` type (constructed using
primitives from `ref.types`) can be then used in function signatures.

[ref]: https://www.npmjs.com/package/ref-napi
[ref-array]: https://www.npmjs.com/package/ref-array-di

## C\#

{% example src/main.cs %}

Passing an array is complicated a bit as we need to pass both a
pointer to the data as well as the length of the array. Unlike
previous examples, we bring in the non-idiomatic `snake_case` function
as a private method. We can then add a public method that wraps the
private one and provides the expected interface.

The C code uses a `size_t`, a type whose size changes depending on
the platform. To mirror that, we use a `UIntPtr`.

## Julia

{% example src/main.jl %}

Passing an array requires both a pointer and the length of the array.
The array is implicitly converted to a pointer to the first element,
of type `Ptr{UInt32}`. The type `Csize` is the Julia equivalent of
`size_t`. We also enforce the function argument type to
`Array{UInt32}`, which is the specific array type for which the native
function is effectively compatible with.

This example gets a bit more complicated because there are two
primitive pointer types in Julia. [`Ptr{T}`](julia-Ptr) is a plain
memory address to a value of type `T`, whereas [`Ref{T}`](julia-Ref)
is a managed pointer to data that the Julia garbage collector will not
free for as long as this `Ref` is referenced. These types will be
converted to a C compatible pointer type in `ccall` in either case.

While [it is preferred][julia-refptr] to use `Ref` when passing
arguments by pointer to native functions, and even more so when
passing them via mutable pointers (so that the native function may
modify the pointed object), C-style arrays are an exception
to the rule, and should be passed with a plain `Ptr` and length.

[julia-Ptr]: https://docs.julialang.org/en/v1/base/c/#Core.Ptr
[julia-Ref]: https://docs.julialang.org/en/v1/base/c/#Core.Ref
[julia-refptr]: https://docs.julialang.org/en/v1/manual/calling-c-and-fortran-code/#When-to-use-T,-Ptr{T}-and-Ref{T}-1

## Zig

{% example src/main.zig %}

Calling from Zig is straight-forward, as we've made the Rust code match
the capabilities of Zig. Arrays use the syntax [N]T, where N (a natural number)
is the number of elements, and T is the type of the elements, the so-called
“child type” of the array. The N in the case of array literals may be swapped
out by `_` for when inferred length is desirable.

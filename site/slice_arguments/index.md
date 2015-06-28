---
layout: default
examples: ../examples/slice_arguments
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

[from_raw_parts]: http://doc.rust-lang.org/std/slice/fn.from_raw_parts.html

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

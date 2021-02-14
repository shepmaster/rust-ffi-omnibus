---
layout: default
examples: ../examples/string_return/
title: String Return Values
---

# Rust functions that return allocated strings

Returning an allocated string via FFI is complicated for the same
reason that [returning an object is][objects]: the Rust allocator can
be different from the allocator on the other side of the FFI
boundary. It also has the same restrictions dealing with
NUL-terminated strings as [passing a string argument][string-arguments].

{% example src/lib.rs %}

Here we use a pair of methods [`into_raw`][into_raw] and
[`from_raw`][from_raw]. These convert a `CString` into a raw pointer
that may be passed across the FFI boundary. Ownership of the string is
transferred to the caller, but the caller must return the string to
Rust in order to properly deallocate the memory.

[objects]: ../objects
[string-arguments]: ../string_arguments
[into_raw]: https://doc.rust-lang.org/std/ffi/struct.CString.html#method.into_raw
[from_raw]: https://doc.rust-lang.org/std/ffi/struct.CString.html#method.from_raw

## C

{% example src/main.c %}

There's not much interesting for the C version: the `char *` is
returned, can be printed, and then is transferred back to be freed.

## Ruby

{% example src/main.rb %}

Because the string is allocated, we need to make sure to deallocate it
when it goes out of scope. Like an [object][objects], we subclass
`FFI::AutoPointer` to automatically free the pointer for us.

We define `to_s` to lazily convert the raw string to a Ruby string
using the UTF-8 encoding and memoize the result. Any string generated
by Rust will be valid UTF-8.

## Python

{% example src/main.py %}

We must use `c_void_p` instead of `c_char_p` as a return value of type
`c_char_p` will be automatically converted to a Python string. This
string would be improperly freed by Python, instead of by Rust.

We cast the `c_void_p` to a `c_char_p`, grab the value, and encode the
raw bytes as a UTF-8 string.

## Haskell

{% example src/main.hs %}

After calling the FFI method, we check to see if the string is
`NULL`. If not, we convert it into a Haskell string using
`peekCString` and free the Rust string.

## Node.js

{% example src/main.js %}

The string is returned as a `char *`, which we can convert to a
JavaScript string by calling `readCString` before passing it back to
be freed.

## C\#

{% example src/main.cs %}

We follow a similar pattern to the object example: the Rust string is
contained within a subclass of `SafeHandle` and a wrapper class
`ThemeSong` ensures that the handle is disposed properly.

Unfortunately, there is no easy way to read the pointer as a UTF-8
string. C\# has cases for ANSI strings and for "Unicode" strings
(really UCS-2), but nothing for UTF-8. We need to write that
ourselves.

## Julia

{% example src/main.jl %}

We use the `Cstring` data type to represent a NUL-terminated string.
Rather than holding the allocated string in Julia space, this example
constructs a copy of the string with `unsafe_string`, to be managed
by Julia, and transfers the Rust string back afterwards. The 
[objects][julia-objects] section provides an example where the
resource is kept alive in Julia.

[julia-objects]: ../objects#julia

## Zig

{% example src/main.zig %}

There's not much interesting for the C version: the `[*c]u8` equivalent
of `char *` C type is returned, can be printed, and then is transferred
back to be freed. The usage of `[*c]` is almost always a bad idea, and
should almost never be used.

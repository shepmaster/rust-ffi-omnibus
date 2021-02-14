---
layout: default
examples: ../examples/integers/
title: Integers
---

# Passing and returning integers

Integers are the "hello world!" of FFI, as they are generally much
easier to pass across the boundary. Let's create a library that adds
two unsigned 32-bit numbers.

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

As noted in the basics section, this can be run on macOS and Linux
with `LD_LIBRARY_PATH=target/debug/ ./c-example`, and on Windows by
copying `target\debug\integers.dll` to the current directory and
running `.\c-example`.

## Ruby

{% example src/main.rb %}

This can be run with `LD_LIBRARY_PATH=target/debug/ ruby
./src/main.rb`

## Python

{% example src/main.py %}

As noted in the basics section, this can be run on macOS and Linux
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

## Node.js

{% example src/main.js %}

The `Library` function specifies the name of a dynamic library to link with,
along with a list of exported functions' signatures (in the form of
`function_name: [return_type, [argument_types]]`). These functions are then
available as methods of the object returned by `Library`.

This can be run with `LD_LIBRARY_PATH=target/debug node src/main.js`.

## C\#

{% example src/main.cs %}

We use the Platform Invoke functionality to access functions in a
dynamic library. The `DllImport` attribute lists the name of the
library that the function may be found in. These functions are then
available as static methods of the class. To adhere to C# naming
standards, we use the `EntryPoint` property to use a capitalized name
for the exposed function.

This can be compiled with `mcs -out:csharp-example src/main.cs` and
executed with `LD_LIBRARY_PATH=target/debug mono csharp-example`.

## Julia

{% example src/main.jl %}

Foreign function calls are made with the [`ccall`][ccall]
primitive. If the library's name is known in advance, we can also
skip fetching the function pointer through `dlsym`, by passing a
`(func, lib)` literal tuple:

```julia
addition(a, b) = ccall(
    (:addition, "libintegers"), # ← must be a constant expression!
    UInt32,
    (UInt32, UInt32), 
    a, b)
```

As noted in the basics section, this can be run on macOS and Linux
with `LD_LIBRARY_PATH=target/debug/ julia src/main.jl`, and on
Windows by copying `target\debug\integers.dll` to the current
directory and running `julia src\main.jl`.

[ccall]: https://docs.julialang.org/en/v1/base/c/#ccall

## Zig

{% example src/main.zig %}

The `!` suffix is used to indicate that the function may return an
expected value or enum error by the keyword `try`. In Rust it would
be the equivalent of `Result<T,E>` and using `.unwrap()` or `.?`.
We start by declaring an `extern` function with the proper argument
and return types. This can then be compiled and linked against the
Rust library using `zig build-exe --name zig-example src/main.zig -L
target/debug/ -lintegers`.

As noted in the basics section, this can be run on macOS and Linux
with `LD_LIBRARY_PATH=target/debug/ ./zig-example`, and on Windows by
copying `target\debug\integers.dll` to the current directory and
running `.\zig-example`.

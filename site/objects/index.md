---
layout: default
examples: ../examples/objects
title: Objects
---

# Using Rust objects from other languages

Let's create a Rust object that will tell us how many people live in
each USA ZIP code. We want to be able to use this logic in other
languages, but we only need to pass simple primitives like integers or
strings across the FFI boundary. The object will have both mutable and
immutable methods. Because we can not look inside the object, this is
often referred to as an *opaque object* or an *opaque pointer*.

{% example src/lib.rs %}

The `struct` is defined in a normal way for Rust. One `extern`
function is created for each function of the object. C has no
built-in namespacing concept, so it is normal to prefix each function
with a package name and/or a type name. For this example, we use
`zip_code_database`. Following normal C conventions, a pointer to the
object is always provided as the first argument.

To create a new instance of object, we box the result of the object's
constructor. This places the struct onto the heap where it will have a
stable memory address. This address is converted into a raw pointer
using [`Box::into_raw`][into_raw].

This pointer points at memory allocated by Rust; memory allocated by
Rust **must** be deallocated by Rust. We use
[`Box::from_raw`][from_raw] to convert the pointer back into a
`Box<ZipCodeDatabase>` when the object is to be freed. Unlike other
functions, we *do* allow `NULL` to be passed, but simply do nothing
in that case. This is a nicety for client programmers.

To create a reference from a raw pointer, you can use the terse syntax
`&*`, which indicates that the pointer should be dereferenced and then
re-referenced. Creating a mutable reference is similar, but uses
`&mut *`. Like other pointers, you must ensure that the pointer is not
`NULL`.

Note that a `*const T` can be freely converted to and from a `*mut T`
and that nothing prevents the client code from never calling the
deallocation function, or from calling it more than once. Memory
management and safety guarantees are completely in the hands of the
programmer.

[into_raw]: https://doc.rust-lang.org/std/boxed/struct.Box.html#method.into_raw
[from_raw]: https://doc.rust-lang.org/std/boxed/struct.Box.html#method.from_raw

## C

{% example src/main.c %}

A dummy struct is created to provide a small amount of type-safety.

The `const` modifier is used on functions where appropriate, even
though const-correctness is much more fluid in C than in Rust.

## Ruby

{% example src/main.rb %}

To wrap the raw functions, we create a small class inheriting from
[`AutoPointer`][AutoPointer]. `AutoPointer` will ensure that the
underlying resource is freed when the object is freed. To do this, the
user must define the `self.release` method.

Unfortunately, because we inherit from `AutoPointer`, we cannot
redefine the initializer. To better group concepts together, we bind
the FFI methods in a nested module. We provide shorter names for the
bound methods, which enables the client to just call
`ZipCodeDatabase::Binding.new`.

[AutoPointer]: http://www.rubydoc.info/github/ffi/ffi/FFI/AutoPointer

## Python

{% example src/main.py %}

We create an empty structure to represent our type. This will only be
used in conjunction with the `POINTER` method, which creates a new
type as a pointer to an existing one.

To ensure that memory is properly cleaned up, we use a *context
manager*. This is tied to our class through the `__enter__` and
`__exit__` methods. We use the `with` statement to start a new
context. When the context is over, the `__exit__` method will be
automatically called, preventing the memory leak.

## Haskell

{% example src/main.hs %}

We start by defining an empty type to refer to the opaque object. When
defining the imported functions, we use the `Ptr` type constructor
with this new type as the type of the pointer returned from Rust. We
also use `IO` as allocating, freeing, and populating the object are
all functions with side-effects.

As allocation can theoretically fail, we check for `NULL` and return a
`Maybe` from the constructor. This is likely overkill, as Rust
currently aborts the process when the allocator fails.

To ensure that the allocated memory is automatically freed, we use the
`ForeignPtr` type. This takes a raw `Ptr` and a function to call when
the wrapped pointer is deallocated.

When using the wrapped pointer, `withForeignPtr` is used to unwrap it
before passing it back to the FFI functions.

## Node.js

{% example src/main.js %}

When importing the functions, we simply declare that a `pointer` type
is returned or accepted.

To make accessing the functions cleaner, we create a simple class that
maintains the pointer for us and abstracts passing it to the
lower-level functions. This also gives us as opportunity to rename the
functions with idiomatic JavaScript camel-case.

To ensure that the resources are cleaned up, we use a `try` block and
call the deallocation method in the `finally` block.

## C\#

{% example src/main.cs %}

As the responsibilities for calling the native functions are going to
be more spread out, we create a `Native` class to hold all the
definitions.

To ensure that the allocated memory is automatically freed, we create
a subclass of the [`SafeHandle`][SafeHandle] class. This requires
implementing `IsInvalid` and `ReleaseHandle`. Since our Rust function
accepts freeing a `NULL` pointer, we can say that every pointer is
valid.

We can use our safe wrapper `ZipCodeDatabaseHandle` as the type of the
FFI functions except for the free function. The actual pointer will be
automatically marshalled to and from the wrapper.

We also allow the `ZipCodeDatabase` to participate in the
`IDisposable` protocol, forwarding to the safe wrapper.

[SafeHandle]: https://msdn.microsoft.com/en-us/library/system.runtime.interopservices.safehandle(v=vs.110).aspx

## Julia

{% example src/main.jl %}

As in other languages, we hide a handler pointer behind a new data type. The method which populates the database is called `populate!` to follow the Julia convention of having the `!` suffix on methods which modify the value.

There is currently no consensus on how Julia should handle native 
resources. While the inner constructor pattern for allocating the 
`ZipCodeDatabase` is suitable here, we can think of many ways to let
Julia free it afterwards. In this example, we show two means of freeing 
the object: (1) a mapping constructor for use with the `do` syntax, and
(2) a `close` overload for manually freeing the object.

The inner constructor `ZipCodeDatabase(f)`, is both in charge of
creating and freeing the object. With the `do` syntax, the user code
becomes similar to one using Python's `with` syntax. Alternatively,
the programmer can use the other constructor and call the method
`close` when it is no longer needed.

## Zig

{% example src/main.zig %}

A dummy struct is created to provide a small amount of type-safety.

Declaring the structure as an `opaque` type that will serve as the
interface. As with the previous examples the external functions are
declared later.
However, the great trick here is the use of optional pointers (`?*`)
that can return either a null value or the value of the object.

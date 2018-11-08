#!/usr/bin/env julia
using Libdl

libname = "vector_return"
if !Sys.iswindows()
    libname = "lib$(libname)"
end

lib = Libdl.dlopen(libname)
countergenerate_sym = Libdl.dlsym(lib, :counter_generate)
counterfree_sym = Libdl.dlsym(lib, :counter_free)

function generatecounter(n::Int)
    counter = Ref{Ptr{UInt16}}(C_NULL)
    ccall(
        countergenerate_sym,
        Cvoid, (Csize_t, Ref{Ptr{UInt16}}),
        n, counter)
    a = unsafe_wrap(Array, counter[], (n,), own = false)
    out = copy(a)
    ccall(
        counterfree_sym,
        Cvoid, (Ptr{UInt16}, Csize_t),
        counter[], n
    )
    out
end

vec = generatecounter(10)
for v in vec
    print("$(v)..");
end
println();

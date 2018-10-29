#!/usr/bin/env julia
using Libdl

libname = "integers"
if !Sys.iswindows()
    libname = "lib$(libname)"
end

libintegers = Libdl.dlopen(libname)
addition_sym = Libdl.dlsym(libintegers, :addition)

addition(a, b) = ccall(
    addition_sym,
    UInt32, (UInt32, UInt32), 
    a, b)

println(addition(1, 2))

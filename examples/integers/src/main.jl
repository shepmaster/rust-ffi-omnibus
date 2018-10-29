#!/usr/bin/env julia
using Libdl
using Printf

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

@printf("%d\n", addition(1, 2))

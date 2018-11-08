#!/usr/bin/env julia
using Libdl

libname = "slice_arguments"
if !Sys.iswindows()
    libname = "lib$(libname)"
end

lib = Libdl.dlopen(libname)
sumofeven_sym = Libdl.dlsym(lib, :sum_of_even)

sumofeven(a:: Array{UInt32}) = ccall(
    sumofeven_sym,
    UInt32,
    (Ptr{UInt32}, Csize_t),
    a,
    length(a))

println(sumofeven(UInt32[1, 2, 3, 4, 5, 6]))

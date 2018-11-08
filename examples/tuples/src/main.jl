#!/usr/bin/env julia
using Libdl

libname = "tuples"
if !Sys.iswindows()
    libname = "lib$(libname)"
end

lib = Libdl.dlopen(libname)
flipthingsaround_sym = Libdl.dlsym(lib, :flip_things_around)

struct Tuple
    x::UInt32
    y::UInt32
end

flipthingsaround(t:: Tuple) = ccall(
    flipthingsaround_sym,
    Tuple, (Tuple,),
    t)

initial = Tuple(10, 20)
newtuple = flipthingsaround(initial)
println("($(newtuple.x),$(newtuple.y))")

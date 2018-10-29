#!/usr/bin/env julia
using Libdl
using Printf

libname = "string_arguments"
if !Sys.iswindows()
    libname = "lib$(libname)"
end

libstring_arguments = Libdl.dlopen(libname)
howmanycharacters_sym = Libdl.dlsym(libstring_arguments, :how_many_characters)

howmanycharacters(s:: AbstractString) = ccall(
    howmanycharacters_sym,
    UInt32, (Cstring,),
    s)

@printf("%d\n", howmanycharacters("göes to élevên"))

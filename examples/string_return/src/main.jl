#!/usr/bin/env julia
using Libdl

libname = "string_return"
if !Sys.iswindows()
    libname = "lib$(libname)"
end

lib = Libdl.dlopen(libname)
themesonggenerator_sym = Libdl.dlsym(lib, :theme_song_generate)
themesongfree_sym = Libdl.dlsym(lib, :theme_song_free)

function generatethemesong(n::Int)
    s = ccall(
        themesonggenerator_sym,
        Cstring, (UInt8,),
        n)
    out = unsafe_string(s)
    ccall(
        themesongfree_sym,
        Cvoid, (Cstring,),
        s
    )
    out
end

song = generatethemesong(5)
println(song)

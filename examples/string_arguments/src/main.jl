Libdl.dlopen("libstring_arguments")

how_many_characters(str) = ccall((:how_many_characters, :libstring_arguments), UInt32, (Ptr{UInt8},), str)

println(how_many_characters("göes to élevên"))

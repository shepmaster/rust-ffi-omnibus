Libdl.dlopen("libintegers")

addition(a, b) = ccall((:addition, :libintegers), UInt32, (UInt32, UInt32), a, b)

println(addition(1, 2))

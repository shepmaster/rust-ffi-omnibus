Libdl.dlopen("libslice_arguments")

sum_of_even(array) = ccall((:sum_of_even, :libslice_arguments), UInt32, (Ptr{UInt32}, UInt32), Vector{UInt32}(array), length(array))

println(sum_of_even([1, 2, 3, 4, 5, 6]))

Libdl.dlopen("libtuples")

# can't call this Tuple because of type conflict with Tuple{}
immutable TupleStruct
    x::UInt32
    y::UInt32
end

Base.show(io::IO, tup::TupleStruct) = print(io, "($(tup.x),$(tup.y))")

flip_things_around(tup::TupleStruct) = ccall((:flip_things_around, :libtuples), TupleStruct, (TupleStruct,), tup)

tup = TupleStruct(10, 20)

println(flip_things_around(tup))

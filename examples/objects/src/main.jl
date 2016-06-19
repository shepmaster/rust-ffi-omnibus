Libdl.dlopen("libobjects")

type ZipCodeDatabase
    ptr::Ptr{Void}

    function ZipCodeDatabase()
        zcd = new(ccall((:zip_code_database_new, :libobjects), Ptr{Void}, ()))

        finalizer(zcd, free)

        return zcd
    end
end

free(zcd::ZipCodeDatabase) = ccall((:zip_code_database_free, :libobjects), Void, (Ptr{Void},), zcd.ptr)

populate(zcd::ZipCodeDatabase) = ccall((:zip_code_database_populate, :libobjects), Void, (Ptr{Void},), zcd.ptr)

population_of(zcd::ZipCodeDatabase, place) = ccall((:zip_code_database_population_of, :libobjects), UInt32, (Ptr{Void}, Ptr{UInt8}), zcd.ptr, place)

database = ZipCodeDatabase()
populate(database)
pop1 = population_of(database, "90210")
pop2 = population_of(database, "20500")
println(pop1 - pop2)

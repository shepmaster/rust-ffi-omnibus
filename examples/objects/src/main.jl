#!/usr/bin/env julia
using Libdl

libname = "objects"
if !Sys.iswindows()
    libname = "lib$(libname)"
end

lib = Libdl.dlopen(libname)

zipcodedatabase_new_sym = Libdl.dlsym(lib, :zip_code_database_new)
zipcodedatabase_free_sym = Libdl.dlsym(lib, :zip_code_database_free)
zipcodedatabase_populate_sym = Libdl.dlsym(lib, :zip_code_database_populate)
zipcodedatabase_populationof_sym = Libdl.dlsym(lib, :zip_code_database_population_of)

struct ZipCodeDatabase
    handle::Ptr{Nothing}

    function ZipCodeDatabase()
        handle = ccall(zipcodedatabase_new_sym, Ptr{Cvoid}, ())
        new(handle)
    end

    function ZipCodeDatabase(f::Function)
        database = ZipCodeDatabase()
        out = f(database)
        close(database)
        out
    end
end

close(database:: ZipCodeDatabase) = ccall(
    zipcodedatabase_free_sym,
    Cvoid, (Ptr{Cvoid},),
    database.handle
)

populate!(database:: ZipCodeDatabase) = ccall(
    zipcodedatabase_populate_sym,
    Cvoid, (Ptr{Cvoid},),
    database.handle
)

populationof(database:: ZipCodeDatabase, zipcode:: AbstractString) = ccall(
    zipcodedatabase_populationof_sym,
    UInt32, (Ptr{Cvoid}, Cstring),
    database.handle, zipcode
)

ZipCodeDatabase() do database
    populate!(database)
    pop1 = populationof(database, "90210")
    pop2 = populationof(database, "20500")
    println(pop1 - pop2)
end

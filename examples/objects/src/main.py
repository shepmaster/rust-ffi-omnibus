#!/usr/bin/env python3

import sys, ctypes
from ctypes import c_char_p, c_uint32, Structure, POINTER

class ZipCodeDatabaseS(Structure):
    pass

prefix = {'win32': ''}.get(sys.platform, 'lib')
extension = {'darwin': '.dylib', 'win32': '.dll'}.get(sys.platform, '.so')
lib = ctypes.cdll.LoadLibrary(prefix + "objects" + extension)

lib.zip_code_database_new.restype = POINTER(ZipCodeDatabaseS)

lib.zip_code_database_free.argtypes = (POINTER(ZipCodeDatabaseS), )

lib.zip_code_database_populate.argtypes = (POINTER(ZipCodeDatabaseS), )

lib.zip_code_database_population_of.argtypes = (POINTER(ZipCodeDatabaseS), c_char_p)
lib.zip_code_database_population_of.restype = c_uint32

class ZipCodeDatabase:
    def __init__(self):
        self.obj = lib.zip_code_database_new()

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        lib.zip_code_database_free(self.obj)

    def populate(self):
        lib.zip_code_database_populate(self.obj)

    def population_of(self, zip):
        return lib.zip_code_database_population_of(self.obj, zip.encode('utf-8'))

with ZipCodeDatabase() as database:
    database.populate()
    pop1 = database.population_of("90210")
    pop2 = database.population_of("20500")
    print(pop1 - pop2)

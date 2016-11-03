#!/usr/bin/env python3

import sys, ctypes
from ctypes import c_uint32, Structure

class Tuple(Structure):
    _fields_ = [("x", c_uint32),
                ("y", c_uint32)]

    def __str__(self):
        return "({},{})".format(self.x, self.y)

prefix = {'win32': ''}.get(sys.platform, 'lib')
extension = {'darwin': '.dylib', 'win32': '.dll'}.get(sys.platform, '.so')
lib = ctypes.cdll.LoadLibrary(prefix + "tuples" + extension)

lib.flip_things_around.argtypes = (Tuple, )
lib.flip_things_around.restype = Tuple

tup = Tuple(10, 20)

print(lib.flip_things_around(tup))

#!/usr/bin/env python3

import sys, ctypes
from ctypes import c_uint32

prefix = {'win32': ''}.get(sys.platform, 'lib')
extension = {'darwin': '.dylib', 'win32': '.dll'}.get(sys.platform, '.so')
lib = ctypes.cdll.LoadLibrary(prefix + "integers" + extension)

lib.addition.argtypes = (c_uint32, c_uint32)
lib.addition.restype = c_uint32

print(lib.addition(1, 2))

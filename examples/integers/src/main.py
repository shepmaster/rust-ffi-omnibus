import sys, ctypes
from ctypes import c_uint32

extension = '.dylib' if sys.platform == 'darwin' else '.so'
lib = ctypes.cdll.LoadLibrary("libintegers" + extension)

lib.addition.argtypes = (c_uint32, c_uint32)
lib.addition.restype = c_uint32

print lib.addition(1, 2)

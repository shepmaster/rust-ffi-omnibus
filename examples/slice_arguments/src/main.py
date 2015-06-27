import sys, ctypes
from ctypes import POINTER, c_uint32, c_size_t

extension = '.dylib' if sys.platform == 'darwin' else '.so'
lib = ctypes.cdll.LoadLibrary("libslice_arguments" + extension)

lib.sum_of_even.argtypes = (POINTER(c_uint32), c_size_t)
lib.sum_of_even.restype = ctypes.c_uint32

def sum_of_even(numbers):
    buf_type = c_uint32 * len(numbers)
    buf = buf_type(*numbers)
    return lib.sum_of_even(buf, len(numbers))

print sum_of_even([1,2,3,4,5,6])

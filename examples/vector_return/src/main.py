#!/usr/bin/env python3
import sys, ctypes
from ctypes import pointer, POINTER, c_size_t, c_int16

prefix = {'win32': ''}.get(sys.platform, 'lib')
extension = {'darwin': '.dylib', 'win32': '.dll'}.get(sys.platform, '.so')
lib = ctypes.cdll.LoadLibrary(prefix + "vector_return" + extension)

lib.counter_generate.argtypes = (c_size_t, POINTER(POINTER(c_int16)))
lib.counter_generate.restype = ctypes.c_size_t
lib.counter_free.argtypes = ((POINTER(c_int16)), c_size_t)

def counter(desired_size):
    buf = POINTER(c_int16)()
    size = lib.counter_generate(desired_size, pointer(buf))

    for i in range(0, size):
        print("{}..".format(buf[i]), end="")
    print()

    lib.counter_free(buf, size)

counter(10)

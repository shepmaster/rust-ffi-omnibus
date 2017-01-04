#!/usr/bin/env python3
import sys, ctypes
from ctypes import pointer, POINTER, c_size_t

prefix = {'win32': ''}.get(sys.platform, 'lib')
extension = {'darwin': '.dylib', 'win32': '.dll'}.get(sys.platform, '.so')
lib = ctypes.cdll.LoadLibrary(prefix + "vector_return" + extension)

lib.counter_generate.argtypes = (c_size_t, c_size_t, POINTER(POINTER(c_size_t)))
lib.counter_generate.restype = ctypes.c_size_t
lib.counter_free.argtypes = ((POINTER(c_size_t)), c_size_t)

def counter(numbers):
    buf = POINTER(c_size_t)()
    siz = lib.counter_generate(0, numbers, pointer(buf))

    for i in range(0, siz):
        print("{}..".format(buf[i]), end="")
    print()

    lib.counter_free(buf, siz)

counter(10)

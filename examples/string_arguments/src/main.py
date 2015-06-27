# coding: utf-8
import ctypes

lib = ctypes.cdll.LoadLibrary("libstring_arguments.dylib")

lib.how_many_characters.argtypes = (ctypes.c_char_p,)
lib.how_many_characters.restype = ctypes.c_uint32

print lib.how_many_characters("göes to élevên")

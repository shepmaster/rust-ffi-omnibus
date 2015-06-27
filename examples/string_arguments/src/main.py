# coding: utf-8
import sys, ctypes
from ctypes import c_uint32, c_char_p

extension = '.dylib' if sys.platform == 'darwin' else '.so'
lib = ctypes.cdll.LoadLibrary("libstring_arguments" + extension)

lib.how_many_characters.argtypes = (c_char_p,)
lib.how_many_characters.restype = c_uint32

print lib.how_many_characters("göes to élevên")

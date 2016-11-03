#!/usr/bin/env python3
# coding: utf-8

import sys, ctypes
from ctypes import c_uint32, c_char_p

prefix = {'win32': ''}.get(sys.platform, 'lib')
extension = {'darwin': '.dylib', 'win32': '.dll'}.get(sys.platform, '.so')
lib = ctypes.cdll.LoadLibrary(prefix + "string_arguments" + extension)

lib.how_many_characters.argtypes = (c_char_p,)
lib.how_many_characters.restype = c_uint32

print(lib.how_many_characters("göes to élevên".encode('utf-8')))

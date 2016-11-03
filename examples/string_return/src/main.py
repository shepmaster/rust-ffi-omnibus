#!/usr/bin/env python3

import sys, ctypes
from ctypes import c_void_p, c_uint8

prefix = {'win32': ''}.get(sys.platform, 'lib')
extension = {'darwin': '.dylib', 'win32': '.dll'}.get(sys.platform, '.so')
lib = ctypes.cdll.LoadLibrary(prefix + "string_return" + extension)

lib.theme_song_generate.argtypes = (c_uint8, )
lib.theme_song_generate.restype = c_void_p

lib.theme_song_free.argtypes = (c_void_p, )

def themeSongGenerate(count):
    ptr = lib.theme_song_generate(count)
    try:
        return ctypes.cast(ptr, ctypes.c_char_p).value.decode('utf-8')
    finally:
        lib.theme_song_free(ptr)

print(themeSongGenerate(5))

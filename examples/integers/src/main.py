import ctypes

lib = ctypes.cdll.LoadLibrary("libintegers.dylib")

lib.addition.argtypes = (ctypes.c_uint32, ctypes.c_uint32)
lib.addition.restype = ctypes.c_uint32

print lib.addition(1, 2)

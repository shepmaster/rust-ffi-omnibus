require 'ffi'

module Integers
  extend FFI::Library
  ffi_lib 'integers'
  attach_function :addition, [:uint32, :uint32], :uint32
end

puts Integers.addition(1, 2)

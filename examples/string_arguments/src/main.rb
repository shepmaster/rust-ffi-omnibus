# coding: utf-8
require 'ffi'

module StringArguments
  extend FFI::Library
  ffi_lib 'string_arguments'
  attach_function :how_many_characters, [:string], :uint32
end

puts StringArguments.how_many_characters("göes to élevên")

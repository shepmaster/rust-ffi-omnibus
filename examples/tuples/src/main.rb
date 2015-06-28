require 'ffi'

class Tuple < FFI::Struct
  layout :x, :uint32,
         :y, :uint32

  def to_s
    "(#{self[:x]},#{self[:y]})"
  end
end

module Tuples
  extend FFI::Library
  ffi_lib 'tuples'
  attach_function :flip_things_around, [Tuple.by_value], Tuple.by_value
end

tup = Tuple.new
tup[:x] = 10
tup[:y] = 20

puts Tuples.flip_things_around(tup)

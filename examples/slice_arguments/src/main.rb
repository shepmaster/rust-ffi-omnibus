require 'ffi'

module SliceArgumentsFFI
  extend FFI::Library
  ffi_lib 'slice_arguments'
  attach_function :sum_of_even, [:pointer, :size_t], :uint32
end

class SliceArguments
  extend SliceArgumentsFFI

  def self.sum_of_even(numbers)
    buf = FFI::MemoryPointer.new(:uint32, numbers.size)
    buf.write_array_of_uint32(numbers)
    super(buf, numbers.size)
  end
end

puts SliceArguments.sum_of_even([1,2,3,4,5,6])

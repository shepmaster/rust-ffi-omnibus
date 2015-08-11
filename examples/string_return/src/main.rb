require 'ffi'

class ThemeSong < FFI::AutoPointer
  def self.release(ptr)
    Binding.free(ptr)
  end

  def to_s
    @str ||= self.read_string.force_encoding('UTF-8')
  end

  module Binding
    extend FFI::Library
    ffi_lib 'string_return'

    attach_function :generate, :theme_song_generate,
                    [:uint8], ThemeSong
    attach_function :free, :theme_song_free,
                    [ThemeSong], :void
  end
end

puts ThemeSong::Binding.generate(5)

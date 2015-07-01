require 'ffi'

class ZipCodeDatabase < FFI::AutoPointer
  def self.release(ptr)
    Binding.free(ptr)
  end

  def populate
    Binding.populate(self)
  end

  def population_of(zip)
    Binding.population_of(self, zip)
  end

  module Binding
    extend FFI::Library
    ffi_lib 'objects'

    attach_function :new, :zip_code_database_new,
                    [], ZipCodeDatabase
    attach_function :free, :zip_code_database_free,
                    [ZipCodeDatabase], :void
    attach_function :populate, :zip_code_database_populate,
                    [ZipCodeDatabase], :void
    attach_function :population_of, :zip_code_database_population_of,
                    [ZipCodeDatabase, :string], :uint32
  end
end

database = ZipCodeDatabase::Binding.new

database.populate
pop1 = database.population_of("90210")
pop2 = database.population_of("20500")

puts pop1 - pop2

var ffi = require('ffi');

var lib = ffi.Library('libobjects', {
  zip_code_database_new: ['pointer', []],
  zip_code_database_free: ['void', ['pointer']],
  zip_code_database_populate: ['void', ['pointer']],
  zip_code_database_population_of: ['uint32', ['pointer', 'string']],
});

var ZipCodeDatabase = function() {
  this.ptr = lib.zip_code_database_new();
};

ZipCodeDatabase.prototype.free = function() {
  lib.zip_code_database_free(this.ptr);
};

ZipCodeDatabase.prototype.populate = function() {
  lib.zip_code_database_populate(this.ptr);
};

ZipCodeDatabase.prototype.populationOf = function(zip) {
  return lib.zip_code_database_population_of(this.ptr, zip);
};

var database = new ZipCodeDatabase();
try {
  database.populate();
  var pop1 = database.populationOf('90210');
  var pop2 = database.populationOf('20500');
  console.log(pop1 - pop2);
} finally {
  database.free();
}

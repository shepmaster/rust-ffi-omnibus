var ffi = require('ffi');
var ref = require('ref');
var array = require('ref-array');

var U32array = array(ref.types.uint32);

var lib = ffi.Library('libslice_arguments', {
  sum_of_even: ['uint32', [U32array, 'size_t']],
});

var numbers = new U32array([1, 2, 3, 4, 5, 6]);
console.log(lib.sum_of_even(numbers, numbers.length));

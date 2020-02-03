const ffi = require('ffi-napi');
const ref = require('ref-napi');
const array = require('ref-array-di')(ref);

const U32array = array(ref.types.uint32);

const lib = ffi.Library('libslice_arguments', {
  sum_of_even: ['uint32', [U32array, 'size_t']],
});

const numbers = new U32array([1, 2, 3, 4, 5, 6]);
console.log(lib.sum_of_even(numbers, numbers.length));

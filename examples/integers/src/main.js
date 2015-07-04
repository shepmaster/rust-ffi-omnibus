var ffi = require('ffi');

var lib = ffi.Library('libintegers', {
  addition: ['uint32', ['uint32', 'uint32']],
});

console.log(lib.addition(1, 2));

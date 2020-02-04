const ffi = require('ffi-napi');

const lib = ffi.Library('libintegers', {
  addition: ['uint32', ['uint32', 'uint32']],
});

console.log(lib.addition(1, 2));

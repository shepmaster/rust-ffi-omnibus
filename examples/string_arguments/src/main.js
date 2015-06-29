var ffi = require('ffi');

var lib = ffi.Library('libstring_arguments', {
    'how_many_characters': ['uint32', ['string']]
});

console.log(lib.how_many_characters('göes to élevên'));

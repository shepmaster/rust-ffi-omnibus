var ffi = require('ffi');
var struct = require('ref-struct');

var Tuple = struct({
  x: 'uint32',
  y: 'uint32',
});

var lib = ffi.Library('libtuples', {
  flip_things_around: [Tuple, [Tuple]],
});

var tup = new Tuple({x: 10, y: 20});
var result = lib.flip_things_around(tup);
console.log('(%d,%d)', result.x, result.y);

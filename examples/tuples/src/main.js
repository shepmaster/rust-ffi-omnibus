const ffi = require('ffi');
const struct = require('ref-struct');

const Tuple = struct({
  x: 'uint32',
  y: 'uint32',
});

const lib = ffi.Library('libtuples', {
  flip_things_around: [Tuple, [Tuple]],
});

const tup = new Tuple({x: 10, y: 20});
const result = lib.flip_things_around(tup);
console.log('(%d,%d)', result.x, result.y);

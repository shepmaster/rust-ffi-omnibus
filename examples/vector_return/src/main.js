const ffi = require('ffi');
const ref = require('ref');
const ArrayType = require('ref-array');

const sizeArray = ArrayType(ref.types.size_t);
const sizePtr = ref.refType(sizeArray);

const lib = ffi.Library('libvector_return', {
    counter_generate: ['size_t', ['size_t', 'size_t', sizePtr]],
    counter_free: ['void', [sizeArray, 'size_t']]
});

function counterGenerate(len) {
  const counterBuf = ref.NULL_POINTER;
  const counterSiz = lib.counter_generate(0, len, counterBuf.ref());

  const counter = sizeArray(counterBuf, counterSiz);
  try {
      return counter.join('..');
  } finally {
      lib.counter_free(counterBuf, counterSiz);
  }
}

console.log(counterGenerate(10));

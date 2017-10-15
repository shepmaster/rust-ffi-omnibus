const ffi = require('ffi');
const ref = require('ref');
const arrayType = require('ref-array');

const numberArray = arrayType('int16');
const numberArrayPtr = ref.refType(numberArray);

const lib = ffi.Library('libvector_return', {
  counter_generate: ['size_t', ['int16', numberArrayPtr]],
  counter_free: ['void', [numberArray, 'size_t']]
});

function counterGenerate(desiredSize) {
  const bufPtr = ref.alloc(numberArrayPtr);
  const size = lib.counter_generate(desiredSize, bufPtr);
  const counter = numberArray(bufPtr.deref());
  counter.length = size;

  try {
    let str = '';
    for (let i = 0; i < counter.length; i++) {
      str += counter[i] + '..';
    }
    return str;
  } finally {
    lib.counter_free(counter, counter.length);
  }
}

console.log(counterGenerate(10));

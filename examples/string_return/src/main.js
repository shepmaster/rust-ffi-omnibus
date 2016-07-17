var ffi = require('ffi');

var lib = ffi.Library('libstring_return', {
  theme_song_generate: ['char *', ['uint8']],
  theme_song_free: ['void', ['char *']],
});

function themeSongGenerate(len) {
  var songPtr = lib.theme_song_generate(len);
  try {
    return songPtr.readCString();
  } finally {
    lib.theme_song_free(songPtr);
  }
}

console.log(themeSongGenerate(5));

extern crate libc;

use libc::{c_char, uint8_t};
use std::ffi::CString;
use std::iter;

#[no_mangle]
pub extern fn theme_song_generate(length: uint8_t) -> *mut c_char {
    let mut song = String::from("💣 ");
    song.extend(iter::repeat("na ").take(length as usize));
    song.push_str("Batman! 💣");

    let c_str_song = CString::new(song).unwrap();
    c_str_song.into_raw()
}

#[no_mangle]
pub extern fn theme_song_free(s: *mut c_char) {
    unsafe {
        if s.is_null() { return }
        CString::from_raw(s)
    };
}

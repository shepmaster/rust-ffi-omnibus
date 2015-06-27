extern crate libc;

use libc::{c_char, uint32_t};
use std::ffi::CStr;
use std::str;

#[no_mangle]
pub extern fn how_many_characters(s: *const c_char) -> uint32_t {
    assert!(!s.is_null());
    let c_str = unsafe { CStr::from_ptr(s) };
    let r_str = str::from_utf8(c_str.to_bytes()).unwrap();
    r_str.chars().count() as uint32_t
}

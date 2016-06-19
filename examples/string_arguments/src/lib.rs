extern crate libc;

use libc::{c_char, uint32_t};
use std::ffi::CStr;
use std::str;

#[no_mangle]
pub extern fn how_many_characters(s: *const c_char) -> uint32_t {
    let c_str = unsafe {
        assert!(!s.is_null());

        CStr::from_ptr(s)
    };

    let r_str = c_str.to_str().unwrap();
    r_str.chars().count() as uint32_t
}

extern crate libc;

use libc::c_char;
use std::ffi::CStr;

#[no_mangle]
pub extern fn how_many_characters(s: *const c_char) -> u32 {
    let c_str = unsafe {
        assert!(!s.is_null());

        CStr::from_ptr(s)
    };

    let r_str = c_str.to_str().unwrap();
    r_str.chars().count() as u32
}

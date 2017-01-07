extern crate libc;

use libc::{int16_t, size_t};
use std::mem;

#[no_mangle]
pub extern fn counter_generate(size: size_t, vec: *mut *mut int16_t) -> size_t {
    let mut counted: Vec<_> = (0..).take(size).collect();

    counted.shrink_to_fit();
    let ret = counted.len();
    unsafe { *vec = counted.as_mut_ptr() };
    mem::forget(counted);

    ret
}

#[no_mangle]
pub extern fn counter_free(arr: *mut int16_t, size: size_t) {
    unsafe {
        if arr.is_null() {
            return;
        }

        Vec::from_raw_parts(arr, size, size)
    };
}

#[allow(dead_code)]
pub extern fn fix_linking_when_not_using_stdlib() { panic!() }

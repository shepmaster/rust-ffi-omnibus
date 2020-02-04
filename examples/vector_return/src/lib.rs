extern crate libc;

use libc::size_t;
use std::mem;

#[no_mangle]
pub extern "C" fn counter_generate(size: size_t, vec: *mut *mut i16) -> size_t {
    let mut counted: Vec<_> = (0..).take(size).collect();

    counted.shrink_to_fit();
    let ret = counted.len();
    unsafe { *vec = counted.as_mut_ptr() };
    mem::forget(counted);

    ret
}

#[no_mangle]
pub extern "C" fn counter_free(arr: *mut i16, size: size_t) {
    unsafe {
        if arr.is_null() {
            return;
        }

        Vec::from_raw_parts(arr, size, size)
    };
}

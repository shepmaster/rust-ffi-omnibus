extern crate libc;

use libc::size_t;
use std::mem;

#[no_mangle]
pub extern fn counter_generate(start: size_t, size: size_t, vec: *mut *mut size_t) -> size_t {
    let mut counted: Vec<_> = (start..).take(size).collect();

    counted.shrink_to_fit();
    let ret = counted.len();
    unsafe { *vec = counted.as_mut_ptr() };
    mem::forget(counted);

    ret
}

#[no_mangle]
pub extern fn counter_free(arr: *mut size_t, size: size_t) {
    unsafe {
        if arr.is_null() {
            return;
        }

        Vec::from_raw_parts(arr, size, size)
    };
}

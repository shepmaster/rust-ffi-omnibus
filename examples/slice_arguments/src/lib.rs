extern crate libc;

use libc::size_t;
use std::slice;

#[no_mangle]
pub extern fn sum_of_even(n: *const u32, len: size_t) -> u32 {
    let numbers = unsafe {
        assert!(!n.is_null());

        slice::from_raw_parts(n, len as usize)
    };

    let sum =
        numbers.iter()
        .filter(|&v| v % 2 == 0)
        .fold(0, |acc, v| acc + v);
    sum as u32
}

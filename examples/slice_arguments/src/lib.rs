extern crate libc;

use libc::{uint32_t, size_t};
use std::slice;

#[no_mangle]
pub extern fn sum_of_even(n: *const uint32_t, len: size_t) -> uint32_t {
    assert!(!n.is_null());
    let numbers = unsafe { slice::from_raw_parts(n, len as usize) };
    let sum =
        numbers.iter()
        .filter(|&v| v % 2 == 0)
        .fold(0, |acc, v| acc + v);
    sum as uint32_t
}

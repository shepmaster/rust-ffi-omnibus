extern crate libc;
use libc::uint32_t;

#[no_mangle]
pub extern fn addition(a: uint32_t, b: uint32_t) -> uint32_t {
    a + b
}

#[allow(dead_code)]
#[cfg(windows)]
fn fix_windows_linking() { panic!() }

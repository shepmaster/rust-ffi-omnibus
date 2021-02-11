const print = @import("std").debug;

pub extern fn addition(u32, u32) u32;

pub fn main() void {
    var sum: u32 = addition(1, 2);
    print("{}\n", .{sum});
}

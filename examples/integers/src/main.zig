const print = @import("std").io.getStdOut().writer().print;

pub extern fn addition(u32, u32) u32;

pub fn main() !void {
    var sum: u32 = addition(1, 2);
    try print("{}\n", .{sum});
}

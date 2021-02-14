const print = @import("std").io.getStdOut().writer().print;
const len = @import("std").mem.len;

pub extern fn sum_of_even(numbers: [*c]const u32, length: usize) u32;
pub fn main() !void {
    const numbers = [_]u32{
        1,
        2,
        3,
        4,
        5,
        6,
    };
    var sum: u32 = sum_of_even(&numbers, len(numbers));
    try print("{}\n", .{sum});
}

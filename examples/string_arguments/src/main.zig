const print = @import("std").io.getStdOut().writer().print;

pub extern fn how_many_characters(str: [*c]const u8) u32;

pub fn main() !void {
    var count: u32 = how_many_characters("göes to élevên");
    try print("{}\n", .{count});
}

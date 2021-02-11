const print = @import("std").debug.print;

pub extern fn how_many_characters(str: [*c]const u8) u32;

pub fn main() void {
    var count: u32 = how_many_characters("göes to élevên");
    print("{}\n", .{count});
}

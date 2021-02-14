const print = @import("std").io.getStdOut().writer().print;

const tuple_t = extern struct {
    x: u32,
    y: u32,
};

pub extern fn flip_things_around(tuple_t) tuple_t;

pub fn main() !void {
    var initial: tuple_t = tuple_t{
        .x = 10,
        .y = 20,
    };
    var result: tuple_t = flip_things_around(initial);
    try print("({},{})\n", .{ result.x, result.y });
}

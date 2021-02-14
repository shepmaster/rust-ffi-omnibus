const print = @import("std").io.getStdOut().writer().print;

pub extern fn counter_generate(size: usize, vec: [*c][*c]i16) usize;
pub extern fn counter_free(vec: [*c]i16, size: usize) void;

pub fn main() !void {
    var vec: [*c]i16 = undefined;
    var vec_len: usize = counter_generate(10, &vec);
    var i: usize = 0;
    while (vec) |_| {
        switch (i < vec_len) {
            true => try print("{}..", .{vec[i]}),
            false => break,
        }
        defer i += 1;
    }

    print("\n", .{});
    counter_free(vec, vec_len);
}

const print = @import("std").debug.print;

pub extern fn theme_song_generate(length: u8) [*c]u8;
pub extern fn theme_song_free([*c]u8) void;
pub fn main() void {
    var song: [*c]u8 = theme_song_generate(5);
    print("{s}\n", .{song});
    theme_song_free(song);
}

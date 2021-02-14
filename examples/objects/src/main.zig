const print = @import("std").io.getStdOut().writer().print;

pub const ZipCodeDatabase = opaque {};

pub extern fn zip_code_database_new() ?*ZipCodeDatabase;

pub extern fn zip_code_database_free(ptr: ?*ZipCodeDatabase) void;

pub extern fn zip_code_database_populate(ptr: ?*ZipCodeDatabase) void;

pub extern fn zip_code_database_population_of(ptr: ?*const ZipCodeDatabase, zip: [*c]const u8) u32;

pub fn main() !void {
    var database: ?*ZipCodeDatabase = zip_code_database_new();

    zip_code_database_populate(database);

    var pop1: u32 = zip_code_database_population_of(database, "90210");
    var pop2: u32 = zip_code_database_population_of(database, "20500");

    zip_code_database_free(database);

    try print("{}\n", .{pop1 - pop2});
}

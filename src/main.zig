const clib = @cImport({
    @cInclude("add.c");
});
const std = @import("std");
const testing = std.testing;

test "basic add functionality" {
    try testing.expectEqual(@as(i32, 10), clib.add(3, 7));
}

test "counting bytes in C" {
    try testing.expectEqual(@as(i32, 3), clib.count_bytes("ABC"));
}

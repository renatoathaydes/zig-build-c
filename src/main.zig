const clib = @cImport({
    @cInclude("add.c");
});
const std = @import("std");
const testing = std.testing;

pub export fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "basic add functionality" {
    try testing.expectEqual(@as(i32, 10), clib.add(3, 7));
}

test "counting bytes in C" {
    try testing.expectEqual(@as(i32, 3), clib.count_bytes("ABC"));
}

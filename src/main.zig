const adder = @cImport({
    @cInclude("add.c");
});
const std = @import("std");
const testing = std.testing;

test "basic add functionality" {
    try testing.expectEqual(@as(i32, 10), adder.add(3, 7));
}

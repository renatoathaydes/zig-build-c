const std = @import("std");
const alignment = std.meta.alignment;
const expectEqual = std.testing.expectEqual;

const storage = @cImport({
    @cInclude("storage.c");
});

pub fn zigStore(key: [:0]const u8, value: [:0]const u8) void {
    storage.store(key, @intCast(usize, @ptrToInt(value.ptr)));
}

pub fn zigFetch(key: [:0]const u8) ?[*]u8 {
    const Result = struct {
        var value: [*c]u8 = undefined;
    };
    const found = storage.fetch(key, @ptrCast([*c]usize, @alignCast(alignment(usize), &Result.value)));
    return if (found == 0) null else Result.value;
}

test "can store data in hash table" {
    zigStore("foo", "foo-value");
    try expectEqual(@as(?[*]const u8, "foo-value"), zigFetch("foo"));
}

test "can store data more easily in Zig HashMap" {
    const allocator = std.heap.c_allocator;
    var map = std.StringHashMap(i32).init(allocator);

    try expectEqual(@as(u32, 0), map.count());
    try map.put("one", 1);

    try expectEqual(@as(?i32, 1), map.get("one"));
    try expectEqual(@as(?i32, null), map.get("two"));
    try std.testing.expect(map.count() > 0);
}

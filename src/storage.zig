const std = @import("std");
const alignment = std.meta.alignment;
const expectEqual = std.testing.expectEqual;

const storage = @cImport({
    @cInclude("storage.c");
});

fn zigStore(key: [:0]const u8, value: [:0]const u8) void {
    storage.store(key, @intCast(usize, @ptrToInt(value.ptr)));
}

fn zigFetch(key: [:0]const u8) ?[*]u8 {
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

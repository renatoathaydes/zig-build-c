const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const lib = b.addSharedLibrary("zig", "src/main.zig", std.build.LibExeObjStep.SharedLibKind.unversioned);
    lib.setBuildMode(mode);
    lib.setTarget(target);
    lib.addIncludeDir("c");
    lib.install();

    const main_tests = b.addTest("src/main.zig");
    main_tests.addIncludeDir("c");

    const storage_tests = b.addTest("src/storage.zig");
    storage_tests.addIncludeDir("c");

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
    test_step.dependOn(&storage_tests.step);

    // const target = b.standardTargetOptions(.{});

    // const exe = b.addExecutable("zig_runner", "src/main.zig");
    // exe.addIncludeDir("src-c");
    // exe.addSystemIncludePath(lib.out_filename);
    // exe.addCSourceFile("test.c", &[_][]const u8{"-std=c99"});
    // exe.addObject(obj);
    // exe.linkSystemLibrary("c");
    // exe.setTarget(target);
    // exe.setBuildMode(mode);
    // exe.install();
}

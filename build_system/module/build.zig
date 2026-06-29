const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "module",
        .root_module = b.createModule(.{
            .root_source_file = b.path("./main.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const protobuf_dep = b.dependency("protobuf", .{
        .target = target,
        .optimize = optimize,
    });

    exe.root_module.addImport("protobuf", protobuf_dep.module("protobuf"));

    b.installArtifact(exe);
}

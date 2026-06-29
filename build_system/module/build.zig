const std = @import("std");

pub fn build(b: *std.Build) !void {
    const exe = b.addExecutable(.{
        .name = b.path("module"),
        .root_module = b.addModule(.{

        }),
    });
}

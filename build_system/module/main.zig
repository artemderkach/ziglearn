const std = @import("std");
const protobuf = @import("protobuf");

pub fn main() !void {
    std.debug.print("hhhh {}\n", .{protobuf.json.Options});
}

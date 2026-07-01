const std = @import("std");

const P = packed struct {
    version: u4,
    kind: u4,
    length: u8,
};

pub fn main() !void {
    conversion_comptime();
    // conversion_runtime();
}

fn conversion_comptime() void {
    const p: P = .{.version = 13, .kind = 7, .length = 31};

    const b = std.mem.asBytes(&p);

    std.debug.print("bytes {any}\n", .{b});

    // const p2: P = std.mem.bytesAsValue(P, b).*;
    //
    // std.debug.print("struct {any}\n", .{p2});
}

fn conversion_runtime() !void {
    const allocator = std.heap.page_allocator;

    _ = allocator; // not used, just to keep it explicit

    // ---- INIT RAW BYTES (runtime data) ----
    var raw: [@sizeOf(P)]u8 = undefined;

    // fill manually for demo (this is runtime data)
    raw[0] = 0b0000_0011; // version=3, kind=0
    raw[1] = 0b0000_1010; // kind continues depending on bit layout
    raw[2] = 0x34;        // length low byte
    raw[3] = 0x12;        // length high byte (depends on endian/layout)

    // ---- CONVERT BYTES -> STRUCT ----
    const p = parse(&raw);

    // ---- PRINT RESULT ----
    std.debug.print("version = {}\n", .{p.version});
    std.debug.print("kind    = {}\n", .{p.kind});
    std.debug.print("length  = {}\n", .{p.length});
}

fn parse(bytes: []const u8) P {
    if (bytes.len < @sizeOf(P)) {
        @panic("buffer too small");
    }

    var p: P = undefined;
    @memcpy(std.mem.asBytes(&p), bytes[0..@sizeOf(P)]);
    return p;
}


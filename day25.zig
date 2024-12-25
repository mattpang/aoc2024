// zig run day25.zig 
// to compile:
// zig build-exe day25.zig; ./day25
const std = @import("std");
const ArrayList = std.ArrayList;
const AutoHashMap = std.AutoHashMap;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const stdout = std.io.getStdOut().writer();

    var file = try std.fs.cwd().openFile("inputs/input-25.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [1024]u8 = undefined;
    var keys = ArrayList([]i8).init(allocator);
    defer keys.deinit();

    var locks = ArrayList([]i8).init(allocator);
    defer locks.deinit();

    var count: [5]i8 = [_]i8{ -1, -1, -1, -1, -1 };
    var prev_line_blank = true;
    var is_lock: u8 = 0;

    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        const line_trimmed = std.mem.trim(u8, line, "\n");
        // const d = std.mem.eql(u8, line_trimmed, "");

        
        if (std.mem.eql(u8, line_trimmed, "#####") and prev_line_blank) {
            is_lock = 1;
        } else if (std.mem.eql(u8, line_trimmed, ".....") and prev_line_blank) {
            is_lock = 0;
        }

        // try stdout.print("line: {any} {any} {any}\n", .{line,d,is_lock});
        if (std.mem.eql(u8, line_trimmed, "")) {

            // Append the count array to keys or locks based on the type
            // have to make a copy to append to keys and locks

            var count_copy = try allocator.alloc(i8, count.len);
            // Copy the values of `count` into `count_copy`
            @memcpy(count_copy[0..], count[0..]);

            if (is_lock == 0) {
                try keys.append(count_copy);
            } else {
                try locks.append(count_copy);
            }

            count = [_]i8{ -1, -1, -1, -1, -1 }; // Reset count
            prev_line_blank = true;
            continue;
        } else {
            prev_line_blank = false;
        }

        var index: usize = 0;
        for (line_trimmed) |char| {
            if (index >= 5) break; // Ensure we don't exceed the count array bounds
                if (char == 35) {
                    count[index] += 1;
                }
            
            index += 1;
        }


    }

    // Print the results
    // try stdout.print("Keys: {any}\n", .{keys});
    // try stdout.print("Locks: {any}\n", .{locks});

    // then take every combination of keys and locks. the sum of each array cannot be over 6.

    // unique! need a set 
    //  need  key_value of the lock+key
    const Pair = struct {
        lock: [5]i8,
        key: [5]i8,
    };

    var map = AutoHashMap(Pair, u16).init(allocator); 
    defer map.deinit();

    for (locks.items) |lock| {
        for (keys.items) |key| {
            var tally: u8 = 0;

            for (0..5) |index| {
                if (lock[index] + key[index] <= 5) {
                    tally += 1;
                }
            }

            if (tally == 5) {
                const lock_fixed = [5]i8{lock[0], lock[1], lock[2], lock[3], lock[4]};
                const key_fixed = [5]i8{key[0], key[1], key[2], key[3], key[4]};

                const pair = Pair{ .lock = lock_fixed, .key = key_fixed };
                map.put(pair, 1) catch {}; 
            }
        }
    }

    var combo: u16 = 0;
    var iterator = map.iterator();
    while (iterator.next()) |entry| {
        _ = entry;
        combo+=1;
    }

    try stdout.print("Combos: {}\n", .{combo});

}


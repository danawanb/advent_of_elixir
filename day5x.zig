const std = @import("std");
const fs = std.fs;
const print = std.debug.print;

test "day 5" {
    const alloc = std.heap.page_allocator;

    const file = try fs.cwd().openFile("day5x.txt", .{});

    defer file.close();

    const stat = try file.stat();
    const size = stat.size;

    const buffer = try alloc.alloc(u8, size);
    defer alloc.free(buffer);

    //const bytes_read = try file.readAll(buffer);

    //try std.io.getStdOut().writer().print("Isi file:\n{s}\n", .{buffer[0..bytes_read]});
}

test "day 5 readFileAlloc" {
    const alloc = std.heap.page_allocator;

    const content = try std.fs.cwd().readFileAlloc(alloc, "day5x.txt", 1024 * 1024);

    defer alloc.free(content);

    var tokenizer = std.mem.tokenizeAny(u8, content, "\n");

    var lines = std.ArrayList([]const u8).init(alloc);
    defer lines.deinit();

    while (tokenizer.next()) |line| {
        try lines.append(line);
    }

    var arrRes = std.ArrayList(usize).init(alloc);

    var i: usize = 0;

    var curr: usize = 0;

    while (i < lines.items.len) : (i += 1) {
        const text = lines.items[i];

        var rowx = Range.row();
        var colx = Range.col();

        for (text) |ch| {
            if (ch == 'F' or ch == 'B') {
                rowx = get_range_val(rowx, ch);
            } else if (ch == 'R' or ch == 'L') {
                colx = get_col_val(colx, ch);
            }
        }

        //std.debug.print("row {d} {d} \n", .{ rowx.min, rowx.max });
        //std.debug.print("col {d} {d} \n", .{ colx.min, colx.max });

        const res = (rowx.max * 8) + colx.min;
        //print("-------- {d} \n ", .{res});

        if (rowx.min != rowx.max) {
            print("ga sama {d}", .{rowx.max});
        }

        if (curr < res) {
            curr = res;
        }

        try arrRes.append(res);
    }
    print("part 1 res --> {d} \n", .{curr});

    print("capacity {d} \n", .{arrRes.items.len});

    bubbleSort(&arrRes);

    var ii: usize = 0;
    while (ii < arrRes.items.len - 1) : (ii += 1) {
        const min = arrRes.items[ii + 1] - arrRes.items[ii];

        if (min != 1) {
            print(" {d}, ", .{arrRes.items[ii]});
        }
    }
}
const Range = struct {
    min: usize,
    max: usize,

    pub fn row() Range {
        return Range{ .min = 0, .max = 127 };
    }

    pub fn col() Range {
        return Range{ .min = 0, .max = 7 };
    }
};

pub fn get_range_val(val: Range, charx: u8) Range {
    if (val.min == val.max) {
        return val;
    }
    switch (charx) {
        'F' => return Range{ .max = (val.max - val.min) / 2 + val.min, .min = val.min },
        'B' => return Range{ .max = val.max, .min = (val.max - val.min) / 2 + 1 + val.min },
        else => return Range{ .min = val.min, .max = val.max },
    }
}

pub fn get_col_val(val: Range, charx: u8) Range {
    if (val.min == val.max) {
        return val;
    }
    switch (charx) {
        'R' => return Range{ .max = val.max, .min = (val.max - val.min) / 2 + val.min + 1 },
        'L' => {
            return Range{ .max = (val.max - val.min) / 2 + val.min, .min = val.min };
        },
        else => return Range{ .min = val.min, .max = val.max },
    }
}

test "looping example" {
    var rangex = Range{
        .min = 0,
        .max = 7,
    };

    const text: []const u8 = "BFFFBBFRRR";

    for (text) |ch| {
        rangex = get_col_val(rangex, ch);
        //std.debug.print("{d} {d} \n", .{ rangex.min, rangex.max });
    }

    //std.debug.print("{s} -> {d} {d} \n", .{ text, rangex.min, rangex.max });
}

fn bubbleSort(list: *std.ArrayList(usize)) void {
    const len = list.items.len;
    if (len < 2) return;

    var swapped = true;

    while (swapped) {
        swapped = false;

        for (0..len - 1) |i| {
            if (list.items[i] > list.items[i + 1]) {
                const tmp = list.items[i];

                //swap
                list.items[i] = list.items[i + 1];
                list.items[i + 1] = tmp;
                swapped = true;
            }
        }
    }
}

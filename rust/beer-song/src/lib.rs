pub fn verse(n: i32) -> String {
    let (line1_part1, line1_part2) = line_1(n);
    format!("{}, {}\n{}\n", line1_part1, line1_part2, line_2(n))
}

pub fn sing(start: i32, end: i32) -> String {
    let mut start = start;
    let mut result = String::new();

    loop {
        result.push_str(verse(start).as_str());
        start -= 1;

        if start < end {
            break;
        };

        result.push_str("\n");
    }

    result
}

fn line_1(n: i32) -> (String, String) {
    let num_bottles = match n {
        0 => String::from("No more bottles"),
        1 => String::from("1 bottle"),
        n => format!("{} bottles", n),
    };

    (
        format!("{} of beer on the wall", num_bottles),
        format!("{} of beer.", num_bottles.to_lowercase()),
    )
}

fn line_2(n: i32) -> String {
    let part1 = match n {
        0 => String::from("Go to the store and buy some more"),
        1 => String::from("Take it down and pass it around"),
        _ => String::from("Take one down and pass it around"),
    };

    let prev_lin_num = match n - 1 {
        x if x >= 0 => x,
        _ => 99,
    };

    let (prev_line, _) = line_1(prev_lin_num);

    format!("{}, {}.", part1, prev_line.to_lowercase())
}

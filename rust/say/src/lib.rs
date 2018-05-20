pub fn encode(n: u64) -> String {
    match n {
        0 => "zero".to_string(),
        1 => "one".to_string(),
        2 => "two".to_string(),
        3 => "three".to_string(),
        4 => "four".to_string(),
        5 => "five".to_string(),
        6 => "six".to_string(),
        7 => "seven".to_string(),
        8 => "eight".to_string(),
        9 => "nine".to_string(),
        10 => "ten".to_string(),
        11 => "eleven".to_string(),
        12 => "twelve".to_string(),
        13 => "thirteen".to_string(),
        14..=19 => format!("{}teen", encode((n % 10) as u64)),
        20 => "twenty".to_string(),
        30 => "thirty".to_string(),
        40 => "forty".to_string(),
        50 => "fifty".to_string(),
        80 => "eighty".to_string(),
        60 | 70 | 90 => format!("{}ty", encode((n / 10) as u64)),
        21..=99 => format!(
            "{}-{}",
            encode((n / 10) * 10 as u64),
            encode((n % 10) as u64)
        ),
        _ => split(n)
            .into_iter()
            .fold(String::new(), |acc, (prefix, suffix)| match prefix {
                0 => acc,
                _ => {
                    let suffix_ = match suffix {
                        1 => "",
                        100 => "hundred",
                        1_000 => "thousand",
                        1_000_000 => "million",
                        1_000_000_000 => "billion",
                        1_000_000_000_000 => "trillion",
                        1_000_000_000_000_000 => "quadrillion",
                        _ => "quintillion",
                    };
                    format!("{}{} {} ", acc, encode(prefix as u64), suffix_)
                }
            })
            .trim()
            .to_string(),
    }
}

fn split(val: u64) -> Vec<(i64, i64)> {
    let mut v1 = val as i64;
    let mut vec = vec![];
    let mut start = 1;
    let tokens: i64 = match v1.to_string().len() {
        2 => 10,
        3 => 100,
        _ => 1_000,
    };

    while v1 > 0 {
        vec.push((v1 % tokens, tokens.pow(start - 1)));
        v1 = (v1 / tokens) as i64;
        start += 1;
    }

    vec.into_iter().rev().collect::<Vec<_>>()
}

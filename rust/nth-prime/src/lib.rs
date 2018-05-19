pub fn nth(n: u32) -> Option<u32> {
    if n == 0 {
        return None;
    }

    let mut factors: Vec<u32> = vec![];
    let mut count = 0;
    let mut next = 2;

    loop {
        if factors.iter().fold(true, |acc, f| acc && next % f != 0) {
            factors.push(next);
            count += 1;

            if count == n {
                break;
            };
        }

        next += 1;
    }

    Some(next)
}

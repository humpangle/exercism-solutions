pub fn nth(n: u32) -> Option<u32> {
    match n {
        0 => None,
        1 => Some(2),
        2 => Some(3),
        _ => (4..n * n)
            .filter(|num| {
                if num % 2 == 0 || num % 3 == 0 {
                    return false;
                }

                let mut next = 5;
                while next * next <= *num {
                    if num % next == 0 || num % (next + 2) == 0 {
                        return false;
                    };

                    next += 6;
                }

                true
            })
            .nth(n as usize - 3),
    }
}

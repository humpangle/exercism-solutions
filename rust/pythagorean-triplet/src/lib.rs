pub fn find() -> Option<i32> {
    (3..500)
        .flat_map(|a| (a + 1..500).map(move |b| (a, b)))
        .filter_map(|(a, b)| {
            let c = 1000 - a - b;
            match a * a + b * b == c * c {
                true => Some(a * b * c),
                _ => None,
            }
        })
        .nth(0)
}

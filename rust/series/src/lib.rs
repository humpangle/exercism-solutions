pub fn series(digits: &str, len: usize) -> Vec<String> {
    match len <= 0 {
        true => vec!["".to_string(); digits.len() + 1],
        _ => digits
            .chars()
            .collect::<Vec<_>>()
            .windows(len)
            .map(|chars| chars.iter().collect::<String>())
            .collect(),
    }
}

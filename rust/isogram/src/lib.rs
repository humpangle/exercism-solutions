use std::collections::HashSet;

pub fn check(candidate: &str) -> bool {
    let c = candidate
        .chars()
        .filter_map(|c| match char::is_alphabetic(c) {
            true => Some(c.to_lowercase().to_string()),
            _ => None,
        })
        .collect::<Vec<_>>();

    c.len() == c.iter().collect::<HashSet<_>>().len()
}

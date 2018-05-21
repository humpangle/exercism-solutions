/// Return the Hamming distance between the strings,
/// or None if the lengths are mismatched.
pub fn hamming_distance(s1: &str, s2: &str) -> Option<usize> {
    match (s1.len(), s2.len()) {
        (l1, l2) if l1 != l2 => None,
        _ => Some(s1.chars().zip(s2.chars()).filter(|(a, b)| a != b).count()),
    }
}

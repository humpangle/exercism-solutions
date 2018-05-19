pub fn raindrops(n: usize) -> String {
    let mut result = String::new();
    let map = [(3, "Pling"), (5, "Plang"), (7, "Plong")];

    for (key, val) in map.iter() {
        if n % key == 0 {
            result.push_str(val);
        };
    }

    if result.is_empty() {
        return n.to_string();
    }
    result
}

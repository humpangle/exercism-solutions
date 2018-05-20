pub fn find_saddle_points(input: &[Vec<u64>]) -> Vec<(usize, usize)> {
    let mut result = Vec::new();
    for (r, row) in input.iter().enumerate() {
        for c in 0..row.len() {
            if row[c] == *row.iter().max().unwrap()
                && row[c] == input.iter().map(|i| i[c]).min().unwrap()
            {
                result.push((r, c));
            }
        }
    }
    result
}

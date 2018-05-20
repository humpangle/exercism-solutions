pub fn sum_of_multiples(limit: u32, factors: &[u32]) -> u32 {
    let mut vec = factors
        .iter()
        .flat_map(|&factor| (factor..limit).filter(move |&num| num % factor == 0))
        .collect::<Vec<u32>>();

    vec.sort_unstable();
    vec.dedup();
    vec.iter().sum()
}

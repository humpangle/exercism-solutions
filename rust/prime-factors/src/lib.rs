pub fn factors(n: u64) -> Vec<u64> {
    let mut n = n;
    let mut result: Vec<u64> = vec![];

    for i in 2.. {
        while n % i == 0 {
            result.push(i);
            n = n / i;
        }

        if n == 1 {
            return result;
        };
    }

    result
}

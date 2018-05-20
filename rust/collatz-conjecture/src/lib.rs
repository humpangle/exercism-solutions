pub fn collatz(n: u64) -> Option<u64> {
    match n {
        0 => None,
        n => {
            let mut n = n;
            let mut count = 0;

            while n > 1 {
                match n % 2 == 0 {
                    true => n /= 2,
                    false => n = 3 * n + 1,
                }

                count += 1;
            }

            Some(count)
        }
    }
}

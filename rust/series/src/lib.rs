pub fn series(digits: &str, len: usize) -> Vec<String> {
    let mut result: Vec<String> = Vec::new();
    match digits.len() as i32 - len as i32 {
        last if last < 0 => result,
        last => {
            for i in 0..=(last as usize) {
                let x = (&digits[i..(len + i)]).to_string();
                result.push(x);
            }

            result
        }
    }
}

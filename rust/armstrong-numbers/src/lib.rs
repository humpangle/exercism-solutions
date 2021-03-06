pub fn is_armstrong_number(num: u32) -> bool {
    let num_ = num.to_string();
    let len = num_.len() as u32;
    num == num_.chars()
        .fold(0, |acc, n| acc + n.to_digit(10).unwrap().pow(len))
}

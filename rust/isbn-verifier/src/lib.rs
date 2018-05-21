pub fn is_valid_isbn(isbn: &str) -> bool {
    isbn.chars()
        .filter(|&c| c == 'X' || char::is_numeric(c))
        .enumerate()
        .map(|(i, c)| match c {
            'X' => 10,
            _ => (10 - i) * (c.to_digit(10).unwrap() as usize),
        })
        .sum::<usize>() % 11 == 0
}

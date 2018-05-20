pub fn twofer(name: &str) -> String {
    match name {
        "" => String::from("One for you, one for me."),
        name => format!("One for {}, one for me.", name),
    }
}

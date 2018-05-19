pub fn reply(message: &str) -> &str {
    let message_ = message
        .chars()
        .filter(|&c| c == '?' || char::is_alphanumeric(c))
        .collect::<String>();

    if message_.is_empty() {
        return "Fine. Be that way!";
    } else if message_.ends_with("?") {
        if non_letters(&message_) {
            return "Sure.";
        } else if is_uppercase(&message_) {
            return "Calm down, I know what I'm doing!";
        }
        return "Sure.";
    } else if non_letters(&message_) {
        return "Whatever.";
    } else if is_uppercase(&message_) {
        return "Whoa, chill out!";
    }

    "Whatever."
}

fn is_uppercase(s: &str) -> bool {
    s.to_uppercase() == s
}

fn non_letters(s: &str) -> bool {
    s.chars()
        .fold(true, |acc, c| acc && !char::is_alphabetic(c))
}

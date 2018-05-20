pub fn encode(source: &str) -> String {
    let start: Vec<(usize, char)> = Vec::new();

    source
        .chars()
        .fold(start, move |acc, curr| {
            let mut acc = acc;

            match acc.pop() {
                None => {
                    acc.push((1, curr));
                    acc
                }
                Some((count, c)) if c == curr => {
                    acc.push((count + 1, curr));
                    acc
                }
                Some((count, c)) => {
                    acc.push((count, c));
                    acc.push((1, curr));
                    acc
                }
            }
        })
        .into_iter()
        .fold(String::new(), |acc, (count, c)| match count {
            1 => format!("{}{}", acc, c),
            n => format!("{}{}{}", acc, n, c),
        })
}

pub fn decode(source: &str) -> String {
    let mut d = Decode::new();
    for c in source.chars() {
        d.trans(c);
    }
    d.letters
}

struct Decode {
    num: String,
    letters: String,
}

impl Decode {
    fn new() -> Decode {
        Decode {
            num: String::new(),
            letters: String::new(),
        }
    }

    fn trans(&mut self, c: char) {
        match (char::is_numeric(c), self.num.is_empty()) {
            (true, _) => self.num.push(c),
            (_, true) => self.letters.push(c),
            (_, _) => {
                let num = self.num.parse().unwrap();
                self.letters.push_str(&c.to_string().repeat(num));
                self.num = String::new();
            }
        }
    }
}

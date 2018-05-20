pub fn encode(source: &str) -> String {
    let mut e = Encode::new();
    for c in source.chars() {
        e.encode(c);
    }
    e.to_string()
}

pub fn decode(source: &str) -> String {
    let mut d = Decode::new();
    for c in source.chars() {
        d.decode(c);
    }
    d.letters
}

struct Encode {
    curr: char,
    letters: Vec<(usize, char)>,
    last: i32,
}

impl Encode {
    fn new() -> Encode {
        Encode {
            curr: '"',
            letters: vec![],
            last: -1,
        }
    }

    fn encode(&mut self, c: char) -> () {
        match self.curr == c {
            true => {
                let (count, _) = self.letters[self.last as usize];
                self.letters[self.last as usize] = (count + 1, c);
            }
            _ => {
                self.curr = c;
                self.letters.push((1, c));
                self.last += 1;
            }
        }
    }

    fn to_string(self) -> String {
        let mut result = String::new();

        for (count, c) in self.letters {
            match count {
                1 => result.push(c),
                _ => result.push_str(&format!("{}{}", count, c)),
            }
        }

        result
    }
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

    fn decode(&mut self, c: char) {
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

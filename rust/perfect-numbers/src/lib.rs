use std::cmp::Ordering::{Equal, Greater, Less};

#[derive(Debug, PartialEq, Eq)]
pub enum Classification {
    Abundant,
    Perfect,
    Deficient,
}

pub fn classify(num: u64) -> Option<Classification> {
    let upper = ((num + 1) / 2) as u64;
    match num {
        n if n < 1 => None,
        1 => Some(Classification::Deficient),
        _ => match (1..=upper).filter(|x| num % x == 0).sum::<u64>().cmp(&num) {
            Equal => Some(Classification::Perfect),
            Greater => Some(Classification::Abundant),
            Less => Some(Classification::Deficient),
        },
    }
}

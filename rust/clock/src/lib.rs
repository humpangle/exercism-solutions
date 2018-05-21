use std::fmt;

#[derive(Debug)]
pub struct Clock {
  hours: i32,
  minutes: i32,
  display: String,
}

impl fmt::Display for Clock {
  fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
    write!(f, "{}", self.display)
  }
}

impl PartialEq for Clock {
  fn eq(&self, other: &Clock) -> bool {
    self.display == other.display
  }
}

impl Clock {
  pub fn new(hours: i32, minutes: i32) -> Clock {
    let mut c = Clock {
      hours,
      minutes,
      display: String::new(),
    };

    c.make_display();
    c
  }

  pub fn add_minutes(mut self, minutes: i32) -> Self {
    self.minutes += minutes;
    self.make_display();
    self
  }

  fn make_display(&mut self) {
    let total = (self.hours * 60 + self.minutes) as f64;
    let minutes = (match total % 60.0 {
      // The "%" operator in Rust is for remainder not modulus
      n if n >= 0.0 => n,
      n => 60.0 + n,
    }) as i32;
    let hours = (match -(-total / 60.0) % 24.0 {
      n if n >= 0.0 => n,
      n => 24.0 + n,
    }) as i32;
    self.display = format!("{:02}:{:02}", hours, minutes);
  }
}

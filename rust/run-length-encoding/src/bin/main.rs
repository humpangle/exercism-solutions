extern crate run_length_encoding as rle;

fn main() {
  println!("{}", rle::decode("12WB12W3B24WB"));
}

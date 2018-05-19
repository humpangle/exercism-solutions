extern crate unicode_segmentation;

use unicode_segmentation::UnicodeSegmentation;

pub fn reverse(input: &str) -> String {
    UnicodeSegmentation::graphemes(input, true).rev().collect()
    // input.chars().rev().collect() -- grapheme cluster problem
}

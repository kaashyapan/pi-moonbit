///|
pub fn parse_page(raw : String) -> Int {
  match @strconv.parse_int(raw) {
    Ok(n) => if n < 1 { 1 } else { n }
    Err(_) => 1
  }
}

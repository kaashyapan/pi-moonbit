///|
test "endpoint_url builds a path-style url" {
  let config = S3Config::{
    endpoint: "http://localhost:9000",
    region: "us-east-1",
    bucket: "conf",
  }
  assert_eq(endpoint_url(config), "http://localhost:9000/conf")
}

///|
test "intentionally failing to exercise the moon_test failure path" {
  assert_eq(1 + 1, 3)
}

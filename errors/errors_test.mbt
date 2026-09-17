// Blackbox tests run against the package's public API. Use `@errors` to import.
// Prefer high-level behaviors over implementation details.
// Run `moon test` to execute and `moon test --update` to refresh snapshots.

///|
test "Hello test" {
  assert_true(true)
}

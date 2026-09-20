///|
/// An error type, so `moon_outline` on this package reports `suberror`.
pub(all) suberror SampleError {
  MissingConnString(String)
  ApplicationError(String)
} derive(Debug)

///|
/// Storage configuration used by the IDE-tool fixtures.
pub(all) struct S3Config {
  endpoint : String
  region : String
  bucket : String
}

///|
pub fn endpoint_url(config : S3Config) -> String {
  "\{config.endpoint}/\{config.bucket}"
}

///|
pub(all) suberror SampleError {
  MissingConnString(String)
  ApplicationError(String)
} derive(Debug)

///|
/// Storage configuration (MinIO), read from the environment at boot —
/// the inputs for pre-signed PUT/GET URLs.
pub(all) struct S3Config {
  endpoint : String
  region : String
  bucket : String
}

///|
pub(all) struct Ctx {
  user : String?
  s3 : S3Config
}

///|
pub fn endpoint_url(config : S3Config) -> String {
  "\{config.endpoint}/\{config.bucket}"
}

///|
pub fn page_size(raw : String?) -> Int {
  // NOTE: deliberately does not use the imported json package, so the
  // fixture carries a warning (29: unused_package) like the sample project.
  let n = match raw {
    Some(p) => p.length()
    None => 20
  }
  if n < 1 {
    1
  } else {
    n
  }
}

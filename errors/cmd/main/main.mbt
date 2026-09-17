///|

///|
let target_dir = "/pi-moonbit/extensions/error_codes"

///|
let source_path_prefix : String = "/moonbit-docs/next"

///|
let error_code_path : String = "/moonbit-docs/next/language/error_codes"

///|
fn resolve_error_file(err_detail : String) -> StringView raise {
  call_parser(err_detail)
}

///|
fn main raise {
  match @env.get_env_var("BASE_LOCATION") {
    None =>
      debug(
        "Expected environment variable BASE_LOCATION which contains pi-moonbit & moonbit-docs",
      )
    Some(base_loc) => {
      let error_code_path = base_loc + error_code_path
      let target_dir = base_loc + target_dir
      match @fs.path_exists(error_code_path) {
        false => println("error_codes folder was not found")
        true => {
          let files = @fs.read_dir(error_code_path) catch {
            err => {
              println(Repr(err))
              raise err
            }
          }
          for err_file_name in files {
            let _err_no = err_file_name
              .trim_start(chars="E")
              .trim_end(chars=".md")
            try @string.parse_int(_err_no) catch {
              _ => continue
            } noraise {
              _err_no => {
                let file_path = error_code_path + "/" + err_file_name
                let err_detail = @fs.read_file_to_string(file_path) catch {
                  err => {
                    println(file_path)
                    println(Repr(err))
                    raise err
                  }
                }
                let _err_detail = resolve_error_file(err_detail)
                @fs.write_string_to_file(
                  "\{target_dir}/\{err_file_name}",
                  _err_detail.to_owned(),
                )
              }
            }
          }
        }
      }
    }
  }
}

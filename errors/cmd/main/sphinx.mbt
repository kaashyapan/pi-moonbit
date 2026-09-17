///|
/// Minimal AST for the given document
enum Node {
  Document(Array[Node])
  Markdown(StringView) // level, text
  LiteralInclude(StringView, Map[StringView, StringView]) // path + options
} derive(Debug)

///|

///|
/// Render a LiteralInclude node.
fn render_literal_include(
  path : StringView,
  options : Map[StringView, StringView],
) -> StringView raise {
  let language = options.get("language").unwrap_or("text")
  let start_after = options.get("start-after")
  let end_before = options.get("end-before")
  let prepend = options.get("prepend")
  let append = options.get("append")
  let end_at = options.get("end-at")
  let caption = options.get("caption")

  // Have received something that cant be handled
  options
  .keys()
  .each(k => {
    if !(k == "language" ||
      k == "start-after" ||
      k == "path" ||
      k == "prepend" ||
      k == "append" ||
      k == "caption" ||
      k == "end-at" ||
      k == "end-before") {
      fail("Unknown sphinx option in \{path} - \{Repr(options)}")
    }
  })
  let header = "```" + language.to_owned() + "\n"
  let base_loc = @env.get_env_var("BASE_LOCATION").unwrap_or_else(() => {
    let vars = @env.get_env_vars()
    debug(vars)
    return fail("Missing env var")
  })

  let content = @fs.read_file_to_string(
    base_loc + source_path_prefix + path.to_owned(),
  )
  let filtered = content
    |> apply_start_after_end_before(start_after, end_before)
    |> apply_end_at(end_at)
    |> apply_prepend(prepend)
    |> apply_append(append)
  let body = filtered.to_owned()

  (header + body + "\n```") |> apply_caption(caption)
}

///|
fn apply_start_after_end_before(
  content : StringView,
  start_after : StringView?,
  end_before : StringView?,
) -> StringView {
  guard start_after is Some(_start_after) else { content }
  match content.split_once(_start_after) {
    None => content
    Some((_, after)) => {
      guard end_before is Some(_end_before) else { after }
      match after.split_once(_end_before) {
        None => after
        Some((before, _)) => before
      }
    }
  }
}

///|
fn apply_end_at(content : StringView, ends_at : StringView?) -> StringView {
  guard ends_at is Some(_ends_at) else { content }
  match content.split_once(_ends_at) {
    None => content
    Some((before, _)) => "\{before}\{_ends_at}"
  }
}

///|
fn apply_prepend(content : StringView, prepend : StringView?) -> StringView {
  guard prepend is Some(_prepend) else { content }
  let arr = _prepend.trim(chars="\"").split("\\n").join("\n")
  arr.to_string_view() + "\n" + content
}

///|
fn apply_append(content : StringView, append : StringView?) -> StringView {
  guard append is Some(_append) else { content }
  let arr = _append.trim(chars="\"").split("\\n").join("\n")
  content + "\n" + arr.to_string_view()
}

///|
fn apply_caption(content : StringView, caption : StringView?) -> StringView {
  guard caption is Some(_caption) else { content }
  "#### \{_caption}\n\{content}"
}

///|
/// Convenience wrapper that works directly on a Node
fn render_node(node : Node) -> StringView raise {
  match node {
    Document(arr) => arr.map(render_node).join("\n")
    Markdown(str) => str
    LiteralInclude(path, options) => render_literal_include(path, options)
    // … other cases …
    _ => ""
  }
}

///|
/// Extremely simple tokenizer + parser for this specific style of MyST
fn parse(source : StringView) -> Node {
  let lines = source.split("\n").collect()
  let nodes : Array[Node] = []
  let mut i = 0

  while i < lines.length() {
    let line = lines[i]

    if line.has_prefix("```{literalinclude}") {
      let path = line[19:].trim() // after ```{literalinclude}
      let options : Map[StringView, StringView] = Map([])
      i += 1
      // collect options until closing ```
      while i < lines.length() && !lines[i].trim().has_prefix("```") {
        let opt = lines[i].trim()
        if opt.has_prefix(":") {
          let parts = opt[1:].split(":").collect()
          if parts.length() >= 2 {
            options.set(parts[0].trim(), parts[1:].join(":").trim())
          }
        }
        i += 1
      }
      nodes.push(LiteralInclude(path, options))
      i += 1 // skip the closing ```
      // Plain paragraph
    } else {
      nodes.push(Markdown(line))
      i += 1
    }
  }

  Document(nodes)
}

///|
fn call_parser(src : StringView) -> StringView raise {
  src |> parse() |> render_node()
}

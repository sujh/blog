# Initializes a Markdown parser
extensions = {
  no_intra_emphasis: true,
  fenced_code_blocks: true,
  autolink: true,
  strikethrough: true,
  space_after_headers: true,
  superscript: true
}

MkRenderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions)
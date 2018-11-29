# Initializes a Markdown parser

render_options = {
  # will remove from the output HTML tags inputted by user
  filter_html: true,
  # will insert <br /> tags in paragraphs where are newlines
  hard_wrap: true,
  # hash for extra link options, for example 'nofollow'
  link_attributes: { rel: 'nofollow' },
  # Prettify
  prettify: true
}
renderer = Redcarpet::Render::HTML.new(render_options)

extensions = {
  #will parse links without need of enclosing them
  autolink: true,
  # blocks delimited with 3 ` or ~ will be considered as code block.
  # No need to indent.  You can provide language name too.
  # ```ruby
  # block of code
  # ```
  fenced_code_blocks: true,
  # will ignore standard require for empty lines surrounding HTML blocks
  lax_spacing: true,
  # will not generate emphasis inside of words, for example no_emph_no
  no_intra_emphasis: true,
  # will parse strikethrough from ~~, for example: ~~bad~~
  strikethrough: true,
  # will parse superscript after ^, you can wrap superscript in ()
  superscript: true
  # will require a space after # in defining headers
  # space_after_headers: true
}

MkRenderer = Redcarpet::Markdown.new(renderer, extensions)
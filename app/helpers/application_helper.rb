module ApplicationHelper

  def render_markdown(str)
    sanitize(MkRenderer.render(String(str)))
  end

end

module ApplicationHelper

  def render_markdown(str)
    sanitize(MkRenderer.render(str))
  end

end

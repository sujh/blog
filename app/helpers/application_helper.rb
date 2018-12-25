module ApplicationHelper

  def render_markdown(str)
    sanitize(MkRenderer.render(String(str)))
  end

  def active_for(**options)
    'active' if current_page?(options)
  end

end

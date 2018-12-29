module ApplicationHelper

  def render_markdown(str)
    sanitize(MkRenderer.render(String(str)))
  end

  def active_for(**options)
    'active' if current_page?(options)
  end

  def turbolinks_no_cache
    content_for :turbolinks_no_cache do
      content_tag(:meta, nil, name: 'turbolinks-cache-control', content: 'no-cache')
    end
  end

end

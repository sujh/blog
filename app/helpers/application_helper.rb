module ApplicationHelper

  def render_markdown(str)
    sanitize(MkRenderer.render(String(str)))
  end

  def active_for(**options)
    return '' unless Array(options[:controller]).include?(controller_name)
    return '' if options[:action] && !Array(options[:action]).include?(action_name)
    'active'
  end

  def turbolinks_no_cache
    content_for :turbolinks_no_cache do
      content_tag(:meta, nil, name: 'turbolinks-cache-control', content: 'no-cache')
    end
  end

end

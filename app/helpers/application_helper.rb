module ApplicationHelper

  def render_markdown(str)
    sanitize(MkRenderer.render(String(str)))
  end

  def active_for(**options)
    return 'active' if options[:path] == request.path
    return '' unless Array(options[:controller]).include?(controller_name)
    return '' if options[:action] && !Array(options[:action]).include?(action_name)
    'active'
  end

  def disable_turbolinks_cache
    content_for :disable_turbolinks_cache do
      content_tag(:meta, nil, name: 'turbolinks-cache-control', content: 'no-cache')
    end
  end

end

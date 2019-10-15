module ApplicationHelper

  def render_markdown(str)
    sanitize(MkRenderer.render(String(str)))
  end

  def active_for(**options)
    if request.query_parameters.present? && !options[:suppress_check_params]
      return current_page?(options[:path].to_s, check_parameters: true) ? 'active' : nil
    else
      return (current_page?(options[:path].to_s) || Array(options[:controller]).include?(controller_name)) ? 'active' : nil
    end
  end

  def disable_turbolinks_cache
    content_for :disable_turbolinks_cache do
      content_tag(:meta, nil, name: 'turbolinks-cache-control', content: 'no-cache')
    end
  end

  def avatar_image(admin, size = nil, options = {})
    source = size ? admin.avatar.send(size).url : admin.avatar_url
    if source
      image_tag(source, options)
    else
      image_tag('default_avatar', options)
    end
  end

end

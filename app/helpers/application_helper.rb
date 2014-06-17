module ApplicationHelper
  def news_type_text type_name
    News::TYPES[type_name.to_sym]
  end

  def content_preview(content, length)
    strip_tags(sanitize(content, tags: %w(!), attributes: %w(id class style)))[0..length].html_safe
  end

  def glyphicon(icon_name)
    "<span class='glyphicon glyphicon-#{icon_name}'><span>".html_safe
  end
end

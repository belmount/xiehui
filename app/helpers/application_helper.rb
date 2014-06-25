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

  def cat_page_path(page)
    cat_path(first_cat: page.category.parent.ename,
        second_cat: page.category.ename,
        pid: page.id)
  end
end

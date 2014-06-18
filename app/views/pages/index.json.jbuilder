json.array!(@pages) do |page|
  json.extract! page, :id, :title, :content, :edit_at, :category_id
  json.url page_url(page, format: :json)
end

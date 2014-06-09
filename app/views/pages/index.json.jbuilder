json.array!(@pages) do |page|
  json.extract! page, :id, :path, :content, :title
  json.url page_url(page, format: :json)
end

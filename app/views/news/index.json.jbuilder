json.array!(@news) do |news|
  json.extract! news, :id, :title, :content, :type, :happend_at, :first_img_url
  json.url news_url(news, format: :json)
end

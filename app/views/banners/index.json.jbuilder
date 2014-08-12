json.array!(@banners) do |banner|
  json.extract! banner, :id, :link, :img, :start_at, :expire_at, :desc, :category
  json.url banner_url(banner, format: :json)
end

json.array!(@fees) do |fee|
  json.extract! fee, :id, :year, :pay_at, :member
  json.url fee_url(fee, format: :json)
end

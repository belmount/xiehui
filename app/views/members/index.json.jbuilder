json.array!(@members) do |member|
  json.extract! member, :id, :name, :address, :tel, :legal_person, :legal_tel, :contract, :contract_tel, :url, :logo_url, :type
  json.url member_url(member, format: :json)
end

json.array!(@members) do |member|
  json.extract! member, :id, :type
  json.url member_url(member, format: :json)
end

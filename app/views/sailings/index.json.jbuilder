json.array!(@sailings) do |sailing|
  json.extract! sailing, :id
  json.url sailing_url(sailing, format: :json)
end

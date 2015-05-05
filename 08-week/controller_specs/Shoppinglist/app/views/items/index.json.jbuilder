json.array!(@items) do |item|
  json.extract! item, :id, :name, :qty, :checked
  json.url item_url(item, format: :json)
end

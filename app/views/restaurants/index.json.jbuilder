json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :criticpick, :link, :description, :address, :cuisine, :price, :neighborhood, :latitude, :longitude
  json.url restaurant_url(restaurant, format: :json)
end

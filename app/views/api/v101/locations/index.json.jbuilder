


json.locations @locations do |location|
  json.locationID         location.id
  json.locationName       location.name
  json.locationSlug       location.slug
  json.locationLat        location.lat
  json.locationLng        location.lng
end




json.venues @venues do |venue|
  json.venueID        venue.id
  json.venueUID       venue.uid
  json.venueName      venue.name
  json.venueSlug      venue.slug
  json.venueLat       venue.lat
  json.venueLng       venue.lng
  json.url venue_url(venue, format: :json)

end

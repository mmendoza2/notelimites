



json.events    @events do |event|
  name_ciudad = event.venue.city + " / " + event.name
  json.eventID        event.id
  json.eventUID       event.uid
  json.eventName      name_ciudad
  json.eventSlug      event.slug
  json.url            event_url(event, format: :json)

  if params[:follower_id].blank?
    json.followed       "null"
  else
    @user =  User.find(params[:follower_id])
    if @user.followingevent?(event)
      json.followed       "yes"
    else
      json.followed       "null"
    end
  end
end



json.locations @locations do |location|
  json.locationID         location.id
  json.locationName       location.name
  json.locationSlug       location.slug
  json.locationLat        location.lat
  json.locationLng        location.lng
end




json.venues @venues do |venue|
  json.venueID        venue.id
  json.venueUID       venue.uid
  json.venueName      venue.name
  json.venueSlug      venue.slug
  json.venueLat       venue.lat
  json.venueLng       venue.lng
  json.url venue_url(venue, format: :json)

end

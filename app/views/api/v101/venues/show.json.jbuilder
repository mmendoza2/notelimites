


json.venueID            @venue.id
json.venueUID           @venue.uid
json.venueName          @venue.name
json.slug               @venue.slug
json.description        @venue.description
json.lat                @venue.lat
json.lng                @venue.lng
json.city               @venue.city
json.imageURL           @venue.image
json.address            @venue.place
json.venueURLID         @venue.official_url

if params[:follower_id].blank?
  json.followed       "null"
else
  @user =  User.find(params[:follower_id])
  if @user.followingvenue?(@venue)
    json.followed       "true"
  else
    json.followed       "false"
  end
end

json.events             @venue.events.where('start_date > ?' , Date.today.to_time.in_time_zone("Central Time (US & Canada)") ) do |evento|
                        json.eventID        evento.id
                        json.eventName      evento.name
                        json.description    evento.description
                        json.init_date      evento.start_date
                        json.end_date       evento.end_date
                        json.ranking        evento.ranking
                        json.attendings     evento.attending_count
                        json.imageURL       evento.image
                        json.eventTypeID    evento.category_id
                        json.eventURLID     evento.official_url
                        json.ticketMaster   evento.tm
end



json.eventName      @event.name
json.eventSlug      @event.slug
json.description    @event.description
json.init_date      @event.start_date
json.end_date       @event.end_date
json.ranking        @event.ranking
json.attendings     @event.attending_count
json.venueID        @event.venue.id
json.venueName      @event.venue.name
json.imageURL       @event.image
json.eventtypeID    @event.category_id
json.eventURLID     @event.official_url
json.ticketMaster   @event.tm
json.placeLat       @event.venue.lat
json.placeLng       @event.venue.lng
json.eventID        @event.id
json.eventUID       @event.uid



if params[:follower_id].blank?
  json.followed       "null"
else
  @user =  User.find(params[:follower_id])
  if @user.followingevent?(@event)
    json.followed       "true"
  else
    json.followed       "false"
  end
end



json.venueEvents @venue_events do | event|
  json.eventName      event.name
  json.eventId        event.id
  json.imageURL       event.image
  json.eventSlug      event.slug

end



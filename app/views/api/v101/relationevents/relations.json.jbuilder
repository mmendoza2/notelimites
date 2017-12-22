

if params[:follower_id].blank?
  json.followed       "null"
else
  @user =  User.find(params[:follower_id])
  json.relationEvents Relationevent.where(:follower_id =>  params[:follower_id]).all do |relation|
    json.followed                    "true"
    json.relationEventID             relation.id
    json.eventID                     relation.followed_id
    @relationevent = Event.all.find(relation.followed_id)
    json.eventName      @relationevent.name
    json.eventSlug      @relationevent.slug
    json.description    @relationevent.description
    json.init_date      @relationevent.start_date
    json.end_date       @relationevent.end_date
    json.ranking        @relationevent.ranking
    json.attendings     @relationevent.attending_count
    json.venueID        @relationevent.venue.id
    json.imageURL       @relationevent.image
    json.eventtypeID    @relationevent.category_id
    json.eventURLID     @relationevent.official_url
    json.ticketMaster   @relationevent.tm
    json.placeLat       @relationevent.venue.lat
    json.placeLng       @relationevent.venue.lng
    json.venueName      @relationevent.venue.name
    json.eventID        @relationevent.id
    json.eventUID       @relationevent.uid
  end



end


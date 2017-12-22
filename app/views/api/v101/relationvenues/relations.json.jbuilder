

if params[:follower_id].blank?
  json.followed       "null"
else
  @user =  User.find(params[:follower_id])

  json.relationVenues Relationvenue.where(:follower_id =>  params[:follower_id]).all do |relation|
    json.followed       "true"
    json.relationVenueID             relation.id
    json.venueID                     relation.follower_id

    @relationvenue = Venue.find(relation.followed_id)
    json.venueName      @relationvenue.name
    json.venueSlug      @relationvenue.slug
    json.description    @relationvenue.description
    json.imageURL       @relationvenue.image
    json.venueURLID     @relationvenue.official_url
    json.placeLat       @relationvenue.lat
    json.placeLng       @relationvenue.lng
    json.venueID        @relationvenue.id
    json.venueUID       @relationvenue.uid
  end



end



json.events    @eventsjs do |event|
  json.eventID        event.id
  json.eventUID       event.uid
  json.eventName      event.name
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

latdown  = @location.lat.to_f - 0.2
latup    = @location.lat.to_f + 0.2
lngdown  = @location.lng.to_f - 0.2
lngup    = @location.lng.to_f + 0.2

latto0 = @location.lat.to_f - @location.lat.to_f
lngto0 = @location.lng.to_f - @location.lng.to_f

if params[:category_id] == "0"
  params[:category_id] = Category.select(:id).all
end

if params[:orderDate] == "true"
@events   = Event.joins(:venue).where(:venues => {:lat => [(latdown..latup)] } ).where(:venues => {:lng => [(lngup..lngdown)] } ).where(:category_id => params[:category_id]).where('start_date > ?' , Date.today.to_time.in_time_zone("Central Time (US & Canada)") ).order(:start_date => 'ASC').includes(:venue).includes(:followers)
elsif params[:orderAttending] == "true"
@events   = Event.joins(:venue).where(:venues => {:lat => [(latdown..latup)] } ).where(:venues => {:lng => [(lngup..lngdown)] } ).where(:category_id => params[:category_id]).where('start_date > ?' , Date.today.to_time.in_time_zone("Central Time (US & Canada)") ).order(:attending_count => 'ASC').includes(:venue).includes(:followers)
elsif params[:orderLatLng] == "true"
@events   = Event.joins(:venue).where(:venues => {:lat => [(latdown..latup)] } ).where(:venues => {:lng => [(lngup..lngdown)] } ).where(:category_id => params[:category_id]).where('start_date > ?' , Date.today.to_time.in_time_zone("Central Time (US & Canada)") ).order(:lat => 'ASC').includes(:venue).includes(:followers)
elsif params[:orderSupplier] == "true"
@events   = Event.joins(:venue).where(:venues => {:lat => [(latdown..latup)] } ).where(:venues => {:lng => [(lngup..lngdown)] } ).where(:supplier_id => params[:supplier_id]).where(:category_id => params[:category_id]).where('start_date > ?' , Date.today.to_time.in_time_zone("Central Time (US & Canada)") ).order(:start_date => 'ASC').includes(:venue).includes(:followers)
else
@events   = Event.joins(:venue).where(:venues => {:lat => [(latdown..latup)] } ).where(:venues => {:lng => [(lngup..lngdown)] } ).where('start_date > ?' , Date.today.to_time.in_time_zone("Central Time (US & Canada)") ).order(:start_date => 'ASC').includes(:venue).includes(:followers)
end
@eventsall     =   Event.joins(:venue).where(:venues => {:lat => [(latdown..latup)] } ).where(:venues => {:lng => [(lngup..lngdown)] } ).where('start_date > ?' , Date.today.to_time.in_time_zone("Central Time (US & Canada)") ).includes(:venue).includes(:followers)
@venuesall     =   Venue.select(:id, :name, :lat, :lng).where(:lat => [(latdown..latup)] ).where(:lng => [(lngup..lngdown)] ).joins(:events).where('start_date > ?' , Date.today.to_time.in_time_zone("Central Time (US & Canada)") )
@categoriesall =   Category.select(:id, :name).where(:id => 0).distinct.union_all(Category.select(:id, :name).joins(:events => [:venue ]).distinct.where(:venues => {:lat => [(latdown..latup)] } ).where(:venues => {:lng => [(lngup..lngdown)] } ).where('start_date > ?' , Date.today.to_time.in_time_zone("Central Time (US & Canada)") ).group(:id))

  json.locationID       @location.id
  json.locationName     @location.name
  json.locationLat      @location.lat
  json.locationLng      @location.lng
  json.locationSlug     @location.slug

json.categories  @categoriesall.each  do |venue|
  json.categoryName      venue.name
  json.categoryID     venue.id
end


json.venues  @venuesall.each  do |venue|
  json.venueName      venue.name
  json.venueID        venue.id
  json.venueLat       venue.lat
  json.venueLng       venue.lng
end


  json.events  @events.each do |event|
    json.locationName   @location.name
    json.eventName      event.name
    json.eventSlug      event.slug
    json.description    event.description
    json.init_date      event.start_date
    json.end_date       event.end_date
    json.ranking        event.ranking
    json.attendings     event.attending_count
    json.venueID        event.venue.id
    json.imageURL       event.image
    json.eventtypeID    event.category_id
    json.eventURLID     event.official_url
    json.ticketMaster   event.tm
    json.placeLat       event.venue.lat
    json.placeLng       event.venue.lng
    json.venueName      event.venue.name
    json.eventID        event.id
    json.eventUID       event.uid
    if params[:follower_id].blank?
      json.followed       "null"
    else
      @user =  User.find(params[:follower_id])
      if @user.followingevent?(event)
        json.followed       "true"
      else
        json.followed       "false"
      end
    end

  end
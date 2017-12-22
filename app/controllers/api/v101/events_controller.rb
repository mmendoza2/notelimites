module API::V101
  class EventsController <  API::BaseController

    # GET /events
    # GET /events.json
    def index
      @events = Event.search(params[:search]).where('start_date > ?' , Date.today.to_time.in_time_zone("Central Time (US & Canada)") ).order(:start_date)
      @eventsjs = Event.search(params[:search]).where('start_date > ?' , Date.today.to_time  ).all
    end

    # GET /events/1
    # GET /events/1.json
    def show
      @venues = Venue.all
      @event = Event.friendly.find(params[:id])
      latdown  = @event.venue.lat.to_f - 0.2
      latup    = @event.venue.lat.to_f + 0.2
      lngdown  = @event.venue.lng.to_f - 0.2
      lngup    = @event.venue.lng.to_f + 0.2
      @category_events   = Event.joins(:venue).where(:venues => {:lat => [(latdown..latup)] } ).where(:venues => {:lng => [(lngup..lngdown)] } ).where(:category_id => @event.category_id).where('start_date > ?' , Date.today.to_time.in_time_zone("Central Time (US & Canada)") ).all
      @venue_events = @event.venue.events.where('start_date > ?' , Date.today.to_time.in_time_zone("Central Time (US & Canada)")).order(:start_date).first(10)
      @events = Event.search(params[:search]).where('start_date > ?' , Date.today.to_time.in_time_zone("Central Time (US & Canada)") ).order(:start_date).first(10)



    end

  end
end

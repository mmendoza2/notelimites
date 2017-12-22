module API::V101
  class SearchController <  API::BaseController

      def index
        @locations = Location.search(params[:q]).where(:tm => 1).limit(6)
        @events = Event.search(params[:q]).where('start_date > ?' , Date.today.to_time ).limit(6)
        @venues = Venue.search(params[:q]).limit(5)
      end




  end
end
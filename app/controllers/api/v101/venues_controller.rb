module API::V101

    class VenuesController <  API::BaseController
      # GET /venues
      # GET /venues.json
      def index
        @venues = Venue.all
      end

      # GET /venues/1
      # GET /venues/1.json
      def show
        @venues = Venue.all
        @venue = Venue.friendly.find(params[:id])
      end
    end

end


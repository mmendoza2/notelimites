module API::V101
  class LocationsController <  API::BaseController
    skip_before_filter :verify_authenticity_token, :only => :create


    # GET /locations
    # GET /locations.json
    def index
      @locations = Location.where(:tm => params[:tm] ).all
    end

    # GET /locations/1
    # GET /locations/1.json    24.147584037802   'lat.to_d > ?', 25.666469523197
    def show
      @location = Location.friendly.find(params[:id])
      if signed_in?
        @user = current_user
      end
      UserMailer.location_email_api(@location, @user).deliver_now
    end

    def create

      loc = ActiveSupport::JSON.decode(open("https://maps.googleapis.com/maps/api/geocode/json?latlng=#{params[:lat]},#{params[:lng]}&key=AIzaSyClq051yZOiR1YEiaIRTuoi0I0gZgEWZKE").read)
      loc['results'].first(1).each do |x|
          unless x['address_components'].nil?
            if x['address_components'][4].nil?
              params[:location][:name]  = x['address_components'][3]['long_name']
              params[:location][:slug]  = x['address_components'][3]['long_name'].parameterize
            else
              params[:location][:name]  = x['address_components'][4]['long_name']
              params[:location][:slug]  = x['address_components'][4]['long_name'].parameterize
            end
          end
          params[:location][:supplier_id]  = 1
          @location = Location.friendly.find_or_create_by(location_params)
          respond_to do |format|
            if @location.save
              format.json { render action: 'show', location: @location, status: 201}
              # UserMailer.location_email_api(@location, @user).deliver
              # if signed_in?
              #  @user = current_user
              #  end
            else
              format.json { render json: @location.errors, status: 422}
            end
          end
      end
    end



    def location_params
      params.require(:location).permit(:name, :lat, :lng, :slug, :supplier_id )
    end
  end
end
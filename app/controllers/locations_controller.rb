class LocationsController < ApplicationController
  before_action :admin_user,     only: :destroy


  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json    24.147584037802   'lat.to_d > ?', 25.666469523197
  def show
    @eventsbuscar      = Event.search(params[:search]).where('start_date > ?' , Date.today.to_time.in_time_zone("Central Time (US & Canada)") ).order(:start_date => 'ASC')
    @location = Location.friendly.find(params[:id])
    latdown = @location.lat.to_f - 0.1
    latup = @location.lat.to_f + 0.1
    lngdown = @location.lng.to_f - 0.1
    lngup = @location.lng.to_f + 0.1

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
    @location = Location.friendly.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    if signed_in?
      @user = current_user
    end
    @location = Location.friendly.find_or_create_by(location_params)
    respond_to do |format|
      if @location.save
        format.html { redirect_to @location}
        format.json { render action: 'show', status: :created, location: @location }
        UserMailer.location_email(@location, @user).deliver_now
      else
        format.html { render action: 'new' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    @location = Location.friendly.find(params[:id])
    respond_to do |format|
      if   @location.update_attributes!(location_params)
        format.html { redirect_to @location, notice: 'location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name, :lat, :lng)
    end


end

class VenuesController < ApplicationController

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

  # GET /venues/new
  def new
    @venue = Venue.new
    @venue.images.build
  end

  # GET /venues/1/edit
  def edit
  end

  # POST /venues
  # POST /venues.json
  def create
     loc = ActiveSupport::JSON.decode(open("https://maps.googleapis.com/maps/api/geocode/json?address=#{params[:venue][:name].parameterize}&key=AIzaSyCxH3uvobKynTSs63CoAcTQSB0xzCRduCs").read)
     unless loc.blank?
       params[:venue][:lat] = loc['results'][0]['geometry']['location']['lat']
       params[:venue][:lng] = loc['results'][0]['geometry']['location']['lng']
       params[:venue][:slug] = params[:venue][:name].parameterize
       params[:venue][:official_url] = request.original_url
       params[:venue][:uid] = SecureRandom.hex(10)
       params[:venue][:supplier_id] = 3

       @venue = current_user.venues.build(venue_params)
       respond_to do |format|
         if @venue.save
           format.html { redirect_to @venue, notice: '¡El venue fue creado exitosamente!.' }
           format.json { render action: 'show', status: :created, location: @venue }
         else
           format.html { render action: 'new' }
           format.json { render json: @venue.errors, status: :unprocessable_entity }
         end
       end
     end
  end

  # PATCH/PUT /venues/1
  # PATCH/PUT /venues/1.json
  def update
    respond_to do |format|
      if @venue.update(venue_params)
        format.html { redirect_to @venue, notice: 'venue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to venues_url }
      format.json { head :no_content }
    end
  end





  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  def venue_params
    params.require(:venue).permit(:id, :name, :uid, :description, :lat, :lng, :slug, :official_url, :supplier_id, images_attributes: [ :photo])

  end



end


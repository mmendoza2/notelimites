class EventsController < ApplicationController

  # GET /events
  # GET /events.json
  # .where('start_date > ?' , Date.today.to_time.in_time_zone("Central Time (US & Canada)") )
  def index
    @events = Event.search(params[:search]).order(created_at: :desc)
    @eventsjs = Event.search(params[:search]).where('start_date > ?' , Date.today.to_time  ).all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @venues = Venue.all
    @event = Event.friendly.find(params[:id])
  end

  # GET /events/new
  def new
    @event = Event.new
    @event.images.build
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create

    params[:event][:uid]  = SecureRandom.hex(10)
    params[:event][:supplier_id]  = 3
    params[:event][:official_url] = request.original_url
    @event = current_user.events.build(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    Event.friendly.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end



  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params[:event].permit(:name, :uid, :description,  :start_date,  :official_url, :venue_id, :category_id, :end_date, :supplier_id, :official_url, images_attributes: [ :photo])
  end




end

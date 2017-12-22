class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  # GET /actividades
  # GET /actividades.json
  def index
    @categories = Category.all
    @categories1 = Category.all
  end

  # GET /actividades/1
  # GET /actividades/1.json
  def show
    @category = Category.find(params[:id])
    @categories = Category.all
    @events = Event.all
    @venues = Venue.all
  end

  # GET /actividades/new
  def new
    @category = Category.new
  end

  # GET /actividades/1/edit
  def edit

  end

  # POST /actividades
  # POST /actividades.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Actividad was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /actividades/1
  # PATCH/PUT /actividades/1.json
  def update
    @category = Category.find(params[:id])
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Actividad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actividades/1
  # DELETE /actividades/1.json
  def destroy
    Category.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params[:category].permit(:name, :photo)
    end
end

class AgenciesController < ApplicationController
  before_action :set_agencie, only: [:show, :edit, :update, :destroy]

  # GET /agencias
  # GET /agencias.json
  def index
    @agencies = Agencie.search(params[:search])
    @agencie = Agencie.new
  end

  # GET /agencias/1
  # GET /agencias/1.json
  def show
  end

  def venuesTM
  end

  # GET /agencias/new
  def new
    @agencie = Agencie.new
  end

  # GET /agencias/1/edit
  def edit
  end

  # POST /agencias
  # POST /agencias.json
  def create
    params[:agencie][:name] = params[:agencie][:name][25...params[:agencie][:name].length].gsub(/\//, '')
    @agencie = Agencie.find_or_create_by(agencia_params)
    respond_to do |format|
      if @agencie.save
        format.html { redirect_to @agencie, notice: 'Agencia was successfully created.' }
        format.json { render action: 'show', status: :created, location: @agencie }

      else
        format.html { render action: 'new' }
        format.json { render json: @agencie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agencias/1
  # PATCH/PUT /agencias/1.json
  def update
    respond_to do |format|
      if @agencie.update(agencia_params)
        format.html { redirect_to @agencie, notice: 'Agencia was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @agencie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agencias/1
  # DELETE /agencias/1.json
  def destroy
    @agencie.destroy
    respond_to do |format|
      format.html { redirect_to agencies_url }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agencie
      @agencie = Agencie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agencia_params
      params[:agencie].permit(:name )
    end
end

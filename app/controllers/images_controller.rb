class ImagesController < InheritedResources::Base

  def show
    @image =  Image.find(params[:id])
  end


  def new
    @image = Image.new
  end

  def create
    @image = current_user.images.build(image_params)
    if @image.save
      flash[:success] = "The photo was added!"
      redirect_to @image
    else
      render 'new'
    end
  end

  private

    def image_params
      params.require(:image).permit(:photo)
    end
end


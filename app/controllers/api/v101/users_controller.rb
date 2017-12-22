module API::V101
  class UsersController <  API::BaseController
    skip_before_filter :verify_authenticity_token, :only => :create

    def show
      @user = User.friendly.find(params[:id])
      @events = @user.events.paginate(page: params[:page])
    end

    def index
      @users = User.all
    end

    def create
      @user = User.friendly.find_or_create_by(user_params)
      respond_to do |format|
        if @user.save
          format.json { render action: 'show', status: :created, user: @user }
          UserMailer.login_email_api(@user).deliver_now
        else
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def user_params
      params.require(:user).permit(:name, :locale, :email, :image)
    end

  end
end


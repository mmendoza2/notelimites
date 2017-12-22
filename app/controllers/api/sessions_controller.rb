class API::SessionsController < Devise::SessionsController
  before_filter :authenticate_user!, :except => [:create]
  before_filter :ensure_params_exist, :except => [:destroy]
  respond_to :json


  def new
    resource = User.find_for_database_authentication(:email => params[:email])
    return invalid_login_attempt unless resource
    if resource.valid_password?(params[:password])
      sign_in(:user, resource)
      if resource.auth_token.blank?
        resource.auth_token = generate_authentication_token
      end
      resource.save
      render :json=> {:auth_token=>resource.auth_token, :email=>resource.email}, :status => :ok
      return
    end
    invalid_login_attempt
  end


  def destroy
    resource = User.find_by_auth_token(params[:auth_token]||request.headers["X-AUTH-TOKEN"])
    resource.auth_token = nil
    resource.save
    sign_out(resource_name)
    render :json => {}.to_json, :status => :ok
  end



  protected
  def ensure_params_exist
    return unless params[:email].blank?
    render :json=>{:message=>"missing user_login parameter"}, :status=>422
  end

  def invalid_login_attempt
    render :json=> {:message=>"Error with your login or password"}, :status=>401
  end



  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(auth_token: token).first
    end
  end
end




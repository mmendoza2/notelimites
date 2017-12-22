class API::BaseController < InheritedResources::Base
  before_action :authenticate
  prepend_before_filter :get_auth_token

  respond_to :xml, :json


  def authenticate

    if params[:auth_token]
      @user = User.find_by(auth_token: params[:auth_token])
      if @user.nil?
        render :json => { error: 'login user by token failed', status: 404},  status: 404
        return
      else

      end
    else
      render :json => { error: 'token not found', status: 404},  status: 404
    end


  end


  private
  def get_auth_token
    if auth_token = params[:auth_token].blank? && request.headers["X-AUTH-TOKEN"]
      params[:auth_token] = auth_token
    end
  end


end
class InfoController < ApplicationController
  def terminos
  end
  def analytics
    @user = User.find(current_user.id)
  end
  def robots
    render 'info/robots', layout: false, content_type: 'text/plain'
    expires_in 6.hours, public: true
  end
end
class OmniauthCallbacksController < DeviseController


  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice ="Bienvenido!"
      UserMailer.login_email(user).deliver
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end
  alias_method :facebook, :all


  prepend_before_filter { request.env["devise.skip_timeout"] = true }

  def passthru
    render :status => 404, :text => "Not found. Authentication passthru."
  end

  def failure
    set_flash_message :alert, :failure, :kind => OmniAuth::Utils.camelize(failed_strategy.name), :reason => failure_message
    redirect_to after_omniauth_failure_path_for(resource_name)
  end




  protected

  def failed_strategy
    env["omniauth.error.strategy"]
  end

  def failure_message
    exception = env["omniauth.error"]
    error   = exception.error_reason if exception.respond_to?(:error_reason)
    error ||= exception.error        if exception.respond_to?(:error)
    error ||= env["omniauth.error.type"].to_s
    error.to_s.humanize if error
  end

  def after_omniauth_failure_path_for(scope)
    new_session_path(scope)
  end
end

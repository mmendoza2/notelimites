class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :check_domain
  before_action :set_locale

  def set_locale
    I18n.locale = extract_locale_from_subdomain || I18n.default_locale
  end


  # Get locale code from request subdomain (like http://it.application.local:3000)
  # You have to put something like:
  #   127.0.0.1 gr.application.local
  # in your /etc/hosts file to try this out locally
  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end


  def check_domain
    if Rails.env.production? and request.host.downcase == 'api.notelimites.com'
    elsif Rails.env.production? and request.host.downcase == 'es.notelimites.com'
    elsif Rails.env.production? and request.host.downcase == 'en.notelimites.com'
    elsif Rails.env.production? and request.host.downcase != 'www.notelimites.com'
      redirect_to  'https://www.notelimites.com' + request.fullpath, :status => 301
    end
  end

  def after_sign_in_path_for(resource)
    @user ||= current_user
   root_path
  end

  protected

  def configure_permitted_parameters

  end
end

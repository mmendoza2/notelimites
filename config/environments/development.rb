NoTeLimites::Application.configure do

  Paperclip.options[:command_path] = 'C:\Program Files\ImageMagick-7.0.4-Q16'
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  config.assets.debug = true

  # mailer config
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :domain               => 'notelimites.com',
      :user_name            => 'ntl@notelimites.com',
      :password             => 'NTL12wolmen',
      :authentication       => 'plain',
      :enable_starttls_auto => true  }

  # Specify what domain to use for mailer URLs
  config.action_mailer.default_url_options = {host: 'notelimites.com'}


  config.paperclip_defaults = {
      :storage => :s3,
      :s3_region => ENV['AWS_REGION'],
      :s3_credentials => {
          :bucket => ENV['AWS_BUCKET'],
          :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
          :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
      }
  }


  CarrierWave.configure do |config|
    config.cache_dir = "#{Rails.root}/tmp/"
    config.storage = :fog
    config.permissions = 0666
    config.fog_credentials = {
        :provider               => 'AWS',
        :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
        :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
    }
    config.fog_directory  = ENV['AWS_BUCKET']
  end



end

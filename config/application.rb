require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(*Rails.groups(assets: %w(development test)))

module NoTeLimites
  class Application < Rails::Application



    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es
    config.i18n.available_locales = :en, :es
    config.active_job.queue_adapter = :delayed_job
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    config.active_record.raise_in_transactional_callbacks = true


     if Rails.env.development?
       config.action_dispatch.default_headers = {

       }

       env_file = File.join(Rails.root, 'config', 'local_env.yml')
       YAML.load(File.open(env_file)).each do |key, value|
         ENV[key.to_s] = value
       end if File.exists?(env_file)
     end



  end
end

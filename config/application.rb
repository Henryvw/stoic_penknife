require File.expand_path('boot', __dir__)

require 'rails/all'
# config.action_mailer.raise_delivery_errors = true

# config.action_mailer.delivery_method = :smtp

# config.action_mailer.smtp_settings = {
# address: "smtp.gmail.com",
# port: 587,
# domain: ENV["GMAIL_DOMAIN"],
# authentication: "plain",
# enable_starttls_auto: true,
# user_name: ENV["GMAIL_USERNAME"],
# password: ENV["GMAIL_PASSWORD"]
# }

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module StoicPenknife
  class Application < Rails::Application
    config.assets.paths << "#{Rails}/vendor/assets/fonts"
    # config.time_zone = Time.now.zone
    # I was trying to make a fancy local time zone for you as a user. I think I might need to add a time zone column to the user database and do various other detailed things in order for local times to be saved and stored and accessible. What appears to be a good resource, https://robots.thoughtbot.com/its-about-time-zones

    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: true,
                       request_specs: false
      g.fixture_question :factory_bot, dir: 'spec/factores'
    end
    
    config.active_storage.service = :local
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end

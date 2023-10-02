require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NotificationsMs
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # config.before_configuration do
    #   env_file = File.join(Rails.root, 'config', 'local_env.yml')
    #   YAML.load(File.open(env_file)).each do |key, value|
    #     ENV[key.to_s] = value
    #   end if File.exist?(env_file)
    # end

    Dotenv::Railtie.load

    # Configure Mailer
    # config.action_mailer.delivery_method = :smtp
    # config.action_mailer.smtp_settings = {
    #   address: ENV['MAILER_ADDRESS'],
    #   port: ENV['MAILER_PORT'],
    #   domain: ENV['MAILER_DOMAIN'],
    #   user_name: ENV['MAILER_USER_NAME'],
    #   password: ENV['MAILER_PASSWORD'],
    #   authentication: ENV['MAILER_AUTHENTICATION'],
    #   enable_starttls_auto: ENV['MAILER_ENABLE_STARTTLS_AUTO']
    # }

    # Configure SMTP Service
    require 'sib-api-v3-sdk'

    SibApiV3Sdk.configure do | conf | 
      conf.api_key['api-key'] = ENV['SMTP_API_KEY']
    end
    
  end
end

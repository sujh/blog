require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Blog
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.time_zone = 'Beijing'
    config.active_record.default_timezone = :local
    config.cache_store = :redis_store, {
      host: 'localhost',
      port: 6379,
      db: 0,
      namespace: '_blog'
    }, {
      expires_in: 1.day
    }

    config.before_configuration do
      env_file = File.join(Rails.root, '.env')
      File.open(env_file).each_line do |line|
        k, v = line.chomp.split('=')
        ENV[k] = v
      end if File.exists?(env_file)
    end

  end
end

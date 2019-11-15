require 'sidekiq/web'

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{Rails.application.config_for(:application).dig('redis', 'host')}:6379/#{Rails.application.config_for(:application).dig('redis', 'sidekiq_db')}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{Rails.application.config_for(:application).dig('redis', 'host')}:6379/#{Rails.application.config_for(:application).dig('redis', 'sidekiq_db')}" }
end

if Rails.env.production?
  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == Rails.application.credentials.sidekiq_console.values_at(:user, :pass)
  end
end
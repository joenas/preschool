require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.set :session_secret, Rails.application.credentials[:secret_key_base]

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
 username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
end if Rails.env.production?


Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_PROVIDER']}
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_PROVIDER']}
end

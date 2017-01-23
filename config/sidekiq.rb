require 'sidekiq'
require 'sidekiq/web'

# https://github.com/mperham/sidekiq/pull/2462
# https://github.com/mperham/sidekiq/issues/2555#issuecomment-185425059
# We dont need sessions and I couldn't get them to work, tried these settings:
# https://github.com/redis-store/redis-rails/issues/34#issuecomment-22841070
# https://github.com/mperham/sidekiq/wiki/Monitoring#forbidden
Sidekiq::Web.class_eval do
  disable :sessions
end

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
 username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
end if Rails.env.production?

require 'sidekiq-status'

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_PROVIDER']}

  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_PROVIDER']}

  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes # default
  end
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
end

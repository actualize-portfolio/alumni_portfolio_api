# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_interslice_session'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  secure_compare(username, ENV.fetch('SIDEKIQ_USERNAME', nil)) &
    secure_compare(password, ENV.fetch('SIDEKIQ_PASSWORD', nil))
end

def secure_compare(supplied_string, comparison_string)
  ActiveSupport::SecurityUtils.secure_compare(supplied_string, comparison_string)
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1') }
end

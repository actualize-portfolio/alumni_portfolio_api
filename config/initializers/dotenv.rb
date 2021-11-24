# frozen_string_literal: true

Dotenv.require_keys(
  'GITHUB_API_TOKEN',
  'GITHUB_USERNAME',
  'RAILS_MASTER_KEY',
  'SENTRY_DSN',
  'SIDEKIQ_PASSWORD',
  'SIDEKIQ_USERNAME'
)

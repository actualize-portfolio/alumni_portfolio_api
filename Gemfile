# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 7.0.3.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 5.6'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Handle concurrent 3rd party API requests
gem 'concurrent-ruby', '~> 1.1.9'

# Document storage
gem 'cloudinary'

# Manage ENV Variables
gem 'dotenv-rails'

# Use Faraday for HTTP Requests
gem 'faraday', '~> 2.5.2'

# Geocoder for location
gem 'geocoder', '~> 1.8.0'

# Pagination
gem 'kaminari'

# Use Nokogiri for HTML Scraping
gem 'nokogiri'

# Use open-uri for loading pages for scraper
gem 'open-uri'

# RSwag for API Documentation
gem 'rswag-api'
gem 'rswag-ui'

# Sentry error alerting
gem 'sentry-rails'
gem 'sentry-ruby'
gem 'sentry-sidekiq'

# Sidekiq for async jobs
gem 'sidekiq'
gem 'sidekiq-scheduler'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '~> 1.1.1'

# Use JSON Web Tokens
gem 'jwt', '~> 2.5.0'

gem 'active_model_serializers'

gem 'interactor-rails', '~> 2.0'

group :development, :test do
  gem 'bundler-audit'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'rspec-rails'
  gem 'rswag-specs'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'fakeredis', require: 'fakeredis/rspec'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', require: false
  gem 'vcr'
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

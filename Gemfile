# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3'

gem 'pg', '~> 1.1'

# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

gem 'httparty', '>= 0.18.1'
gem 'oj', '~> 3.9.2'
gem 'pry-rails'

# allow for some background jobs
gem 'sidekiq'

# so we can fetch new data from time to time
gem 'sidekiq-cron', '~> 1.2'

gem 'foreman'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner', '~> 2.0'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'rspec-rails', '~> 5.0'
  gem 'sinatra'
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rubocop-rails', require: false
  gem 'spring'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'mock_redis'
  gem 'rspec-sidekiq'
  gem 'shoulda-matchers', require: false
  gem 'spring-commands-rspec'
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

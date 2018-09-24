source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby '2.4.3'
gem 'rails', '5.0.1'
gem 'rails_12factor', group: :production
gem 'puma', '~> 3.6', '>= 3.6.2'
gem 'rack-cache', '~> 1.7'

# Database
gem 'pg', '~> 0.19.0'
gem 'enumerize', '~> 2.0', '>= 2.0.1'

# Errors
gem "sentry-raven"

# Assets and whatnot
gem 'haml-rails', '~> 0.9.0'
gem 'bootstrap', '~> 4.1', '>= 4.1.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2', '>= 4.2.1'
gem 'mini_racer', '~> 0.2.0'
gem 'jquery-rails'
#gem 'turbolinks'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.1'
gem 'best_in_place', '~> 3.0.1'
gem 'tether-rails'

# App configuration
gem 'dotenv-rails', '~> 2.1', '>= 2.1.2'

# Background jobs
gem 'sinatra', '~> 2.0.0.beta2'
gem 'sidekiq', '~> 4.2', '>= 4.2.9'
gem 'clockwork', '~> 2.0'

# Http
gem 'faraday', '~> 0.11.0'
gem 'faraday_middleware', '~> 0.11.0.1'

# Forms
gem 'simple_form', '~> 3.4'

# NLP
#gem 'classifier-reborn', '~> 2.1'
gem 'classifier-reborn', git: 'https://github.com/jekyll/classifier-reborn'

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'lol_dba'
end

group :development do
  gem 'better_errors'
  # https://github.com/heroku/heroku-buildpack-ruby/pull/531
  #gem 'binding_of_caller', :platforms=>[:mri_24]
  gem 'guard', '~> 2.11'
  gem 'guard-rspec', '~> 4.7', '>= 4.7.2'
  gem 'listen', '3.0.5'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'awesome_print', '~> 1.7'
end

group :test do
  gem 'database_cleaner', '~> 1.5.3'
  gem 'rspec-rails', '~> 3.5', '>= 3.5.2'
  gem 'rspec-collection_matchers', '~> 1.1.2' # may be removed with a few spec fixes
  gem 'rspec-given', '~> 3.8'
  gem 'rspec-mocks', '~> 3.5.0'
  gem 'shoulda-matchers', '~> 3.1.1'
  gem 'webmock', '~> 3.0', '>= 3.0.1'
end


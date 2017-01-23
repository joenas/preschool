source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby '2.4.0'
gem 'rails', '5.0.1'

gem 'pg', '~> 0.19.0'

# Use SCSS for stylesheets
# Assets and whatnot
gem 'haml-rails', '~> 0.9.0'
gem 'bootstrap', '~> 4.0.0.alpha3.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2', '>= 4.2.1'
gem 'therubyracer', '~> 0.12.1', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'

# App configuration
gem 'dotenv-rails', '~> 2.1', '>= 2.1.2'

# Background jobs
gem 'sinatra', '~> 2.0.0.beta2'
gem 'sidekiq', '~> 4.2', '>= 4.2.9'
gem 'clockwork', '~> 2.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_21]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'html2haml'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'spring-commands-rspec'
  gem 'guard', '~> 2.11'
  gem 'listen', '3.0.5'
  gem 'guard-rspec', '~> 4.7', '>= 4.7.2'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'pry-rescue'
end

group :test do
  gem 'database_cleaner', '~> 1.5.3'
  gem 'rspec-rails', '~> 3.5.0'
  gem 'rspec-collection_matchers', '~> 1.1.2' # may be removed with a few spec fixes
  gem 'rspec-given', '~> 3.8.0'
  gem 'rspec-mocks', '~> 3.5.0'
  gem 'shoulda-matchers', '~> 3.1.1'
end


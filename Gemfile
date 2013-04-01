source 'https://rubygems.org'
ruby "2.0.0"

gem 'rails',     github: 'rails/rails'
gem 'arel',      github: 'rails/arel'
gem "thin"
gem "decent_exposure"

# Security
gem 'cancan', github: "ryanb/cancan", branch: "2.0"
gem 'omniauth'
gem 'omniauth-twitter'
gem "rack-cors", require: 'rack/cors'
gem "honeybadger"

# Db
gem 'activerecord-deprecated_finders', github: 'rails/activerecord-deprecated_finders'
gem "mongoid", github: "mongoid/mongoid"

# View
gem "sass", "3.3.0.alpha.103"
gem 'sass-rails', github: 'rails/sass-rails'
gem "haml", "4.0.1.rc.1"
gem "haml-rails"
gem 'simple_form', github: "plataformatec/simple_form"

# File upload
gem 'rmagick'
gem 'carrierwave'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'

group :assets do
  gem 'sprockets-rails', github: 'rails/sprockets-rails'
  gem 'coffee-rails', github: 'rails/coffee-rails'
  gem 'uglifier'
  gem 'bootstrap-sass'
  gem 'font-awesome-sass-rails'
  gem 'html5shiv-rails'
  gem "jquery-rails"
  gem 'asset_sync'
end

group :test, :development do
  gem 'bundler'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'faker'
  gem "spork", github: "sporkrb/spork"
  gem 'rspec-rails'
  gem 'guard-rails'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'mongoid-rspec'
  gem 'factory_girl_rails'
  gem 'foreman'
  gem 'capybara'
  gem 'mailcatcher'
  gem 'rb-fsevent'
  gem 'growl'
  gem 'rack_session_access'
  gem 'email_spec'
  gem "dotenv"
  gem 'quiet_assets'
end

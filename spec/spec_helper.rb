require 'rubygems'
require 'spork'
require 'database_cleaner'

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec'

  Capybara.javascript_driver = :webkit#_debug

  # Sets omniauth into test mode
  OmniAuth.config.test_mode = true

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.filter_run focus: true
    config.run_all_when_everything_filtered = true
    config.infer_base_class_for_anonymous_controllers = false

    config.order = "random"

    config.include FactoryGirl::Syntax::Methods

    config.include Mongoid::Matchers

    config.include EmailSpec::Helpers
    config.include EmailSpec::Matchers

    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
end

Spork.each_run do
  FactoryGirl.reload
  DatabaseCleaner.clean
  Rails.application.reload_routes!
end

require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "rack/cors"
require 'digest/md5'
# require "rails/test_unit/railtie"

# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(*Rails.groups(assets: %w(development test)))

module Chronicles
  class Application < Rails::Application

    # Timezone
    config.time_zone = 'Europe/Copenhagen'

    # Default locale
    config.i18n.default_locale = :en
    config.i18n.locale = :en

    # Default encoding
    config.encoding = "utf-8"

    # Filter params
    config.filter_parameters += [:password]

    # Don't use root json object
    config.active_support.escape_html_entities_in_json = true

    # Additional asset paths
    config.assets.paths << "#{Rails.root}/app/assets/fonts"

    # Generators
    config.generators do |g|
      g.assets false
      g.helper false
      g.template_engine :haml
      g.view_specs false
      g.helper_specs false
      g.controller_specs false
      g.test_framework :rspec, :fixture => true, :views => false
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end

    # Enable CORS
    # Uncommenting this allows you to specify various resources that's allowed
    # to reach the site from another domain.
    #
    # config.middleware.use Rack::Cors do
    #   allow do
    #     origins '*'
    #     resource '*', :headers => :any, :methods => [:get, :post, :options]
    #   end
    # end
  end
end

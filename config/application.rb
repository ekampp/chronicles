require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "rack/cors"
require 'digest/md5'
require "bootstrap-sass"
require "jquery-rails"
require "asset_sync"
require "font-awesome-sass-rails"
require "bootstrap-sass"
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
    config.i18n.available_locales = [ :en ]

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
      g.test_framework :rspec, :fixture => true, :views => false
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end

    # Disable Rails's static asset server (Apache or nginx will already do this).
    config.serve_static_assets = false

    # Compress JavaScripts and CSS.
    config.assets.js_compressor  = :uglifier
    config.assets.css_compressor = :sass

    # Whether to fallback to assets pipeline if a precompiled asset is missed.
    config.assets.compile = true

    # Generate digests for assets URLs.
    config.assets.digest = true

    # Enable assets for asset_sync
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets.
    config.assets.version = '1.0'

    # Nest assets under the environment
    config.assets.prefix = "/assets"
  end
end

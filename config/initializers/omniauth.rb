require 'omniauth'
require 'omniauth-twitter'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, ENV['TWITTER_ID'], ENV['TWITTER_SECRET']
end

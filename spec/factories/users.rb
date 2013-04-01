# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    uid "123545"
    provider "twitter"
    role :user
    session_token SecureRandom.urlsafe_base64

    trait :mock_twitter do
      after :build do |u|
        OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
          :provider => u.provider,
          :uid => u.uid,
          info: { name: u.name }
        })
      end
    end

    trait :email do
      after :build do |u|
        u.email = Faker::Internet.email
      end
    end
  end
end

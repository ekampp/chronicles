# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    uid { Faker::Base.numerify "#######" }
    provider "twitter"
    role "user"
    session_id { SecureRandom.urlsafe_base64 }
    age 16
    locale "en"

    trait :mock_omniauth do
      after :build do |u|
        OmniAuth.config.mock_auth[u.provider.to_sym] = OmniAuth::AuthHash.new \
          provider: u.provider,
          uid: u.uid,
          info: { name: u.name },
          credentials: { token: u.token }
      end
    end

    trait :with_characters do
      after :create do |u|
        create :character, user: u
        create :character, user: u
        u = u.reload
      end
    end
  end
end

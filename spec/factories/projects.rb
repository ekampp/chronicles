# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name { Faker::Company.name }
    summary { Faker::Lorem.sentences.sample }
    description { Faker::Lorem.paragraphs.sample }
    url { Faker::Internet.url }
  end
end

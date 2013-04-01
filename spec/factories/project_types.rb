# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_type do
    name { Faker::Name.name }
    key { Faker::Internet.domain_word }
  end
end

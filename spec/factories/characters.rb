# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :character do
    name { Faker::Name.name }
    user nil
  end
end

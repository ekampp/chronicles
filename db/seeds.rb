# Users
emil = FactoryGirl.build :user,
  name: "Emil Kampp",
  uid: 25993233,
  provider: "twitter",
  role: :admin,
  email: nil
emil.save validation: false
other_user = FactoryGirl.create :user,
  name: "Emil Kampp",
  uid: 25993233,
  provider: "twitter",
  role: :admin

FactoryGirl.create :character, user: emil
FactoryGirl.create :character, user: emil
FactoryGirl.create :character, user: other_user
FactoryGirl.create :character, user: other_user

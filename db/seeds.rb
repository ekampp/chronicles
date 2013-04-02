# Users
emil = FactoryGirl.build :user,
  name: "Emil Kampp",
  uid: 25993233,
  provider: "twitter",
  role: :admin,
  email: nil
emil.save validation: false

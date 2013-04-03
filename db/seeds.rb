# Create admin and real users
users = []
users << FactoryGirl.create(:user,
  name: "Emil Kampp",
  uid: 25993233,
  provider: "twitter",
  role: :admin,
  email: "emil@kampp.me"
)

# Create characters
users.each do |user|
  FactoryGirl.create(:character, user: user)
end

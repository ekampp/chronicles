# Users
emil = FactoryGirl.create :user,
  name: "Emil Kampp",
  uid: 25993233,
  provider: "twitter",
  role: :admin

# Project types
api = FactoryGirl.create :project_type,
  key: "api",
  name: "API"
web = FactoryGirl.create :project_type,
  key: "web",
  name: "Full stack"
spa = FactoryGirl.create :project_type,
  key: "spa",
  name: "Single page app"

# Projects
file_path = "#{Rails.root}/app/assets/images/photos"
fakta = FactoryGirl.create :project,
  project_types: [ api, web ],
  name: "Fakta",
  summary: "Mit fakta's API",
  avatar: File.open("#{file_path}/fakta.jpg")
scholastic = FactoryGirl.create :project,
  project_types: [ web ],
  name: "Scholastic",
  summary: "We moved their search engine from Google Search Appliances to Apache Solr.",
  avatar: File.open("#{file_path}/scholastic.jpg")
milestone = FactoryGirl.create :project,
  project_types: [ web, spa, api ],
  name: "MilestoneSelling",
  summary: "We have been depply involved in developing key features and calculations for this sales tool.",
  avatar: File.open("#{file_path}/milestone.jpg")

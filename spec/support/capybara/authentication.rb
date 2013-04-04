shared_context :capybara_sign_in do
  before do
    user # invoke the user
    visit sign_in_path
    click_link "twitter_sign_in"
  end
end

require "spec_helper"

describe "Vistiting landing page" do
  before{ visit root_path }

  describe "page content" do
    subject{ page }

    # General content
    it { should have_content "Kampp Media" }
  end
end

describe "Sign in" do
  before do
    visit root_path
    click_link "sign_in"
  end

  describe "resulting location" do
    it { current_path.should eq sign_in_path }
  end
end

describe "User options" do
  before do
    @user = create :user, :mock_twitter
    visit sign_in_path
    click_link "twitter"
    visit root_path
  end

  it "should have a link to the user's profile" do
    page.should have_selector "a[href='#{edit_user_path}']", text: @user.name
  end
end

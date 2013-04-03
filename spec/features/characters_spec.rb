require "spec_helper"

describe "Listing characters" do
  let(:user) { create :user, :with_characters, :mock_omniauth }
  let(:other_user) { create :user, :with_characters }

  before do
    user # invoke the user
    visit sign_in_path
    click_link "twitter_sign_in"
    visit characters_path
  end

  describe "page" do
    subject{ page }

    it { should have_content I18n.translate("characters.index.title") }
    it "should have all the user's characters" do
      user.characters.each do |character|
        should have_content character.name
      end
    end
  end
end

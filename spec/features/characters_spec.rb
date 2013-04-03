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
        should have_css "a[href='#{edit_character_path(character)}']"
      end
    end
  end
end

describe "Editing a character" do
  let(:user) { create :user, :with_characters, :mock_omniauth }
  let(:other_user) { create :user, :with_characters }
  let(:character) { user.characters.sample }

  before do
    user # invoke the user
    visit sign_in_path
    click_link "twitter_sign_in"
    visit edit_character_path(character)
  end

  describe "page" do
    subject{ page }
    it { should have_content I18n.translate("characters.edit.title", name: character.name) }
  end

  describe "submitting the form" do
    let(:atrs) { attributes_for :character }
    before do
      within "#edit_character_#{character.id}" do
        fill_in "character_name", with: atrs[:name]
        click_button "commit"
      end
    end

    describe "page" do
      subject{ page }
      it { should have_content I18n.translate("flash.characters.update.notice") }
    end

    describe "location" do
      subject{ current_path }
      it { should eq edit_character_path(character) }
    end
  end
end

describe "Creating a new character" do
  let(:user) { create :user, :with_characters, :mock_omniauth }
  let(:other_user) { create :user, :with_characters }
  let(:atrs) { attributes_for :character }

  before do
    user # invoke the user
    visit sign_in_path
    click_link "twitter_sign_in"
    visit characters_path
    click_link I18n.translate("characters.index.new_character")
  end

  it { current_path.should eq new_character_path }
  it { page.should have_content I18n.translate("characters.new.title") }
  it { page.should have_content I18n.translate("characters.new.lead") }

  context "filling in the form" do
    before do
      within "#new_character" do
        fill_in "character_name", with: atrs[:name]
        click_button "commit"
      end
    end

    it { current_path.should match /\A\/characters\/.{24}\/edit\z/ }
    it { page.should have_content I18n.translate("flash.characters.create.notice") }
  end
end

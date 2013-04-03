require "spec_helper"

describe "Listing characters" do
  let(:user) { create :user, :with_characters, :mock_omniauth }
  let(:other_user) { create :user, :with_characters }
  include_context :capybara_sign_in

  before do
    visit characters_path
  end

  it { page.should have_content I18n.translate("characters.index.title") }
  it "should have all the user's characters" do
    user.characters.each do |character|
      page.should have_content character.name
      page.should have_css "a[href='#{edit_character_path(character)}']"
    end
  end
end

describe "Editing a character" do
  let(:user) { create :user, :with_characters, :mock_omniauth }
  let(:other_user) { create :user, :with_characters }
  let(:character) { user.characters.sample }
  include_context :capybara_sign_in

  before do
    visit edit_character_path(character)
  end

  it { page.should have_content I18n.translate("characters.edit.title", name: character.name) }

  describe "submitting the form" do
    let(:atrs) { attributes_for :character }
    before do
      within "#edit_character_#{character.id}" do
        fill_in "character_name", with: atrs[:name]
        click_button "commit"
      end
    end

    it { page.should have_content I18n.translate("flash.characters.update.notice") }
    it { current_path.should eq edit_character_path(character) }
  end
end

describe "Creating a new character" do
  let(:user) { create :user, :with_characters, :mock_omniauth }
  let(:other_user) { create :user, :with_characters }
  let(:atrs) { attributes_for :character }
  include_context :capybara_sign_in

  before do
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

describe "Deleting a character" do
  let(:user) { create :user, :with_characters, :mock_omniauth }
  let(:other_user) { create :user, :with_characters }
  let(:character) { user.characters.sample }
  include_context :capybara_sign_in

  before do
    visit edit_character_path(character)
    click_link I18n.translate("characters.form.delete")
  end

  it { current_path.should eq characters_path }
  it { page.should have_content I18n.translate("flash.characters.destroy.notice") }
  it { page.should_not have_content character.name }
end

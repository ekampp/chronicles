require "spec_helper"

describe "Edit profile" do
  context "signed in" do
    let(:user) { create :user }
    include_context :sign_in
    before{ visit edit_user_path }

    it { page.should have_content I18n.translate("user.edit.title") }

    describe "sign up for newsletter" do
      before do
        check "user_receive_newsletter"
        click_button "commit"
      end

      it { page.should have_css "input#user_receive_newsletter[type='checkbox'][checked='checked']" }
      it_should_behave_like :user_updated_correctly
    end

    describe "update email" do
      let(:email) { Faker::Internet.email }
      before do
        fill_in "user_email", with: email
        click_button "commit"
      end

      it { find_field("user_email").value.should eq email }
      it_should_behave_like :user_updated_correctly
    end
  end

  context "signed out" do
    before{ visit edit_user_path }
    it { current_path.should eq root_path }
    it { page.should have_content I18n.translate("application.render_401.rescued") }
  end
end

describe "Signing out" do
  let(:user) { create :user }
  include_context :sign_in
  before do
    visit edit_user_path
    click_link "sign_out"
  end

  it_should_behave_like :redirect_to_sign_out
end

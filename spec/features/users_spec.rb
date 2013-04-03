require "spec_helper"

describe "Sign in with twitter" do
  let(:user) { build :user, :mock_omniauth }

  context "without an existing user" do
    include_context :capybara_sign_in
    it { page.should have_content I18n.translate("flash.sessions.create.missing_information") }
  end

  context "with an existing user" do
    before{ user.save }
    include_context :capybara_sign_in
    it { page.should have_content I18n.translate("flash.sessions.create.success") }
  end
end

describe "Update settings" do
  let(:user) { user = create :user, :mock_omniauth }

  context "when logged in" do
    include_context :capybara_sign_in
    before { visit edit_user_path(user) }

    context "fill in email" do
      let(:atrs) { attributes_for :user }
      before do
        within "#edit_user_#{user.id}" do
          fill_in "user_email", with: atrs[:email]
          click_button "commit"
        end
      end

      describe "page" do
        subject{ page }
        it { should have_content I18n.translate("flash.users.update.notice") }
        it { should have_css "input[value='#{atrs[:email]}']" }
      end
    end
  end
end

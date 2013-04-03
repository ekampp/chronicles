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
      let(:atrs) { attributes_for(:user).extract!(:name, :email, :age) }
      let(:form) { {id: "#edit_user_#{user.id}", name: "user"} }
      include_context :fill_and_submit_form

      describe "page" do
        subject{ page }
        it { should have_content I18n.translate("flash.users.update.notice") }
        it { should have_css "input[value='#{atrs[:email]}']" }
      end
    end
  end
end

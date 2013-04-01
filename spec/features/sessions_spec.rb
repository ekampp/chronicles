require "spec_helper"

describe "Signing in" do
  before{ visit sign_in_path }

  context "with twitter" do
    context "as new user" do
      before{ click_link "twitter" }

      it { current_path.should eq root_path }
      it { page.should have_content I18n.translate("sessions.create.created").gsub(/\%\{name\}/, "") }
    end

    context "as existing user" do
      before do
        @user = create :user, :mock_twitter
        click_link "twitter"
      end

      it { current_path.should eq root_path }
      it { page.should have_content I18n.translate("sessions.create.updated", name: @user.name) }
    end
  end
end

describe "Signing out" do
  let(:user) { create :user, :email }
  include_context :sign_in
  before { visit sign_out_path }

  it { should_not have_content user.name }
  it { should_not have_content "img[src='https://secure.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.strip)}.png?s=150']" }
  it { page.should have_content I18n.translate("sessions.sign_out.success") }
end

require "spec_helper"

describe "Sign in with twitter" do
  before{ @user = build :user, :mock_omniauth }

  context "without an existing user" do
    before do
      visit sign_in_path
      click_link "twitter_sign_in"
    end

    describe "page" do
      subject{ page }
      it { should have_content I18n.translate("flash.sessions.create.missing_information") }
    end
  end

  context "with an existing user" do
    before do
      @user.save
      visit sign_in_path
      click_link "twitter_sign_in"
    end

    describe "page" do
      subject{ page }
      it { should have_content I18n.translate("flash.sessions.create.success") }
    end
  end
end

describe "Sign in with developer strategy" do
  before{ @user = build :user, :mock_omniauth, provider: :developer }

  context "without an existing user" do
    before do
      visit sign_in_path
      click_link "developer_sign_in"
    end

    describe "page" do
      subject{ page }
      it { should have_content I18n.translate("flash.sessions.create.missing_information") }
    end
  end

  context "with an existing user" do
    before do
      @user.save
      visit sign_in_path
      click_link "developer_sign_in"
    end

    describe "page" do
      subject{ page }
      it { should have_content I18n.translate("flash.sessions.create.success") }
    end
  end
end

describe "Update settings" do
  before do
    @user = create :user, :mock_omniauth
  end

  context "when logged in" do
    before do
      visit sign_in_path
      click_link "twitter_sign_in"
      visit edit_user_path(@user)
    end

    context "fill in email" do
      let(:atrs) { attributes_for :user }
      before do
        within "#edit_user_#{@user.id}" do
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

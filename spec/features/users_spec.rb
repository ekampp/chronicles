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

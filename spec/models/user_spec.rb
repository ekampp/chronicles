require 'spec_helper'

shared_context :mock_auth_hash do
  let(:hash) {
    { provider: user.provider,
      uid: user.uid,
      info: {
        name: user.name
      },
      credentials: {
        token: user.token
      }
    }
  }
end

describe User do
  subject{ build :user }

  # Fields
  it { should be_timestamped_document }
  it { should have_field(:name).with_default_value_of(nil) }
  it { should have_field(:email).with_default_value_of(nil) }
  it { should have_field(:role).with_default_value_of("user") }
  it { should have_field(:provider).with_default_value_of("twitter") }
  it { should have_field(:uid).with_default_value_of(nil) }
  it { should have_field(:token).with_default_value_of(nil) }
  it { should have_field(:session_id).with_default_value_of(nil) }
  it { should have_field(:age).with_default_value_of(nil) }
  it { should have_field(:locale).with_default_value_of("en") }

  # Validations
  it { should be_valid }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:role) }
  it { should validate_inclusion_of(:role).to_allow("user", "gm", "admin") }
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:uid) }
  it { should validate_uniqueness_of(:uid).scoped_to(:provider) }
  it { should validate_uniqueness_of(:session_id) }
  it { should validate_presence_of(:session_id) }
  it { should validate_presence_of(:age) }
  it { should validate_presence_of(:locale) }
  it { should validate_numericality_of(:age).greater_than_or_equal_to(16) }

  describe "factories" do
    describe "with_characters" do
      subject{ create(:user, :with_characters).characters }
      its(:count) { should eq 2 }
    end
  end

  # Associations
  it { should have_many :characters }

  describe "class methods" do
    describe ".find_or_build_from_omniauth_hash" do
      subject{ User.find_or_build_from_omniauth_hash(hash) }

      context "non existing user" do
        let(:user) { build :user }
        context "with a valid twitter hash" do
          include_context :mock_auth_hash

          it { should be_a User }

          # twitter don't supply an email, so the user isn't valid, and should
          # expect to be missing an email.
          it { should_not be_valid }
          its(:email) { should be_nil }

          # However, even when the user is invalid, we should still save it, so
          # the user can have a chance to correct any mistakes.
          it { should be_persisted }
        end
      end

      context "pre-existing user" do
        let(:user) { create :user }
        context "with a valid twitter hash" do
          include_context :mock_auth_hash

          it { should eq user }
          it { should be_persisted }
        end
      end
    end
  end
end

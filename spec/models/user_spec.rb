require 'spec_helper'

describe User do
  subject{ build :user }

  # Fields
  it { should be_timestamped_document }
  it { should have_field(:name).of_type(String) }
  it { should have_field(:uid).of_type(String) }
  it { should have_field(:provider).
    with_default_value_of("twitter").of_type(String) }
  it { should have_field(:role).
    with_default_value_of(:user).of_type(Symbol) }
  it { should have_field(:session_token).of_type(String) }
  it { should have_field(:receive_newsletter).
    with_default_value_of(false).of_type(Boolean) }
  it { should have_field(:email).of_type(String) }

  # Validations
  it { should be_valid }
  it { should validate_presence_of :name }
  it { should validate_presence_of :uid }
  it { should validate_presence_of :provider }
  it { should validate_presence_of :role }
  it { should validate_presence_of :session_token }
  it { should validate_inclusion_of(:role).to_allow([ :user, :admin ]) }

  # Class methods
  describe "class methods" do
    describe "#find_by_auth_hash" do
      context "no current user" do
        context "no existing user" do
          subject{ User.find_by_auth_hash(
            OmniAuth.config.mock_auth[:twitter], nil) }

          it { should be_a Array }
          its(:first) { should be_a User }
          its(:last) { should be_a String }
        end
      end
    end
  end
end

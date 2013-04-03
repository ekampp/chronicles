require "spec_helper"
require "cancan/matchers"

describe Ability do
  subject{ Ability.new(user) }

  describe "as guest" do
    let(:user) { build :user }

    it { should be_able_to :access, :sessions }
    it { should be_able_to :read, :application }
    it { should_not be_able_to :access, :characters }
    it { should_not be_able_to :update, :user }
  end

  describe "as registered, incomplete user" do
    let(:user) { u = build(:user, email: nil); u.save(validate: false); u }

    it { should be_able_to :access, :sessions }
    it { should_not be_able_to :access, :characters }
    it { should be_able_to :update, user }
  end

  describe "as registered, complete user" do
    let(:user) { create :user }
    let(:other_user) { create :user }

    it { should be_able_to :access, :sessions }
    it { should be_able_to :read, :characters }
    it { should be_able_to :create, :characters }
    it { should be_able_to :update, :characters, user_id: user.id }
    it { should be_able_to :update, build(:character, user: user) }
    it { should_not be_able_to :update, build(:character, user: other_user) }
    it { should be_able_to :access, user }
  end
end

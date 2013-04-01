require "spec_helper"
require "cancan/matchers"

describe Ability do
  subject{ Ability.new(user) }

  describe "as guest" do
    let(:user) { build :user }

    it { should be_able_to :create, :user }
    it { should_not be_able_to :update, user }
    it { should_not be_able_to :update, User }
    it { should_not be_able_to :manage, Project }
  end

  describe "as registered user" do
    let(:user) { create :user }

    it { should_not be_able_to :create, :user }
    it { should be_able_to :update, user }
    it { should be_able_to :update, User }
    it { should_not be_able_to :manage, Project }
  end

  describe "as admin" do
    let(:user) { create :user, role: :admin }

    it { should_not be_able_to :create, :user }
    it { should be_able_to :update, user }
    it { should be_able_to :update, User }
    it { should be_able_to :manage, Project }
  end
end

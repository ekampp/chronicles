require 'spec_helper'

describe Character do
  subject{ build :character }

  # Fields
  it { should be_timestamped_document }
  it { should have_field(:name).with_default_value_of(nil) }
  it { should have_field(:public_bio).with_default_value_of(nil) }
  it { should have_field(:private_bio).with_default_value_of(nil) }
  it { should have_field(:avatar).with_default_value_of(nil) }
  it { should have_field(:avatar_cache).with_default_value_of(nil) }

  # Validations
  it { should be_valid }
  it { should validate_presence_of(:name) }

  # Associations
  it { should belong_to :user }

  describe "instance methods" do
    describe "#avatar" do
      it { should respond_to :avatar }
    end

    describe "#progress" do
      subject{ Character.new }
      context "1/3 done" do
        before{ subject.name = "Foo" }
        its(:progress) { should eq 34 }
      end
      context "2/3 done" do
        before{ subject.name = "Foo";
                subject.public_bio = "Bar" }
        its(:progress) { should eq 67 }
      end
      context "3/3 done" do
        before{ subject.name = "Foo";
                subject.public_bio = "Bar";
                subject.private_bio = "Blob" }
        its(:progress) { should eq 100 }
      end
    end
  end
end

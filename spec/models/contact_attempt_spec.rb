require 'spec_helper'

describe ContactAttempt do

  # Fields
  it { should be_timestamped_document.with(:created) }
  it { should have_field :name }
  it { should have_field :email }
  it { should have_field :url }
  it { should have_field :comment }

  # Validations
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :comment }

end

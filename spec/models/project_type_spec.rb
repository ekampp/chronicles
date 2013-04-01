require 'spec_helper'

describe ProjectType do
  subject{ build :project_type }

  # Fields
  it { should have_field(:name).of_type(String) }
  it { should have_field(:key).of_type(String) }

  # Validations
  it { should be_valid }
  it { should validate_presence_of :name }
  it { should validate_presence_of :key }
  it { should validate_uniqueness_of :key }
end

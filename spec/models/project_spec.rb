require 'spec_helper'

describe Project do
  subject{ build :project }

  # Fields
  it { should be_timestamped_document }
  it { should have_field(:name).of_type(String) }
  it { should have_field(:summary).of_type(String) }
  it { should have_field(:description).of_type(String) }
  it { should have_field(:url).of_type(String) }
  it { should have_field(:avatar).of_type(String) }
  it { should have_field(:avatar_cache).of_type(String) }

  # Validations
  it { should be_valid }
  it { should validate_presence_of :name }
  it { should validate_presence_of :summary }
end

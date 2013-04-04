require 'spec_helper'

describe Character do
  subject{ build :character }

  # Fields
  it { should be_timestamped_document }
  it { should have_field(:name).with_default_value_of(nil) }
  it { should have_field(:public_bio).with_default_value_of(nil) }
  it { should have_field(:private_bio).with_default_value_of(nil) }

  # Validations
  it { should be_valid }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:public_bio) }
  it { should validate_presence_of(:private_bio) }

  # Associations
  it { should belong_to :user }

end

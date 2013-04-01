require 'carrierwave/test/matchers'

describe ProjectAvatarUploader do
  include CarrierWave::Test::Matchers

  let(:user) { create :user }
  let(:uploader) { ProjectAvatarUploader.new(user, :avatar) }
  let(:file_path) { "#{Rails.root}/spec/support/fixtures/rails.png" }

  before do
    ProjectAvatarUploader.enable_processing = true
    uploader.store!(File.open(file_path))
  end

  after do
    ProjectAvatarUploader.enable_processing = false
    uploader.remove!
  end

  describe "resizing" do
    context "portfolio_thumb" do
      subject{ uploader.portfolio_thumb }
      it { should have_dimensions(300, 200) }
    end

    context "standard size" do
      subject{ uploader }
      it { should be_no_larger_than(1024, 1024) }
    end
  end
end

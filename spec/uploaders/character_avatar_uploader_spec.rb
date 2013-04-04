require "spec_helper"

describe "CharacterAvatarUploader" do
  it_should_behave_like :standard_uploader do
    let(:user) { create :user, :with_characters }
    let(:klass) { :character_avatar_uploader }
    let(:object) { user.characters.sample }
    let(:mount_point) { :avatar }
    let(:file) { File.open("#{Rails.root}/spec/support/fixtures/rails.png") }
    let(:versions) { {thumb: "300x300"} }

    it { uploader.filename.should eq "avatar.jpg" }
    it { uploader.path.should eq "#{Rails.root}/public/uploads/#{object.class.to_s.underscore}/#{mount_point}/#{object.id}/avatar.jpg" }
  end
end

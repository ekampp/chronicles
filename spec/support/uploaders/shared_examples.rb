# This can be used to test the most standard implementation of the carrierwave
# uploader.
# The object could be an article or a user, or some other object that the
# uploader is mounted on.
#
# Examples of usage
#
#   it_should_behave_like :standard_uploader do
#     let(:klass) { :name_of_uploader_class }
#     let(:object) { #<Object> }
#     let(:mount_point) { :name_of_mount_point }
#     let(:file) { "/path/to/file.png" }
#     let(:versions) { {thumb: "300x300"} }
#   end
#
shared_examples :standard_uploader do
  let(:uploader) { klass.to_s.classify.constantize.new(object, mount_point) }

  before do
    klass.to_s.classify.constantize.enable_processing = true
    uploader.store!(file)
  end

  after do
    klass.to_s.classify.constantize.enable_processing = false
    uploader.remove!
  end

  it { uploader.extension_white_list.should eq %w(jpg jpeg png) }
  it { uploader.should have_permissions 0666 }
  it "should have the right versions" do
    if defined? versions
      versions.each do |version, dimensions|
        (x, y) = dimensions.split("x").map(&:to_i)
        uploader.send(version).should be_no_larger_than(x, y)
      end
    end
  end
end

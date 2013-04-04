shared_examples :action do
  before{ action }

  describe "response" do
    subject{ response }

    it "should render correct template" do
      should render_template template if defined? template
    end

    it "should have right status code" do
      subject.status.should eq status if defined? status
    end

    it "should redirect correctly" do
      subject.should redirect_to location if defined? location
    end

    it "should set header location correctly" do
      subject.headers["Location"].should match header_location if defined? header_location
    end
  end

  it "should assign right values" do
    if defined? variables and variables.is_a? Hash
      variables.each do |key, value|
        controller.send(key).should eq value
      end
    end
  end
end

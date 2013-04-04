shared_context :sign_in do
  before do
    controller.stub(:signed_in?).and_return true
    controller.stub(:current_user).and_return user
  end
end

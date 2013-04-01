shared_context :sign_in do
  before do
    user
    visit sign_in_path
    click_link "twitter"
  end
end

shared_examples :denied_access do
  it { current_path.should eq root_path }
  it { page.should have_content I18n.translate("application.render_401.rescued") }
end

shared_examples :redirect_to_sign_in do
  it { current_path.should eq sign_in_path }
end

shared_examples :redirect_to_sign_out do
  it { current_path.should eq root_path }
  it { page.should have_content I18n.t("sessions.sign_out.success") }
end

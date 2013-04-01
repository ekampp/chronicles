shared_examples :user_updated_correctly do
  it { current_path.should eq edit_user_path }
  it { page.should have_content I18n.translate("sessions.users.update.success") }
end

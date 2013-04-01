shared_examples :project_updated_correctly do
  it { current_path.should eq edit_admin_project_path(project) }
  it { page.should have_content I18n.translate("admin.projects.update.success") }
end

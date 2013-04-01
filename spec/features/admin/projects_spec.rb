require "spec_helper"

describe "Listing existing projects a project" do
  let(:atrs) { attributes_for :project }
  let(:admin) { create :user, role: :admin }
  let(:user) { create :user }

  context "as non-admin user" do
    include_context :sign_in
    before{ visit admin_projects_path }
    it_should_behave_like :denied_access
  end

  context "as admin user" do
    include_context :sign_in do
      let(:user) { admin }
    end
    before{ visit admin_projects_path }

    describe "page content" do
      subject{ page }
      it { should have_content I18n.translate("admin.projects.index.title") }
      it { should have_selector "a[href='#{new_admin_project_path}']", text: I18n.translate("admin.projects.index.new_project") }
    end
  end
end

describe "Creating a new project" do
  let(:atrs) { attributes_for :project }
  let(:admin) { create :user, role: :admin }
  let(:user) { create :user }

  context "as non-admin user" do
    include_context :sign_in
    before{ visit new_admin_project_path }
    it_should_behave_like :denied_access
  end

  context "as admin user" do
    include_context :sign_in do
      let(:user) { admin }
    end
    before{ visit new_admin_project_path }

    describe "filling the form" do
      before do
        within "#new_project" do
          fill_in "project_name", with: atrs[:name]
          fill_in "project_summary", with: atrs[:summary]
          fill_in "project_description", with: atrs[:description]
          click_button "commit"
        end
      end

      describe "current location" do
        it { current_path.should match /\/admin\/projects\/.{24}\/edit/ }
      end

      describe "page content" do
        subject{ page }
        it { should have_css "input[value='#{atrs[:name]}']" }
        it { should have_css "input[value='#{atrs[:summary]}']" }
        it { should have_selector "#project_description", text: atrs[:description] }
      end
    end
  end
end

describe "Editing an existing project" do
  let(:project) { create :project }
  let(:atrs) { attributes_for :project }
  let(:admin) { create :user, role: :admin }
  let(:user) { create :user }

  context "as non-admin user" do
    include_context :sign_in
    before{ visit edit_admin_project_path(project) }
    it_should_behave_like :denied_access
  end

  context "as admin user" do
    include_context :sign_in do
      let(:user) { admin }
    end
    before{ visit edit_admin_project_path(project) }

    describe "filling the form" do
      before do
        within "#edit_project_#{project.id}" do
          fill_in "project_name", with: atrs[:name]
          fill_in "project_summary", with: atrs[:summary]
          fill_in "project_description", with: atrs[:description]
          click_button "commit"
        end
      end

      describe "current location" do
        it { current_path.should match /\/admin\/projects\/.{24}\/edit/ }
      end

      describe "page content" do
        subject{ page }
        it { should have_css "input[value='#{atrs[:name]}']" }
        it { should have_css "input[value='#{atrs[:summary]}']" }
        it { should have_selector "#project_description", text: atrs[:description] }
      end
    end
  end
end

describe "Delete existing project" do
  let(:project) { create :project }
  let(:atrs) { attributes_for :project }
  let(:admin) { create :user, role: :admin }
  let(:user) { create :user }

  context "as non-admin user" do
    include_context :sign_in
    before{ visit edit_admin_project_path(project) }
    it_should_behave_like :denied_access
  end

  context "as admin user" do
    include_context :sign_in do
      let(:user) { admin }
    end

    before do
      visit edit_admin_project_path(project)
      click_link "delete"
    end

    it { current_path.should eq admin_projects_path }
  end
end

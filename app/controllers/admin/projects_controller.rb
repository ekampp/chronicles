class Admin::ProjectsController < ApplicationController
  authorize_resource
  expose(:projects) { Project.all }
  expose(:project, attributes: :project_params)

  def create
    project.save
    respond_with project, location: [ :edit, :admin, project ]
  end

  def update
    project.save
    respond_with project, location: [ :edit, :admin, project ]
  end

  def destroy
    project.destroy
    respond_with project, location: [ :admin, :projects ]
  end

private

  def project_params
    params.require(:project).permit(:name, :summary, :avatar, :description)
  end

end

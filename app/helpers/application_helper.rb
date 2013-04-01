module ApplicationHelper

  # Returns the current project thumbnail url to the proect, or if the project doesn't have an avatar, it will return a placeholder.
  #
  def project_avatar_url project
    (project.avatar.portfolio_thumb.url ||
     "http://www.placehold.it/200x150/EFEFEF/AAAAAA&text=no+image")
  end

end

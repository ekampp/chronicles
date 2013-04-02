class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    hash = request.env["omniauth.auth"]
    user = User.find_or_build_from_omniauth_hash hash
    if user.persisted?
      sign_in! user
      if user.valid?
        redirect_to last_known_location,
          notice: I18n.t("flash.sessions.create.success")
      else
        redirect_to edit_user_path(user),
          alert: I18n.t("flash.sessions.create.missing_information")
      end
    else
      render :new, alert: I18n.t("flash.sessions.create.failure")
    end
  end

  def new
  end

  def destroy
    sign_out!
    redirect_to root_path
  end
end

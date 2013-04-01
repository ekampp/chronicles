class SessionsController < ApplicationController
  expose(:user)

  def sign_in
    if signed_in?
      flash[:notice] = I18n.t("sessions.create.updated", name: current_user.name)
      redirect_to root_path
    else
      respond_with user
    end
  end

  def create
    (user, message) = User.find_by_auth_hash(
      request.env["omniauth.auth"], current_user)

    if user.persisted?
      sign_in! user
      flash[:notice] = I18n.t("sessions.create.#{message}", name: user.name)
      if session[:last_known_location]
        redirect_to session[:last_known_location]
      else
        redirect_to root_path
      end
    else
      sign_out!
      flash[:alert] = I18n.t("sessions.create.failure")
      render :new
    end
  end

  def sign_out
    sign_out!
    redirect_to root_path, notice: I18n.t("sessions.sign_out.success")
  end
end

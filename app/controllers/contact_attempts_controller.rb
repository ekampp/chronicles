class ContactAttemptsController < ApplicationController
  expose(:contact_attempt, attributes: :contact_attempt_params)

  def create
    if contact_attempt.save
      redirect_to root_path, notice: I18n.t("contact_attempts.create.success")
    else
      @show_contact_form  = true
      @show_logo_and_menu = true
      render "home/index"
    end
  end

private

  def contact_attempt_params
    params.require(:contact_attempt).
      permit(:name, :email, :url, :comment)
  end

end

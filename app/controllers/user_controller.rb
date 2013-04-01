class UserController < ApplicationController
  authorize_resource
  expose(:user, attributes: :user_params) { current_user }

  def update
    user.attributes = user_params
    if user.save
      flash[:notice] = I18n.translate("sessions.users.update.success")
    end
    respond_with user, location: edit_user_path
  end

private

  def user_params
    params.require(:user).permit(:receive_newsletter,
      :email)
  end

end

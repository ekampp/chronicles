class UsersController < ApplicationController
  expose :user, attributes: :user_params

  def update
    user.save
    respond_with user, location: edit_user_path(user)
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :age)
  end

end

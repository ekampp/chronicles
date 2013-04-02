class UsersController < ApplicationController
  expose :user, attributes: :user_params

private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end

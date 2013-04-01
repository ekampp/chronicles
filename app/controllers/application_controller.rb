class ApplicationController < ActionController::Base
  # Mime types to respond to
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Allows decent exposure to use strong parameters.
  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  # # Add some additional context to honeybadger
  # before_filter do
  #   Honeybadger.context({
  #     :user_id => current_user.id,
  #     :user_name => current_user.name,
  #     :user_uid => current_user.uid,
  #     :user_provider => current_user.provider
  #   }) if signed_in?
  # end

  # Rescues in the case that oauth returns 401
  rescue_from OAuth::Unauthorized, with: :render_401
  rescue_from CanCan::Unauthorized, with: :render_401


protected

  def render_401
    flash[:alert] = I18n.t("application.render_401.rescued")
    redirect_to root_path
  end

end

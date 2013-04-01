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

  # Add some additional context to honeybadger
  before_filter do
    Honeybadger.context({
      :user_id => current_user.id,
      :user_name => current_user.name,
      :user_uid => current_user.uid,
      :user_provider => current_user.provider
    }) if signed_in?
  end

  # Returns the currently logged in user
  #
  def current_user
    @current_user ||= User.where(session_token: session[:session_token]).first
  end
  helper_method :current_user

  # Is the user signed in?
  #
  def signed_in?
    !!current_user
  end
  helper_method :signed_in?

  # Signs out the user
  #
  def sign_out!
    session[:session_token] = nil
    session[:last_known_location] = nil
  end

  # Signs in the given user
  #
  def sign_in! user
    session[:session_token] = user.session_token
    @current_user = user
  end

  # Rescues in the case that oauth returns 401
  rescue_from OAuth::Unauthorized, with: :render_401
  rescue_from CanCan::AccessDenied, with: :render_401


protected

  def render_401
    flash[:alert] = I18n.t("application.render_401.rescued")
    redirect_to root_path
  end

end

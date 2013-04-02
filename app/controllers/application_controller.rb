require "application_responder"

class ApplicationController < ActionController::Base

  # Mime types to respond to
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Allows decent exposure to use strong parameters.
  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  def current_user
    @current_user ||= User.where(session_id: session[:session_token]).first
  end
  helper_method :current_user

  def signed_in?
    !!current_user
  end
  helper_method :signed_in?

  def last_known_location
    session[:last_known_location] || root_path
  end

  def sign_in! user
    session[:session_token] = user.session_id
    @current_user = user
  end

  def sign_out!
    session[:session_token] = @current_user = nil
  end

  # Rescues in the case that oauth returns 401
  rescue_from OAuth::Unauthorized, with: :render_401
  rescue_from CanCan::Unauthorized, with: :render_401
  rescue_from Mongoid::Errors::DocumentNotFound, with: :render_404

protected

  def render_401
    redirect_to root_path, alert: I18n.t("flash.application.render_401")
  end

  def render_404
    redirect_to root_path, alert: I18n.t("flash.application.render_404")
  end

end

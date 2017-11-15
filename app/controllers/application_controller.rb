class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def logged_in?
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user
    @current_user
  end

  helper_method :logged_in?
  helper_method :current_user
end

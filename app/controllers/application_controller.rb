class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # force_ssl

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user != nil
  end

  def require_login
    unless current_user
      redirect_to splash_url
    end
  end

  def direct_to_home
    if logged_in?
      redirect_to root_url
    end
  end

  
  
  helper_method :current_user, :has_actions?
end

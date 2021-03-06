class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= lookup_user
  end
  helper_method :current_user

  def lookup_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end

  def authenticate
    logged_in? ? true : access_denied
  end

  def logged_in?
    current_user.is_a? User
  end
  helper_method :logged_in?

  def access_denied
    redirect_to new_session_path, :notice => "Please log in to continue" and return false
  end

end

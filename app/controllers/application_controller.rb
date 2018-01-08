class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home
  
  end

  def in_session?
     session.include? :user_id 
  end

  def logged_in?
    session.include? :user_id 
  end

  def current_user
    if logged_in?
      User.find(session[:user_id])
    else
      nil
    end
  end

end

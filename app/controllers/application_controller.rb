class ApplicationController < ActionController::Base
  before_action :check_login_status
  helper_method :current_user

  def current_user
    @_current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private
  def check_login_status
    if current_user.nil?
      flash[:error] = "You need to log in to access this page."
      # redirect_to # somehow the previous page
    end
  end
end

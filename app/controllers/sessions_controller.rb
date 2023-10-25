class SessionsController < ApplicationController
  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged Out"
    redirect_to '/'
  end
end
class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_user_url # where to redirect to?
  end
end

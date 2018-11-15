class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    login_user!(user)
    redirect_to user_url(user)
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_user_url # where to redirect to?
  end
end

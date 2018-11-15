class UsersController < ApplicationController
  def show
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # do something
    else
      # do something else
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end

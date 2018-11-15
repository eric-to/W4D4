class UsersController < ApplicationController
  def show
    render :show
  end

  # Renders sign up form, which makes a request to #create
  def new
    @user = User.new
    render :new
  end

  # Receives request from #new and adds new user to database
  def create
    @user = User.new(user_params)

    if @user.save
      # TODO: sessions_controller implements this logic
      # Shows user their homepage if they sign up successfully
      login_user!(@user)
      redirect_to user_url(@user)
    else
      # Show user the sign up page again if they failed
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

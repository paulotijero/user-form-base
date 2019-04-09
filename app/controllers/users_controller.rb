class UsersController < ApplicationController
  def index
    @user = User.last
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :username,
      :email,
      :email_confirmation,
      :password,
      :password_confirmation,
      :password_hint
    )
  end
end

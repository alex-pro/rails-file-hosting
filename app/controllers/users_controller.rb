class UsersController < ApplicationController
  skip_before_filter :authenticate, only: [:new, :create]
  before_filter :check_user

  def new
    @user = User.new
  end

  def create
    user = User.new(params_user)
    if user.save
      flash[:notice] = "Користувач успішно створений"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def params_user
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

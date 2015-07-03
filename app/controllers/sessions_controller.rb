class SessionsController < ApplicationController
  skip_before_filter :authenticate, only: [:new, :create]
  before_filter :check_user, except: :destroy

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      session[:user_id] = user.id
      flash[:notice] = "Ви увійшли як #{current_user.email}"
      redirect_to root_path
    else
      flash.now[:danger] = 'Неправильно введено електронну пошту або пароль'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path
  end
end

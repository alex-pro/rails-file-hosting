class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :init_item
  before_filter :authenticate


  def init_item
    @item = Item.new
  end

  def check_user
    redirect_to root_path if logged_in?
  end

  def authenticate
    redirect_to new_session_path unless logged_in?
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user
end

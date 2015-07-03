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

  def content_verification(file)
    image_types = ["image/jpeg", "image/jpg", "image/png", "image/bmb"]
    audio_types = ["audio/mp3", "audio/mid", "audio/wav", "audio/x-flac", "audio/aac", "audio/mpeg"]
    video_types = ["application/mp4", "application/mkv", "application/3gp", "application/avi", "video/x-matroska", "video/x-msvideo", "video/quicktime"]
    return 1 if image_types.include? file.content_type
    return 2 if audio_types.include? file.content_type
    return 3 if video_types.include? file.content_type
    return 0
  end
  helper_method [:current_user, :content_verification]
end

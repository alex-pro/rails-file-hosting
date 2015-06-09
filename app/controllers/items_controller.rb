class ItemsController < ApplicationController
  skip_before_filter :authenticate, only: [:show, :download]
  before_filter :get_item, only: [:show, :download]

  def index
    @search = Item.search do
      fulltext params[:search]
      paginate page: params[:page], per_page: 20
      order_by(:created_at, :desc)
    end
    @items = @search.results
  end

  def create
    @item = current_user.items.new(params_item)
    if @item.file.content_type == "audio/mp3"
      @item.icon = "/media/audio-volume-medium-panel.png"
    end
    @item.save
    flash[:notice] = "File successfully uploaded"
    render nothing: true
  end

  def destroy
    item = current_user.items.find_by(id: params[:id])
    item.destroy! if item
    flash[:notice] = 'Item successfully destroyed'
    redirect_to root_path
  end

  def download
    send_file(@item.file.path)
  end

  def download_my
    item = current_user.items.find_by(id: params[:item_id])
    send_file(item.file.path)
  end

  private

  def params_item
    params.permit(:file, :icon)
  end

  def get_item
    user = User.find_by(id: params[:user_id])
    @item = user.items.find_by(token: params[:id])
    redirect_to root_path unless user && @item
  end
end

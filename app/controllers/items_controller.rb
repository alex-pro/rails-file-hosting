class ItemsController < ApplicationController
  respond_to :html, :json
  skip_before_filter :authenticate, only: [:show, :download]
  before_filter :get_item, only: [:show, :download]

  def index
    @folders = current_user.folders.where('parent_id IS NULL')
    if params[:search].blank?
      @items = current_user.items.where('folder_id IS NULL').page(1).per(20)
    else
      items_index = ItemSearchService.new(params[:search])
      @items = items_index.search.per(4).page(params[:page]).only(:id).load
    end
    respond_with @folders
  end

  def create
    folder = Folder.find_by(id: params[:item][:folder_id])
    if folder
      @item = folder.items.new(params_item)
      @item.user_id = folder.user_id
    else
      @item = current_user.items.new(params_item)
    end
    if @item.save
      flash[:notice] = "Файл(и) успішно завантажені"
      render nothing: true
    else
      flash[:error] = "Сталася помилка"
      render nothing: true
    end
  end

  def destroy
    item = current_user.items.find_by(id: params[:id])
    if item.destroy
      respond_to do |format|
        format.js { flash[:notice] = 'Файл успішно видалений' }
      end
    end
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
    params.permit(:file, :name)
  end

  def get_item
    user = User.find_by(id: params[:user_id])
    @item = user.items.find_by(token: params[:id]) if user
    redirect_to root_path unless user && @item
  end
end

class ItemsController < ApplicationController
  skip_before_filter :authenticate, only: [:show, :download]
  before_filter :get_item, only: [:show, :download]

  def index
    if params[:search].blank?
      @folders = current_user.folders.where('parent_id IS NULL')
      @items = current_user.items.where('folder_id IS NULL').page(1).per(20)
    else
      @folders = []
      @search = Item.search do
        fulltext params[:search]
        paginate page: params[:page], per_page: 20
        order_by(:created_at, :desc)
      end
      @items = @search.results
    end
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
    if item
      item.destroy
      flash[:notice] = 'Файл успішно видалений'
    end
    redirect_to :back
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

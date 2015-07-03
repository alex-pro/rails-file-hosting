class FoldersController < ApplicationController
  def create
    folder = current_user.folders.create(name: "Folder", parent_id: params[:parent_id])
    redirect_to :back
  end

  def show
    @folder = current_user.folders.find_by(id: params[:id])
  end

  def destroy
    folder = current_user.folders.find_by(id: params[:id])
    folder.destroy! if folder
    flash[:notice] = 'Тека успішно видалена'
    redirect_to :back
  end
end

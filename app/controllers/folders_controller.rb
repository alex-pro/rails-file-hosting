class FoldersController < ApplicationController
  def create
    current_user.folders.create(name: "Folder", parent_id: params[:parent_id])
    redirect_to :back
  end

  def show
    @folder = current_user.folders.find_by(id: params[:id])
  end

  def update
    folder = current_user.folders.find_by(id: params[:id])
    if folder.update(name: params[:name])
      redirect_to :back, notice: 'Тека успішно перейменована'
    else
      flash[:error] = 'Теку не вдалося перейменувати'
      redirect_to :back
    end
  end

  def destroy
    folder = current_user.folders.find_by(id: params[:id])
    folder.destroy! if folder
    flash[:notice] = 'Тека успішно видалена'
    redirect_to :back
  end

  private

  def folder_params
    params.require(:folder).permit(:name)
  end
end

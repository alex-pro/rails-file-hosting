class FoldersController < ApplicationController
  def create
    current_user.folders.create(name: "Нова тека", parent_id: params[:parent_id])
    redirect_to :back
  end

  def show
    @folder = current_user.folders.find_by(id: params[:id])
  end

  def update
    folder = current_user.folders.find_by(id: params[:id])
    if folder.update(folder_params)
      redirect_to :back, notice: 'Тека успішно перейменована'
    else
      redirect_to :back
      flash[:error] = 'Теку не вдалося перейменувати'
    end
  end

  def destroy
    folder = current_user.folders.find_by(id: params[:id])
    if folder.destroy
      respond_to do |format|
        format.js { flash[:notice] = 'Тека успішно видалена' }
      end
    end
  end

  private

  def folder_params
    params.permit(:name)
  end
end

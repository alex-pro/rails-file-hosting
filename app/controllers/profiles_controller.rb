class ProfilesController < ApplicationController
  def edit
    @profile = Profile.find_by(id: params[:id])
  end

  def update
    if current_user.profile.update(profile_params)
      redirect_to :back, notice: 'Профіль успішно оновлений'
    else
      redirect_to :back
      flash[:error] = 'Профіль не вдалося оновити'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :photo, :birthday, addresses_attributes: [:id, :country, :city, :street, :house_number, :_destroy])
  end
end

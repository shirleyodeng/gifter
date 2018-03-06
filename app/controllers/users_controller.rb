class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def edit
    authorize @user
  end

  def update
    authorize @user
    @user.update(user_params)
    redirect_to events_path
  end

private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :photo, :photo_cache)
  end
end

class ProfileController < ApplicationController
  before_action :show, :user_params

  def show
    if current_user.id == params[:id].to_i
      redirect_to edit_user_registration_path
    else
      @user = User.find(params[:id])
    end

  end

  private

  def user_params
    params.permit(:id) if current_user.id != params.permit(:id)
  end
end

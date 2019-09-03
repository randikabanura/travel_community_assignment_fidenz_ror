class ProfileController < ApplicationController
  before_action :show, :user_params

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.permit(:id) if current_user.id != params.permit(:id)
  end
end

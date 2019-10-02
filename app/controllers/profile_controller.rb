class ProfileController < ApplicationController
  before_action :show, :user_params

  def show
    if current_user.id == params[:id].to_i
      redirect_to edit_user_registration_path
    else
      @user = User.find(params[:id])
      @review = UserReview.new
      if UserReview.exists?(review_user_id: params[:id])
        @reviews = UserReview.all.where(review_user: @user)
      else
        @reviews = nil
      end
    end
  end

  private

  def user_params
    params.permit(:id) if current_user.id != params.permit(:id)
  end
end

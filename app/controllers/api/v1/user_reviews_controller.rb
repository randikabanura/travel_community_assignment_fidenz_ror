module Api
  module V1
    class UserReviewsController < ApplicationController
      skip_before_action :verify_authenticity_token
      skip_before_action :authenticate_user!

      def create
        review = UserReview.new(user_review_params)
        review.user = User.find(review.user_id)
        review.review_user = User.find(review.review_user_id)

        if review.save
          if UserReview.exists?(review_user_id: review.review_user_id)
            @reviews = UserReview.all.where(review_user: User.find(review.review_user_id))
          else
            @reviews = nil
          end
          @user = User.find(review.review_user_id)
          respond_to do |format|
            format.js { render 'userreview/review', locals: {reviews: @reviews, user:@user} }
          end
        else
          render json: {  error: review.errors.full_messages }, status: :bad_request
        end
      end

      def show

      end

      def destroy
        review = UserReview.find(params[:id])
        if review.destroy
          if UserReview.exists?(review_user_id: params[:review_user_id])
            @reviews = Review.all.where(review_user: User.find(params[:review_user_id]))
          else
            @reviews = nil
          end
          @user = User.find(params[:review_user_id])

          respond_to do |format|
            format.js { render 'userreview/review', locals: {reviews: @reviews, user:@user} }
          end
        else
          render json: {  error: review.errors.full_messages }, status: :bad_request
        end
      end

      def edit
        @review = UserReview.find(params[:id])
        @user = User.find(params[:review_user_id])
        respond_to do |format|
          format.js { render 'userreview/edit_review', locals: {review: @review, user:@user} }
        end
      end

      def update
        review = UserReview.find(update_user_review_params[:id])
        if review.update(update_user_review_params)
          if UserReview.exists?(review_user_id: update_user_review_params[:review_user_id])
            @reviews = UserReview.all.where(review_user: User.find(update_user_review_params[:review_user_id]))
          else
            @reviews = nil
          end
          @user = User.find(update_user_review_params[:review_user_id])

          respond_to do |format|
            format.js { render 'userreview/review', locals: {reviews: @reviews, trip: @trip} }
          end
        else
          render json: {  error: review.errors.full_messages }, status: :bad_request
        end
      end

      private

      def user_review_params
        params.require(:user_review).permit(:user_id, :review_user_id, :rating, :description)
      end

      def update_user_review_params
        params.require(:user_review).permit(:id, :user_id, :review_user_id, :rating, :description)
      end
    end
  end
end

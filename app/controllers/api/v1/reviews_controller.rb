module Api
  module V1
    class ReviewsController < ApplicationController
      skip_before_action :verify_authenticity_token
      skip_before_action :authenticate_user!

      def create
        review = Review.new(review_params)
        review.user = User.find(review.user_id)
        review.trip = Trip.find(review.trip_id)
        if review.save
          if Review.exists?(trip_id: review.trip_id)
            @reviews = Review.all.where(trip: Trip.find(review.trip_id))
          else
            @reviews = nil
          end
          @trip = Trip.find(review.trip_id)
          respond_to do |format|
            format.js { render 'trips/review', locals: { reviews: @reviews, trip: @trip } }
          end
        else
          render json: { error: review.errors.full_messages }, status: :bad_request
        end
      end

      def show
        # for showing reviews
      end

      def destroy
        review = Review.find(params[:id])
        if review.destroy
          if Review.exists?(trip_id: params[:trip_id])
            @reviews = Review.all.where(trip: Trip.find(params[:trip_id]))
          else
            @reviews = nil
          end
          @trip = Trip.find(params[:trip_id])

          respond_to do |format|
            format.js { render 'trips/review', locals: { reviews: @reviews, trip: @trip } }
          end
        else
          render json: {  error: review.errors.full_messages }, status: :bad_request
        end
      end

      def edit
        @review = Review.find(params[:id])
        @trip = Trip.find(params[:trip_id])
        respond_to do |format|
          format.js { render 'trips/edit_review', locals: { review: @review, trip: @trip } }
        end
      end

      def update
        review = Review.find(update_review_params[:id])
        if review.update(update_review_params)
          if Review.exists?(trip_id: update_review_params[:trip_id])
            @reviews = Review.all.where(trip: Trip.find(update_review_params[:trip_id]))
          else
            @reviews = nil
          end
          @trip = Trip.find(update_review_params[:trip_id])
          respond_to do |format|
            format.js { render 'trips/review', locals: { reviews: @reviews, trip: @trip } }
          end
        else
          render json: { error: review.errors.full_messages }, status: :bad_request
        end
      end

      private

      def review_params
        params.require(:review).permit(:user_id, :trip_id, :rating, :description)
      end

      def update_review_params
        params.require(:review).permit(:id, :user_id, :trip_id, :rating, :description)
      end
    end
  end
end

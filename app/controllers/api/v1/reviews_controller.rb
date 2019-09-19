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

          respond_to do |format|
            format.js { render 'trips/review', locals: {reviews: @reviews} }
          end
        else
          render json: {status: 'SUCCESS', message: 'Review saved2'}, status: :internal_server_error
        end
      end

      def show

      end

      private

      def review_params
        params.require(:review).permit(:user_id, :trip_id, :rating, :description)
      end
    end
  end
end

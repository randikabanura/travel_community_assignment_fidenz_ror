module Api
  module V1
    class ReviewsController < ApplicationController
      skip_before_action :verify_authenticity_token
      skip_before_action :authenticate_user!

      def create
        review = Review.new(review_params)
        review.user= User.find(review.user_id)
        review.trip = Trip.find(review.trip_id)
        if review.save
          render json: {status: 'SUCCESS', message: 'Review saved'}, status: :ok
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

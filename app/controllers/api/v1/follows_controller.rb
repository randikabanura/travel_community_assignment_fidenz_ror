module Api
  module V1
    class FollowsController < ApplicationController
      protect_from_forgery with: :null_session
      skip_before_action :authenticate_user!, only: [:index, :create, :destroy]

      def index
      end

      def create
        current_user1 = User.first
        follow_user = User.find(user_params[:id])
        current_user1.follow(follow_user)
        follow = Follow.find_by(follower: current_user1, followable: follow_user)
        render json: {status: 'SUCCESS', message: 'Added a follow table row', data: follow}, status: :ok
      end

      def destroy
        current_user1 = User.first
        follow_user = User.find(user_params[:id])
        current_user1.stop_following(follow_user)
        render json: {status: 'SUCCESS', message: 'User stop following'}, status: :ok
      end

      private

      def user_params
        params.permit(:id)
      end
    end
  end
end

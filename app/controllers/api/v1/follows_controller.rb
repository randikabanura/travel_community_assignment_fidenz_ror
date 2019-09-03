module Api
  module V1
    class FollowsController < ApplicationController
      protect_from_forgery with: :null_session
      skip_before_action :authenticate_user!, only: [:index, :create, :destroy, :isfollowing?, :allfollowers, :allfollowing]

      def index
      end

      def create
        current_user = User.find(user_params[:current_user_id])
        follow_user = User.find(user_params[:follow_user_id])
        current_user.follow(follow_user)
        follow = Follow.find_by(follower: current_user, followable: follow_user)
        if follow
          render json: {status: 'SUCCESS', message: 'Added a follow table row', data: follow}, status: :ok
        else
          render json: {status: 'Failure', message: 'Unable to follow the user'}, status: :internal_server_error
        end
      end

      def destroy
        current_user = User.find(user_params[:current_user_id])
        follow_user = User.find(user_params[:follow_user_id])
        current_user.stop_following(follow_user)
        render json: {status: 'SUCCESS', message: 'User stop following'}, status: :ok
      end

      def isfollowing?
        current_user = User.find(user_params[:current_user_id])
        follow_user = User.find(user_params[:follow_user_id])
        result = current_user.following?(follow_user)
        render json: {status: 'SUCCESS', data: result}, status: :ok
      end

      def allfollowers
        current_user = User.find(user_params2[:id])
        result = current_user.followers
        render json:  result, status: :ok
      end

      def allfollowing
        current_user = User.find(user_params2[:id])
        result = current_user.all_following
        print result
        render json:  result, status: :ok
      end

      private

      def user_params
        params.permit(:current_user_id, :follow_user_id)
      end

      def user_params2
        params.permit(:id)
      end
    end
  end
end

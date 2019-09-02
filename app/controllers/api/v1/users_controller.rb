module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!, only: [:index, :show]

      def index
        users = User.order("RANDOM()").limit(5)
        render json: {status: 'SUCCESS', message: 'Five random users', data: users}, status: :ok
      end

      def show
        user = User.find(user_params[:id])
        render json: {status: 'SUCCESS', message: 'Specific user details retrieved', data: user}, status: :ok
      end

      def delete_image_attachment
        @image = ActiveStorage::Attachment.find(params[:id])
        @image.purge
        respond_to do |format|
          format.js {render :file => 'devise/registrations/edit'}
        end
      end

      private

      def user_params
        params.permit(:id)
      end
    end
  end
end

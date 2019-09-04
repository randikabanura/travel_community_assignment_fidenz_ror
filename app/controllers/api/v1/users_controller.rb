module Api
  module V1
    class UsersController < ApplicationController

      def index
         users = User.order("RANDOM()").limit(5)
         render json: {status: 'SUCCESS', message: 'Five random users', data: users}, status: :ok
      end

      def show
        user = User.find(user_params[:id])
        render json: {user: user}, status: :ok
      end

      def delete_image_attachment
        @image = ActiveStorage::Attachment.find(params[:id])
        @image.purge
        respond_to do |format|
          format.js {render :file => 'devise/registrations/edit'}
        end
      end

      def avatar_image_thumbnail
        image = nil
        user = User.find(user_params[:id])
        image = url_for(user.avatar.variant(resize: '60x60!')) if user.avatar.attached?
        render json: {link: image}, status: :ok
      end

      private

      def user_params
        params.permit(:id)
      end
    end
  end
end

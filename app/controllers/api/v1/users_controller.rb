module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!, only: [:index]
      def index
         users = User.order_by_rand.limit(5)
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
        if user.avatar.attached? && user.avatar.content_type.in?(%('image/jpeg image/png'))
          image = url_for(user.avatar.variant(resize: '60x60!'))
          end
        render json: {link: image}, status: :ok

      end

      private

      def user_params
        params.permit(:id)
      end
    end
  end
end

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!, only: [:index]

      def index
        users = User.order("RANDOM()").limit(5)
        render json: {status: 'SUCCESS', message: 'Five random users', data: users}, status: :ok
      end
    end
  end
end

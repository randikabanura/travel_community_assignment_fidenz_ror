class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :gender, :dob) }
    #devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:studentid, :password) }
    devise_parameter_sanitizer.permit(:account_update, keys: [:name,:email, :gender, :dob, :avatar, images: []])
  end
end

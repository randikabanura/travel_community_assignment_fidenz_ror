class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :gender, :dob) }
    #devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:studentid, :password) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :password, :password_confirmation, :gender, :dob, :avatar, :current_password) }
  end
end

ActiveAdmin.register Trip do
menu priority: 3, label: proc { "Trips" }

  controller do
    before_action :authenticate

    def authenticate
      redirect_to(root_path) unless current_user.has_role? :admin
    end
  end
  permit_params :user_id, :description, :date_s, :date_e, :location, :latitude, :longitude
end

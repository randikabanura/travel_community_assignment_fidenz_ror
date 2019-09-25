ActiveAdmin.register Trip do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  menu priority: 3, label: proc { "Trips" }

  controller do
    before_action :authenticate

    def authenticate
      redirect_to(root_path) unless current_user.has_role? :admin
    end
  end

  permit_params :user_id, :description, :date_s, :date_e, :location, :latitude, :longitude
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :description, :date_s, :date_e, :location, :latitude, :longitude]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end

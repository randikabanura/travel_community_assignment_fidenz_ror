ActiveAdmin.register Role do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  controller do
    before_action :authenticate

    def authenticate
      redirect_to(root_path) unless current_user.has_role? :admin
    end
  end
   permit_params :name, :resource_type, :resource_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :resource_type, :resource_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end

ActiveAdmin.register Role do

  controller do
    before_action :authenticate

    def authenticate
      redirect_to(root_path) unless current_user.has_role? :admin
    end
  end
   permit_params :name, :resource_type, :resource_id
end

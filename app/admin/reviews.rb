ActiveAdmin.register Review do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :trip_id, :rating, :description
  actions  :index, :edit, :show, :update, :destroy

  form do |f|
    inputs "Review Details" do
      input :user
      input :trip
      input :rating, as: :number
      input :description
    end
    actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :trip_id, :rating, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end

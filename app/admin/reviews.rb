ActiveAdmin.register Review do
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
end

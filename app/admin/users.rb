ActiveAdmin.register User do

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

  index do
    selectable_column
    column "Id" do |user|
      link_to user.id, admin_user_path(user)
    end
    column "Name", :name
    column "Email", :email
    column "Dob", :dob
    column "Gender", :gender
    column :roles do |user|
      user.roles.collect {|c| c.name.capitalize }.to_sentence
    end
    actions
  end

  form do |f|
    inputs "User Details" do
      input :name
      input :email
      input :gender, collection: ["Male", "Female"]
      input :dob
      input :password
      input :roles, as: :check_boxes
    end
    actions
  end

      permit_params :id, :email, :name, :gender, :dob,  :password, role_ids: []


  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :gender, :dob, :confirmation_token, :confirmed_at, :confirmation_sent_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end

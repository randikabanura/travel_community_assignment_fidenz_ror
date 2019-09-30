ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  scope :all
  scope :admins
  scope :pro_user_1
  scope :pro_user_2
  scope :pro_user_3
  scope :normal

  menu priority: 2, label: proc { "Users" }

  permit_params :id, :email, :name, :gender,  :password, role_ids: []

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
    column "Name" do |user|
      link_to user.name, admin_user_path(user)
    end
    column "Email", :email
    column "Dob", :dob
    column "Gender" do |user|
      if(user.gender == "m")
        para "Male"
      else
        para "Female"
      end
    end
    column :roles do |user|
      user.roles.collect {|c| c.name.capitalize }.to_sentence
    end
    actions
  end

  form do |f|
    inputs "User Details" do
      input :name
      input :email
      input :gender, collection: [["Male", "m"], ["Female", "f"]]
      input :password
      input :roles, as: :check_boxes
    end
    actions
  end

  controller do
    def update_resource(object, attributes)
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :gender, :dob, :confirmation_token, :confirmed_at, :confirmation_sent_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end

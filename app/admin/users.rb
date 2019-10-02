ActiveAdmin.register User do
  scope :all
  scope :admins
  scope :pro_user_1
  scope :pro_user_2
  scope :pro_user_3
  scope :normal

  menu priority: 2, label: proc { 'Users' }

  permit_params :id, :email, :name, :gender,  :password, role_ids: []

  controller do
    before_action :authenticate

    def authenticate
      redirect_to(root_path) unless current_user.has_role? :admin
    end
  end

  index do
    selectable_column
    column 'Id' do |user|
      link_to user.id, admin_user_path(user)
    end
    column 'Name' do |user|
      link_to user.name, admin_user_path(user)
    end
    column 'Email', :email
    column 'Dob', :dob
    column 'Gender' do |user|
      if(user.gender == 'm')
        para 'Male'
      else
        para 'Female'
      end
    end
    column :roles do |user|
      user.roles.collect {|c| c.name.capitalize }.to_sentence
    end
    actions
  end

  form do |f|
    inputs 'User Details' do
      input :name
      input :email
      input :gender, collection: [['Male', 'm'], ['Female', 'f']]
      input :password
    end
    actions
  end

  controller do
    def update_resource(object, attributes)
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end
  end
end

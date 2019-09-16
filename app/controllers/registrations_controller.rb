class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
    return super if params["password"]&.present?
    return super if params["email"]&.present?
    return super if params["name"]&.present?

    resource.update_without_password(params.except("current_password"))
  end
end
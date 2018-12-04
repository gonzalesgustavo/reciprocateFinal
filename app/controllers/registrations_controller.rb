class RegistrationsController < Devise::RegistrationsController

  protected
  #set nup for devise and omniauth twitter
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
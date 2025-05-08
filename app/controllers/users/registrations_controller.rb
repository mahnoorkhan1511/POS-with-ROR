class Users::RegistrationsController < DeviseInvitable::RegistrationsController
  before_action :configure_permitted_parameters

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username, :avatar ])
  end
end

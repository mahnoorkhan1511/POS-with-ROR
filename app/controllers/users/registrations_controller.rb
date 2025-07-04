class Users::RegistrationsController < DeviseInvitable::RegistrationsController
  before_action :configure_permitted_parameters

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username, :avatar ])
  end
  def create
    super do |user|
      if user.persisted?
        user.create_customer
      end
    end
  end
end

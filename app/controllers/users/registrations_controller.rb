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

  def after_update_path_for(resource)
    puts "after update path (request referrer) : #{request.referrer}"
    puts "after update path (stored location) : #{stored_location_for(resource)}"
    request.referrer || root_path
  end
end

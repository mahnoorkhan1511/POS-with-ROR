class Users::InvitesController < Devise::InvitationsController
  layout "admin"
  before_action :authenticate_user!
  # before_action :check_admin_role
  before_action :configure_permitted_parameters, if: :devise_controller?
  def new
    @user = User.new
    @user.build_employee  # Initialize an employee record for the form
  end

  def create
    super
      @user = User.invite!(user_params)  # Send the invite to the user
      if @user.persisted?
        if params[:user][:employee_attributes]
          # @user.create_employee(user_params[:employee_attributes])
          # flash.now[:notice] = "Invite sent and employee record generated!"
          return new_user_invitation_url, notice: "Invite sent and employee record generated!"
        else
          return new_user_invitation_url, alert: "Employee attributes are missing or invalid."
        end

      else
        flash.now[:alert] = "Something is wrong, try again!"
  render :new, status: :unprocessable_entity
      end
  end

  private

  def user_params
    params.require(:user).permit(:email, employee_attributes: [ :role ])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [ :role ])
  end
end

class Admin::EmployeesController < Admin::BaseController
  load_and_authorize_resource
  def index
    @employees = Employee.all
    @users = User.joins(:employee)
  end

  def resend_invitation
    @user = User.find(params[:id])
    if @user.created_by_invite? and @user.invitation_accepted? == false
      @user.invite!
      redirect_to admin_employees_path, notice: "User Re-invited"
    end
  end
end

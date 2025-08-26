class Admin::EmployeesController < Admin::BaseController
  before_action :set_employee, only: %i[resend_invitation edit update deactivate]
  before_action :find_corresponding_user, only: %i[resend_invitation deactivate]

  load_and_authorize_resource

  def index
    @employees = Employee.all.excluding_employee(current_user.employee)
    # @users = User.joins(:employee).excluding_user(current_user)
  end

  def resend_invitation
    if @user.created_by_invite? and @user.invitation_accepted? == false
      @user.invite!
      redirect_to admin_employees_path, notice: "Invitation re-sent to #{@employee.email}"
    else
      redirect_to admin_employees_path, alert: "#{@employee.email} was not created with invite. CANNOT resend invite"
    end
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      redirect_to admin_employees_path, notice: "Successfully updated #{@employee.username || @employee.email} !"
    else
      render :edit, status: :unprocessable_entity, alert: "Update Failed !"
    end
  end

  def deactivate
    if @user.access_locked?
      @user.unlock_access!
      redirect_to admin_employees_path, notice: "#{@user.username || @user.email} is now active !"
    else
      @user.lock_access!(send_instructions: false)
      redirect_to admin_employees_path, alert: "#{@user.username || @user.email} is deactivated !"
    end
  end

  private

  def find_corresponding_user
    @user = @employee.user
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:role)
  end
end

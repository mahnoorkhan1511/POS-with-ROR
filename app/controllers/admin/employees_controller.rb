class Admin::EmployeesController < Admin::BaseController
  before_action :set_employee, only: %i[resend_invitation edit update deactivate]
  before_action :find_corresponding_user, only: %i[resend_invitation deactivate]

  load_and_authorize_resource
  def index
    @employees = Employee.all
    @users = User.joins(:employee).excluding_user(current_user)
  end

  def resend_invitation
    puts "hello from resend invite"
    # @employee = Employee.find(params[:id])
    # @user = @employee.user
    if @user.created_by_invite? and @user.invitation_accepted? == false
      puts "inviting user!!!!    !!!!!  !!!!"
      @user.invite!
      flash.now[:notice] = "User Re-invited"
      redirect_to admin_employees_path
    end
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      redirect_to admin_employees_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def deactivate
    if @user.access_locked?
      @user.unlock_access!
    else
      @user.lock_access!(send_instructions: false)
    end

    redirect_to admin_employees_path
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

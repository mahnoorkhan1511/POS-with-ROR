class HomeController < ApplicationController
  def redirect_by_role
    if current_user&.employee&.admin? || current_user&.employee&.manager? || current_user&.employee&.product_manager?
      redirect_to admin_dashboard_index_path
    else
      redirect_to customers_home_index_path
    end
  end
end

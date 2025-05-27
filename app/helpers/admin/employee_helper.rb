module Admin
  module EmployeeHelper
    def activation_status(user)
      if user.created_by_invite? && user.invitation_accepted? && !user.access_locked?
        button_to "Deactivate", deactivate_admin_employee_path(user.employee),
           method: :patch,  data: { turbo_confirm: "This employee is currently active. Do you want to deactivate #{user.email}?" },
           class: "block py-2 px-4 bg-red-500 text-white hover:bg-red-700 rounded-md  w-full"
      elsif !user.created_by_invite? || !user.invitation_accepted?
        content_tag(:span, "Cannot Activate or deactivate this user", class: "text-yellow-600")
      else
        button_to "Activate", deactivate_admin_employee_path(user.employee),
           method: :patch,  data: { turbo_confirm: "This employee is currently deactivated. Do you want to activate #{user.email}?" },
           class: "block py-2 px-4 bg-green-500 text-white hover:bg-green-700 rounded-md  w-full"
      end
    end

    def resend_invite(user)
      if user.created_by_invite? && user.invitation_accepted?
        content_tag(:span, "Accepted Invite", class: "text-green-500")
      elsif !user.created_by_invite?
        content_tag(:span, "Not created with invite", class: "text-yellow-600")
      else
        button_to "Resend Invitation", resend_invitation_admin_employee_path(user.employee), method: :patch, class: "block py-2 px-4 hover:bg-green-200 rounded-md  w-full"
      end
    end
  end
  module ProductHelpler
    def status(product)
     if product.published?
      content_tag(:p, "Published", class: "text-sky-600")
     elsif product.reviewed?
      content_tag(:p, "Reviewed", class: " text-emerald-700")
     else
      content_tag(:p, "Drafted", class: "text-yellow-600")
     end
    end
  end
end

class Employee < ApplicationRecord
  belongs_to :user

  enum role: {
    admin: "admin",
    manager: "manager",
    product_manager: "product_manager"
  }

  # def admin?
  #   role == "admin"
  # end

  # def manager?
  #   role == "manager"
  # end

  # def product_manager?
  #   role == "product_manager"
  # end
end

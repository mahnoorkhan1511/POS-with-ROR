class Employee < ApplicationRecord
  belongs_to :user

  enum role: {
    admin: "admin",
    manager: "manager",
    product_manager: "product_manager"
  }

  delegate :username, :email, to: :user

  scope :excluding_employee, ->(employee) { where.not(id: employee.id) }
end

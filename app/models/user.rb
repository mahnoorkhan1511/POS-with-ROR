class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  # has_secure_password
  has_one :employee
  has_one :customer

  accepts_nested_attributes_for :employee
end

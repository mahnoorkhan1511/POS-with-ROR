class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :lockable

  has_one_attached :avatar

  # has_secure_password
  has_one :employee, dependent: :destroy
  has_one :customer, dependent: :destroy

  accepts_nested_attributes_for :employee

  scope :excluding_user, ->(user) { where.not(id: user.id) }
end

class CustomerDetail < ApplicationRecord
  belongs_to :customer
  has_many :orders

  validates :first_name, presence: true
  validates :address, presence: true
  validates :street_apt, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates :email, presence: true
  validates :phone, presence: true
end

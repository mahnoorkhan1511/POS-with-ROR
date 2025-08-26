class CustomerDetail < ApplicationRecord
  belongs_to :customer
  has_many :orders

  validates :address, :street_apt, :city, :country, :state, :zipcode, :phone, presence: true
  validates :address, uniqueness: {
    scope: [ :customer_id, :street_apt, :city, :state, :country, :zipcode, :phone ],
    message: "You have an identical address present,
    choose from already present addresses or enter a new one"
  }
end

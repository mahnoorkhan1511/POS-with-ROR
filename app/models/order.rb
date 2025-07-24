class Order < ApplicationRecord
  belongs_to :customer
  has_one :order_transaction, dependent: :destroy
  has_many :ordered_products, dependent: :destroy
  has_many :products, through: :ordered_products
  belongs_to :customer_detail

  accepts_nested_attributes_for :customer_detail
  accepts_nested_attributes_for :order_transaction

  enum status: {
    processing: 0,
    confirmed: 1,
    dispatched: 2,
    delivered: 3,
    failed: 4
  }

  delegate :payment_type, :is_paid, :amount, to: :order_transaction
  delegate :username, :email, to: :customer, prefix: :customer
  delegate :address, :street_apt, :city, :country, :state, :zipcode, :phone, to: :customer_detail, prefix: :customer
end

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
end

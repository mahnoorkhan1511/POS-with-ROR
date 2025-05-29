class Order < ApplicationRecord
  belongs_to :customer
  has_one :order_transaction, dependent: :destroy
end

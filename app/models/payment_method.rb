class PaymentMethod < ApplicationRecord
  has_many :order_transactions
end

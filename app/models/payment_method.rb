class PaymentMethod < ApplicationRecord
  has_many :transaction
end

class Transaction < ApplicationRecord
  belongs_to :payment
  belongs_to :order
  belongs_to :customer
end

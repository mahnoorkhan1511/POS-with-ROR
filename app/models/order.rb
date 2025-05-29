class Order < ApplicationRecord
  belongs_to :customer
  has_one :transaction, dependent: :destroy
end

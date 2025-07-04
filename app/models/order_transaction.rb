class OrderTransaction < ApplicationRecord
  belongs_to :order
  belongs_to :customer

  enum payment_type: {
    cash_on_delivery: 0,
    online: 1
  }
end

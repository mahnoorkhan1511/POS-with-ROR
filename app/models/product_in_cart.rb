class ProductInCart < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def total
    product.sales_price * quantity
  end
end

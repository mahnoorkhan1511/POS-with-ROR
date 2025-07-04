class ProductInCart < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  delegate :product_name, to: :product

  scope :products_to_order, -> { where(to_be_ordered: true) }
  def total
    product.sales_price * quantity
  end
  def products_to_order
    self.products_to_order
  end
end

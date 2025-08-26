class Cart < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :product_in_carts
  has_many :products, through: :product_in_carts
  delegate :products_to_order, to: :product_in_carts

  def total
    products_to_order.to_a.sum { |product| product.total }
  end
end

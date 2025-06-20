class Cart < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :product_in_carts
  has_many :products, through: :product_in_carts

  def total
    product_in_carts.to_a.sum { |product_in_cart| product_in_cart.total }
  end
end

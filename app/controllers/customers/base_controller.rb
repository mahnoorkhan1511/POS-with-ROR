class Customers::BaseController < ApplicationController
  before_action :set_cart
  private
  def set_cart
    if current_user&.customer&.cart.present?
      if @cart.product_in_carts
        cart_products = @cart.product_in_carts
      end
      @cart = current_user.customer.cart
      @cart.product_in_carts << cart_products
      # do i need to hit @cart.save here too?
    elsif @cart.customer_id.nil? && current_user.present?
      @cart.customer = current_user.customer
      @cart.save
    end
  end
end

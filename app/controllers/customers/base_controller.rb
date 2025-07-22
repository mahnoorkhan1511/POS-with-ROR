class Customers::BaseController < ApplicationController
  before_action :set_cart
  private
  def set_cart
    if current_user&.customer&.cart.present?
      @cart = current_user.customer.cart
    elsif @cart.customer_id.nil? && current_user.present?
      @cart.customer = current_user.customer
      @cart.save
    end
  end
end

class Customers::BaseController < ApplicationController
  before_action :set_cart
  private
  def set_cart
    puts "[ALERT] Is this function even calling ??"
    if current_user&.customer&.cart.present?
      puts "[ALERT] Customer Cart present #{current_user.customer&.cart} !!"
      @cart = current_user.customer.cart
    elsif @cart.customer_id.nil? && current_user.present?
      @cart.customer = current_user.customer
      @cart.save
      puts "[ALERT] Customer Cart absent new cart customer #{@cart.customer} !!"
    end
  end
end

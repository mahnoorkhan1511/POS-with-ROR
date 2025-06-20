class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :initialize_cart
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    if can? :access, :dashboard
      admin_dashboard_index_path
    else
      root_path
    end
  end

  def initialize_cart
    @cart ||= Cart.find_by(id: session[:cart_id])
    if @cart.nil?
      @cart = Cart.create!
      session[:cart_id] = @cart.id
    end
  end
end

class ProductsController < ApplicationController
before_action :set_product, only: %i[show]
include CanCan::ControllerAdditions
  def index
    @products = Product.all.published
  end
  def show
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end
end

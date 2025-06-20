class CartsController < ApplicationController
  def add_to
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_pic = @cart.product_in_carts.find_by(product_id: @product.id)
    if current_pic && quantity > 0
      quantity += current_pic.quantity
      current_pic.update(quantity:)
      redirect_to home_index_path, notice: "Added #{params[:quantity]} more of #{@product.name} to bag"
    else
      @cart.product_in_carts.create(product: @product, quantity: quantity)
      redirect_to home_index_path, notice: " #{@product.name} added to bag! "
    end
  end
  def directly_update
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_pic = @cart.product_in_carts.find_by(product_id: @product.id)
    if current_pic && quantity > 0
      current_pic.update(quantity:)
    elsif quantity <= 0
      current_pic.destroy
    end
    respond_to do |format|
      format.turbo_stream do
        render inline: turbo_stream.update("cart_content", partial: "cart/cart")
      end
    end
  end
  def remove_from
    @pic = ProductInCart.find_by(id: params[:id])
    ProductInCart.find_by(id: params[:id]).destroy
    @product = @pic.product
    respond_to do |format|
      format.turbo_stream do
        render inline: turbo_stream.update("cart_content", partial: "cart/cart")
      end
    end
  end
end

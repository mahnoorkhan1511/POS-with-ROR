class Customers::CartsController < Customers::BaseController
  def index
    @products_in_cart = @cart.product_in_carts.order(:created_at)
    @products_to_order = @products_in_cart.products_to_order.order(:created_at)
  end
  def add_to
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_pic = @cart.product_in_carts.find_by(product_id: @product.id)
    if current_pic && quantity > 0
      quantity += current_pic.quantity
      current_pic.update(quantity:)
      redirect_to customers_home_index_path, notice: "Added #{params[:quantity]} more of #{@product.name} to bag"
    elsif quantity > 0
      @cart.product_in_carts.create(product: @product, quantity: quantity)
      redirect_to customers_home_index_path, notice: " #{@product.name} added to bag! "
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
    if params[:cart_main]
      redirect_to customers_carts_path
    else
      respond_to do |format|
        format.turbo_stream do
          render inline: turbo_stream.update("cart_content", partial: "customers/carts/cart")
        end
      end
    end
  end
  def remove_from
    @pic = ProductInCart.find_by(id: params[:id])
    ProductInCart.find_by(id: params[:id]).destroy
    @product = @pic.product
    if params[:cart_main]
      redirect_to customers_carts_path
    else
      respond_to do |format|
        format.turbo_stream do
          render inline: turbo_stream.update("cart_content", partial: "customers/carts/cart")
        end
      end
    end
  end
  def products_to_be_ordered
    @pic = ProductInCart.find_by(id: params[:id])
    to_be_ordered = ActiveModel::Type::Boolean.new.cast(params[:to_be_ordered])
    @pic.update(to_be_ordered:)
    redirect_to customers_carts_path
  end
end

class Customers::OrdersController < Customers::BaseController
  before_action :authenticate_user!
  load_and_authorize_resource
  def new
    @customer = current_user.customer
    @order = Order.new
    @order.build_customer_detail
    @order.build_order_transaction
  end
  def create
    @customer = current_user.customer
    @order = @customer.orders.new(order_params)
    @order.customer_detail.customer = @customer
    @order.order_transaction.customer = @customer
    authorize! :create, @order
    @order.save
    @order.save
    @cart.products_to_order.each do |pto|
      @order.ordered_products.create(
        product_id: pto.product_id,
        price: pto.product.sales_price,
        quantity: pto.quantity
      )
    end
    case @order.order_transaction.payment_type.to_sym
    when :cash_on_delivery
      @order.status = :confirmed
      @cart.products_to_order.destroy_all
      redirect_to success_customers_order_url(@order.id), notice: "Order placed with Cash on Delivery"
    when :online
      @cart.products_to_order.destroy_all
      redirect_to stripe_checkout_customers_order_url(@order.id), notice: "stripe territory"
    end
  end
  def stripe_checkout
  end
  def success
    @order = Order.find_by(id: params[:id])
  end
  def create_stripe_session
    @order = Order.find_by(id: params[:id])
    Rails.logger.info "🧪 Ordered Productsfor Stripe: #{@order.ordered_products.inspect}"
    @line_item = @order.ordered_products.map do |op|
      {
        price_data: {
          currency: "usd",
          product_data: {
            name: op.product.name
            # description: op.product.description
          },
          unit_amount: (op.product.sales_price * 100).to_i
        },
        quantity: op.quantity
      }
    end
    session = Stripe::Checkout::Session.create({
    ui_mode: "embedded",
    line_items: @line_item,
    mode: "payment",
      # return_url: "http://localhost:3000/customers/orders/#{@order.id}/success"
      return_url: success_customers_order_url(@order.id, host: request.base_url)
    })

    render json: { clientSecret: session.client_secret }
  end

  def order_params
    params.require(:order).permit(
      :customer_id,
      :customer_detail_id,
      customer_detail_attributes: [ :first_name, :last_name, :address, :street_apt, :city, :country, :state, :zipcode, :phone, :email ],
      order_transaction_attributes: [ :payment_type, :amount ]
    )
  end
end

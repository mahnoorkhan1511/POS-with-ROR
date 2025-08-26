class Customers::OrdersController < Customers::BaseController
  before_action :authenticate_user!
  before_action :ensure_username, only: %i[new]
  before_action :set_customer, only: %i[ index new create ]
  before_action :set_order, only: :show
  load_and_authorize_resource

  def index
    @orders = Order.where(customer_id: @customer.id)
  end

  def show
  end

  def new
    @order      = Order.new
    @first_name = current_user.username.split(" ")[0] || ""
    @last_name  = current_user.username.split(" ")[1] || ""
    @order.build_customer_detail
    @order.build_order_transaction
  end

  def create
    @order = @customer.orders.new(order_params)
    @order.order_transaction.customer = @customer
    @order.save_customer_details(customer: @customer, attributes: params[:order][:customer_detail_attributes])

    if @order.save
      @order.create_ordered_products(@cart)
      handle_post_save_flow
    else
      render :new, alert: "Could not place order, try again!"
    end
  end

  def success
    @order = Order.find_by(id: params[:id])
  end

  def create_stripe_session
    @order     = Order.find(params[:id])
    return_url = success_customers_order_url(@order.id, host: request.base_url)
    puts "Creating Stripe Checkout session for order ##{@order.id}"
    session    = StripeCheckoutSessionCreator.new(order: @order, return_url: return_url).session
    puts "Created session with payment_intent: #{session.payment_intent}"
    render json: { clientSecret: session.client_secret }
  end

  private

  def order_params
    params.require(:order).permit(
      :customer_id,
      :customer_detail_id,
      customer_detail_attributes: [ :address, :street_apt, :city, :country, :state, :zipcode, :phone ],
      order_transaction_attributes: [ :payment_type, :amount ]
    )
  end

  def set_customer
    @customer = current_user.customer
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def handle_post_save_flow
    @cart.products_to_order.destroy_all
    case @order.order_transaction.payment_type.to_sym
    when :cash_on_delivery
      @order.status = :confirmed
      redirect_to success_customers_order_url(@order.id), notice: "Order placed with Cash on Delivery" and return
    when :online
      render "customers/orders/stripe_checkout", locals: { order: @order }
    end
  end

  def ensure_username
    if !current_user.username
      redirect_to customers_carts_path, alert: "Set your Username !"
    end
  end
end

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
    @order = Order.new
    @order.build_customer_detail
    @order.build_order_transaction
    @first_name = current_user.username.split(" ")[0]
    @last_name = current_user.username.split(" ")[1]
  end
  def create
    @order = @customer.orders.new(order_params)
    @order.order_transaction.customer = @customer
    set_customer_details
    if @order.save
      create_ordered_products
      handle_post_save_flow
    else
      render :new
    end
  end
  def success
    @order = Order.find_by(id: params[:id])
  end
  def create_stripe_session
    # previously find_by id
    @order = Order.find(params[:id])
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
      # add meta attribute for order id
    end
    session = Stripe::Checkout::Session.create({
    ui_mode: "embedded",
    line_items: @line_item,
    payment_intent_data: {
      metadata: {
        order_id: @order.id
      }
    },
    mode: "payment",
      return_url: success_customers_order_url(@order.id, host: request.base_url)
    })

    render json: { clientSecret: session.client_secret }
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "Access denied."
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

  def set_customer_details
    cd_params = params[:order][:customer_detail_attributes]
    existing_cd = CustomerDetail.find_by(
      customer_id: current_user.customer.id,
      address: cd_params[:address],
      street_apt: cd_params[:street_apt],
      city: cd_params[:city],
      country: cd_params[:country],
      state: cd_params[:state],
      zipcode: cd_params[:zipcode],
      phone: cd_params[:phone]
    )
    if existing_cd
      @order.customer_detail = existing_cd
    elsif @order.customer_detail
      @order.customer_detail.customer = @customer
    end
  end

  def create_ordered_products
    @cart.products_to_order.each do |pto|
      @order.ordered_products.create(
        product_id: pto.product_id,
        price: pto.product.sales_price,
        quantity: pto.quantity
      )
    end
  end

  def handle_post_save_flow
    Rails.logger.info "🧪 handle_post_save_flow "
    case @order.order_transaction.payment_type.to_sym
    when :cash_on_delivery
      @order.status = :confirmed
      @cart.products_to_order.destroy_all
      redirect_to success_customers_order_url(@order.id), notice: "Order placed with Cash on Delivery" and return

    when :online
      @cart.products_to_order.destroy_all
      render "customers/orders/stripe_checkout", locals: { order: @order }
    end
  end
  def ensure_username
    if !current_user.username
      redirect_to customers_carts_path, alert: "Set your Username !"
    end
  end
end

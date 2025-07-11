class Admin::OrdersController < Admin::BaseController
  before_action :set_order, only: %i[edit update show]
  def index
    @orders = Order.all
  end
  def edit
  end
  def update
    if @order.update(order_params)
      redirect_to admin_orders_path, notice: "Order ID: #{@order.id} updated!"
    else
      render :edit, status: :unprocessable_entity, alert: "some error occured"
    end
  end
  def show
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
  def set_order
    @order = Order.find(params[:id])
  end
end

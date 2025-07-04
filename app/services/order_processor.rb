class OrderProcessor
  def initialize(order)
    @order = order
  end
  def processor
    case @order.order_transaction.payment_type.to_sym
    when :cash_on_delivery
      @order.save
      { status: :success, redirect: Rails.application.routes.url_helpers.success_customers_order_path(@order.id) }
    when :online
      @order.save
      { status: :underProgress, redirect: Rails.application.routes.url_helpers.stripe_checkout_customers_order_path(@order.id) }
    end
  end
end

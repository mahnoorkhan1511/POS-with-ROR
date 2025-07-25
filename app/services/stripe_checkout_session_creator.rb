class StripeCheckoutSessionCreator
  def initialize(order:, return_url:)
    @order = order
    @return_url = return_url
  end
  def session
    Stripe::Checkout::Session.create({
    ui_mode: "embedded",
    line_items: @order.line_items,
    payment_intent_data: {
      metadata: {
        order_id: @order.id
      }
    },
    mode: "payment",
      return_url: @return_url
    })
  end
end

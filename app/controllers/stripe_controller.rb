class StripeController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[webhook]

  def webhook
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = Rails.application.credentials.dig(:stripe, :signing_secret)

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
      case event.type
      when "payment_intent.succeeded"
        payment_intent = event.data.object
        order = Order.find_by(id: payment_intent.metadata.order_id)
        order.status = :confirmed
        order.order_transaction.update(status: true)
        order.save
      when "charge.failed"
        puts "Charge failed"
      else
        puts event.type
      end
      render plain: "ok"
    rescue Stripe::SignatureVerificationError => e
      puts "bad verification #{e}"
      render plain: "error", status: :bad_request
    rescue JSON::ParserError => e
      puts "JSON parse error #{e}"
      render plain: "error", status: :bad_request
    end
  end
end

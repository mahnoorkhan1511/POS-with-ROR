require "stripe"
Rails.configuration.stripe = {
  publishable_key: Rails.application.credentials.dig(:stripe, :pk),
  secret_key: Rails.application.credentials.dig(:stripe, :sk)
}
Stripe.api_key = Rails.application.credentials.dig(:stripe, :sk)

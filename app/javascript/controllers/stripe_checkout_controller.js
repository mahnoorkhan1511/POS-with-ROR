import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

// Connects to data-controller="stripe-checkout"
export default class extends Controller {
  static values = {publishableKey: String, url: String}
  async connect() {
    const stripe = Stripe(this.publishableKeyValue);
    const fetchClientSecret = async () => {
      const token = document.querySelector('meta[name="csrf-token"]').content;
      const response = await fetch(this.urlValue, {
        method: "POST",
        headers: {
          "X-CSRF-Token": token,
          "Content-Type": "application/json"
        }
      });
      const { clientSecret } = await response.json();
      return clientSecret;
    };
    // const response = await post(this.urlValue);
    // const {fetchClientSecret} = await response.json;

    const checkout = await stripe.initEmbeddedCheckout({
      fetchClientSecret,
    });
  
    // Mount Checkout
    checkout.mount(this.element);

  
  }
}

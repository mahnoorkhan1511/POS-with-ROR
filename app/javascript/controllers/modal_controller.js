import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal"];

  open() {
    this.modalTarget.classList.remove("hidden");
  }

  close() {
    this.modalTarget.classList.add("hidden");
  }
  closeAfterSubmit(event) {
    // Close the modal when the form is submitted successfully
    if (event.detail.success) {
      this.close();
    }
  }
}

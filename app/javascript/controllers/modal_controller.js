import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["background", "content"]
  connect(){
    console.log("modal controller here !!")
  }
  close(event) {
    // If click is outside the modal content, close the modal
    if (!this.contentTarget.contains(event.target)) {
      this.backgroundTarget.remove()
    }
  }
}

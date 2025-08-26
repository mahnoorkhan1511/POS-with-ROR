import { Controller } from "@hotwired/stimulus"
// import Rails from "@rails/ujs"

// Connects to data-controller="amount"
export default class extends Controller {
  static targets  = ["output", "form"]
  connect() {

  }
  increase(){
    this.outputTarget.value = parseInt(this.outputTarget.value) + 1;
  }
  decrease(){
    this.outputTarget.value = Math.max(0, parseInt(this.outputTarget.value) - 1);
  }
  submit_upon_increase(){
    this.outputTarget.value = parseInt(this.outputTarget.value) + 1;
    this.formTarget.requestSubmit()
  }
  submit_upon_decrease(){
    this.outputTarget.value = Math.max(0, parseInt(this.outputTarget.value) - 1);
    this.formTarget.requestSubmit()
  }
}

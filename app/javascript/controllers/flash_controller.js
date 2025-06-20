import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.classList.add("opacity-0", "transition-opacity", "duration-500");
      setTimeout(()=> this.element.classList.add("hidden"),500);
    }, 5000)
  }
}

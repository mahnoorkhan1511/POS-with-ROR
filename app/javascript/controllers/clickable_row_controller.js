import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="clickable-row"
export default class extends Controller {
  static values = {
    href: String
  }
  connect() {
    this.element.style.cursor = "pointor"
  }
  navigate(){
    window.location.href = this.hrefValue;
  }
}

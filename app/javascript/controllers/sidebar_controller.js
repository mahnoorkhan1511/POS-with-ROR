import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  static targets = ["menu"]

  toggle(event) {
    // Find the clicked element's parent menu and toggle its open state
    const menu = event.currentTarget.nextElementSibling;
    menu.classList.toggle("hidden");
  }
}

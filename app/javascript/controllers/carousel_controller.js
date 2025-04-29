import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="carousel"
export default class extends Controller {
  static targets = ["container"]

  connect() {
    console.log("Carousel controller connected 🎡")
    // You can also do any setup here if needed
  }

  scrollLeft() {
    console.log("sup, left button here!")
    this.containerTarget.scrollBy({
      left: -300,
      behavior: "smooth"
    })
  }

  scrollRight() {
    console.log("sup right button here!")
    this.containerTarget.scrollBy({
      left: 300,
      behavior: "smooth"
    })
  }
}

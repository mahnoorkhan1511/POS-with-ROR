import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="address-button"
export default class extends Controller {
  static targets = ["form", "input"]
  static values = {
    details: Array,  
    index: Number
  }


  connect() {
    this.selectedButton = null
    console.log("address button")
  }

  fill(event) {
    const button = event.currentTarget
    const index = button.dataset.addressButtonIndexValue
    const detail = this.detailsValue[index]

    // Fill form fields
    document.getElementById("address").value = detail.address || ""
    document.getElementById("street_apt").value = detail.street_apt || ""
    document.getElementById("city").value = detail.city || ""
    document.getElementById("country").value = detail.country || ""
    document.getElementById("state").value = detail.state || ""
    document.getElementById("zipcode").value = detail.zipcode || ""
    document.getElementById("phone").value = detail.phone || ""

    if (this.selectedButton) {
      this.selectedButton.classList.remove("border-2","border-sky-800", "text-sky-800", "shadow-md")
    }
    button.classList.add("border-2","border-sky-800", "text-sky-800", "shadow-md")
    this.selectedButton = button
  }

}

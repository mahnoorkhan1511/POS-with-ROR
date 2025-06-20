import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="preview"
export default class extends Controller {
  static targets = ["output", "input"]
  connect() {
    console.log("preview_controller here")
  }
  previewImage() {
    console.log("inside the function img")
    const file = this.inputTarget.files[0];
    console.log(this.inputTarget)
    if (file){
      const url = URL.createObjectURL(file);
      this.outputTarget.src = url;
      this.outputTarget.onload = () => URL.revokeObjectURL(url)
    }
  }
}

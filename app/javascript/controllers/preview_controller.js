import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="preview"
export default class extends Controller {
  static targets = ["output", "input"]
  connect() {

  }
  previewImage() {
    const file = this.inputTarget.files[0];
    if (file){
      const url = URL.createObjectURL(file);
      this.outputTarget.src = url;
      this.outputTarget.onload = () => URL.revokeObjectURL(url)
    }
  }
}

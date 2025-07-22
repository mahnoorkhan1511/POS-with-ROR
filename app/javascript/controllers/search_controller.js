import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["search", "input", "results"]
  connect() {
    this.currentIndex = 0
  }
  
  navigate(event){
    const options = document.getElementsByClassName("search-option")
    if (options.length === 0) return

    if (event.key === "ArrowDown") {
      this.currentIndex = (this.currentIndex + 1) % options.length
    }
  
    if (event.key === "ArrowUp") {
      this.currentIndex = (this.currentIndex - 1 + options.length) % options.length
    }
  
    if (event.key === "Enter" && this.currentIndex >= 0) {
      options[this.currentIndex].click()
    }
    this.highlight()
  }

  highlight() {
    const options = Array.from(document.getElementsByClassName("search-option"));
    options.forEach((opt, index) => {
      if (index === this.currentIndex) {
        opt.scrollIntoView({ block: "nearest" });
        opt.classList.add("bg-slate-200",  "rounded")
      } else {
        opt.classList.remove("bg-slate-200","rounded")
      }
    })
  }

  close(event){
    const element = document.getElementById("search_results");
    if (!this.element.contains(event.target) && !this.inputTarget.contains(event.target)) {
      element.classList.add("hidden");
      this.currentIndex = 0
    }
  }
  open(){
    const options = document.getElementsByClassName("search-option");
    const element = document.getElementById("search_results");
    element.classList.remove("hidden")

  }
  resultsTargetConnected() {
    this.currentIndex = 0
    this.highlight()
  }
}

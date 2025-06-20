import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["search", "input", "results"]
  connect() {
    console.log("search controller here!!")
    this.currentIndex = 0
  }
  
  navigate(event){
    console.log("are we even entering navigate?? ")
    const options = document.getElementsByClassName("search-option")
    if (options.length === 0) return

    if (event.key === "ArrowDown") {
      console.log(this.currentIndex)
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
    console.log("entering highlight " + options[1])
    options.forEach((opt, index) => {
      if (index === this.currentIndex) {
        opt.scrollIntoView({ block: "nearest" });
        opt.classList.add("bg-slate-200",  "rounded")
        console.log("👉 Highlighting index:", index)
        
      } else {
        console.log("enteirng else of highlight")
        opt.classList.remove("bg-slate-200","rounded")
      }
    })
  }

  close(event){
    console.log("are we even entering close?? " + this.inputTarget)
    const element = document.getElementById("search_results");
    if (!this.element.contains(event.target) && !this.inputTarget.contains(event.target)) {
      element.classList.add("hidden");
      this.currentIndex = 0
    }
  }
  open(){
    console.log("open func")
    const options = document.getElementsByClassName("search-option");
    const element = document.getElementById("search_results");
    element.classList.remove("hidden")

  }
  resultsTargetConnected() {
    console.log("Results target connected — highlighting")
    this.currentIndex = 0
    this.highlight()
  }
}

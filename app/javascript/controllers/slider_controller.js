import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = ["min","max","range","resetbtn"]
  connect() {
    console.log(this.minTarget.value + "  " + this.maxTarget.value);
    this.defaultmin = parseInt(this.minTarget.value);
    this.defaultmax = parseInt(this.maxTarget.value);
    this.update();
  }
  update(){
    const current_min = this.minTarget.value;
    const current_max = this.maxTarget.value;
    console.log(current_min + "  " + current_max);
    this.rangeTarget.textContent = parseInt(current_min) + " - " + parseInt(current_max);
    if(current_min == this.defaultmin && current_max == this.defaultmax){
      this.resetbtnTarget.classList.add("hidden");
    }else{
      this.resetbtnTarget.classList.remove("hidden");
    }
  }
  reset(){

    console.log(this.defaultmin, +"   "+ this.defaultmax)
    this.minTarget.value = this.defaultmin;
    this.maxTarget.value = this.defaultmax;
    // this.rangeTarget.textContent = "No range selected"
    this.update();
  }

}

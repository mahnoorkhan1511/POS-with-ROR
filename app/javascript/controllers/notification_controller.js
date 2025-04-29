import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification"
export default class extends Controller {
  static targets = ["notification"];

    connect(){
        this.show();
    }
    
    show(){
        this.notificationTarget.classList.remove("hidden");
        setTimeout(()=> {
            this.hide();
        },2000);
    }
    hide(){
        this.notificationTarget.classList.add("hidden");
    }
}

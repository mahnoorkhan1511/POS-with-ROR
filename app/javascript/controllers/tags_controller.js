import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tags"
export default class extends Controller {

  connect() {
    console.log("tags controller here!!");
    this.tagList = [];

    const tagSpan = this.element.querySelectorAll("span.tag");
    tagSpan.forEach(span => {
      this.tagList.push(span.textContent.trim())
    });
    this.tagList = this.tagList.map(tag => tag.match(/^\s*(\w+)/)?.[1]);

    console.log(this.tagList)
    this.hiddenInput = document.getElementById("product_tag_names");
    this.updateHiddenField()
  }

  addTag(){
    // console.log("add called")
    const input  = document.getElementById("new-tag");
    // console.log(input);
    const tag = input.value.trim();
    // console.log(tag);
    if( tag && !this.tagList.includes(tag)){
      this.tagList.push(tag);
      this.renderTag(tag);
      this.updateHiddenField(); 
      input.value  = "";
    }
  }
  remove(event){
    console.log("in the remove function")
    const tagName = event.target.parentElement.childNodes[0].textContent.trim();
    // console.log(tagName);
    this.tagList = this.tagList.filter ( t => t != tagName);
    // console.log(this.tagList)
    // console.log(event.target.parentElement)
    event.target.parentElement.remove();

    this.updateHiddenField();
    // console.log(this.hiddenInput.value)
  }

  renderTag(tag){
    const container = document.getElementById("tags-container");
    const span = document.createElement("span");
    span.classList.add("inline-block", "bg-blue-100", "text-blue-800", "text-xs", "px-2", "py-1", "rounded", "mr-1", "mt-1", "tag");
    span.innerHTML = `${tag} <button class="text-red-600 hover:text-red-800 " data-action="click->tags#remove">
                        x
                      </button>`;
    container.appendChild(span);
  }
  
  updateHiddenField(){
    this.hiddenInput.value = this.tagList.join(",") 
  }
}

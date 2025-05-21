import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tags"
export default class extends Controller {
  static targets = ["tagList", "input"]
  connect() {
    console.log("tags controller here!!")
    this.tags = []
  }
  fetchSuggestions(event){
    const query = event.target.value.trim();
    if (query.length > 0) {
      // Send an AJAX request to the server
      fetch(`/tags?query=${query}`, {
        headers: {
          "Accept": "application/json"
        }
      })
      .then(response => response.json())
      .then(data => {
        this.showSuggestions(data);
      });
    }
  }
  showSuggestions(data){
    this.targetList.innerHTML = "";
    data.foreach((tag) => {
      const suggestion = document.createElement("div");
      suggestion.className = "px-2 py-1 cursor-pointer hover:bg-gray-200";
      suggestion.textContent = tag;
      suggestion.addEventListener("click", () => this.addTag(tag));
      this.tagListTarget.appendChild(suggestion);
    })
  }
  addTag(tag){
    if (!this.tags.includes(tag)) {
      this.tags.push(tag);
      const tagElement = document.createElement("div");
      tagElement.className = "bg-blue-100 text-gray-700 px-3 py-1 rounded";
      tagElement.innerText = tag;
      this.tagListTarget.appendChild(tagElement);
      document.getElementById("tags-input").value = JSON.stringify(this.tags);
    }
  }
}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["popup"]

  open() {
    this.popupTarget.classList.remove("hidden")
    document.getElementById("link_url").focus()
  }

  close() {
    this.popupTarget.classList.add("hidden")
  }

  handleClickOutside(event) {
    if (event.target.id === "popup-modal") {
      this.close()
    }
  }
}

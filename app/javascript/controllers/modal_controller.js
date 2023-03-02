import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ["popup"]

  open() {
    this.popupTarget.classList.remove("hidden")
  }

  close() {
    this.popupTarget.classList.add("hidden")
  }

  handleClickOutside(event) {
    console.log(event.target.id === "popup-modal")
    if (event.target.id === "popup-modal") {
      this.close()
    }
  }
}

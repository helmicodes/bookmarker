import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="button"
export default class extends Controller {
  static values = {
    url: String
  }

  share() {
    navigator.clipboard.writeText(this.urlValue)
  }
}

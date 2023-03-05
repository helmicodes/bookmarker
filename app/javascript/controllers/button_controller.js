import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="button"
export default class extends Controller {
  static values = {
    url: String
  }

  share() {
    navigator.clipboard.writeText(this.urlValue)
    this.shareFlash()
  }

  shareFlash() {
    document.getElementById("flash").innerHTML = `
      <div role="alert" data-controller="flash" class="flash notice rounded-xl p-4 shadow-xl">
          <div class="flex items-start gap-4">
            <div class="flex-1">
              <strong class="block font-medium text-white"> Copied </strong>
            </div>
          </div>
      </div>`
  }
}

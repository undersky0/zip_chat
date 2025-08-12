import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat-scroll"
export default class extends Controller {
  connect() {
    this.#scrollToBottomSmooth()
  }

  scrollToMessage(event) {
    this.#scrollToBottomSmooth()
  }

  #scrollToBottomSmooth() {
    this.element.scroll({
      top: this.element.scrollHeight,
      behavior: "smooth"
    })
  }
}

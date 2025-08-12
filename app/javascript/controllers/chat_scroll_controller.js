import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  connect() {
    this.scrollToBottom()

    // Listen for turbo stream events to scroll when new messages are added
    this.element.addEventListener("turbo:before-stream-render", () => {
      this.shouldScrollToBottom = this.isScrolledToBottom()
    })

    this.element.addEventListener("turbo:after-stream-render", () => {
      if (this.shouldScrollToBottom) {
        this.scrollToBottom()
      }
    })
  }

  scrollToBottom() {
    if (this.hasContainerTarget) {
      this.containerTarget.scrollTop = this.containerTarget.scrollHeight
    }
  }

  isScrolledToBottom() {
    if (!this.hasContainerTarget) return true

    const { scrollTop, scrollHeight, clientHeight } = this.containerTarget
    return Math.abs(scrollHeight - clientHeight - scrollTop) < 10
  }
}

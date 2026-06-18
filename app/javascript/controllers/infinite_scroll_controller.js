import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

export default class extends Controller {
  static values = {
    url: String
  }

  connect() {
    this.observer = new IntersectionObserver(([entry]) => {
      if (!entry.isIntersecting) return

      this.observer.disconnect()

      Turbo.visit(this.urlValue, {
        acceptsStreamResponse: true
      })
    })

    this.observer.observe(this.element)
  }

  disconnect() {
    this.observer?.disconnect()
  }
}
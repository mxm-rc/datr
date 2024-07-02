import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["limit"]

  connect() {
    console.log('Form action controller connected')
    this.updateAction()
  }

  updateAction() {
    const limitValue = this.limitTarget.value
    const form = this.element
    const originalAction = form.getAttribute('action')
    const baseAction = originalAction.split('?')[0] // Remove existing query params if any
    const newAction = `${baseAction}?limit=${limitValue}`
    form.setAttribute('action', newAction)
  }

  limitChanged() {
    this.updateAction()
  }
}

//
// Adapted from stimulus-character-counter
// - github.com/stimulus-components/stimulus-character-counter
//
// Removed type script and added an offset "values"
//
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["input", "counter"]
  static values = { from: Number }

  initialize() {
    this.update = this.update.bind(this)
  }

  connect() {
    this.update()
    this.inputTarget.addEventListener("input", this.update)
  }

  disconnect() {
    this.inputTarget.removeEventListener("input", this.update)
  }

  update() {
    this.counterTarget.innerHTML = this.count.toString()
  }

  get count() {
    return this.fromValue - this.inputTarget.value.length
  }
}

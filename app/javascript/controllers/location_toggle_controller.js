import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["checkbox"];
  connect() {}
  toggle(event) {
    // Add 'selected-location' class to the clicked checkbox
    event.currentTarget.classList.toggle("selected-location");
  }
}

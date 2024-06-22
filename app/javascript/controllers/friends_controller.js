import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="friends"
export default class extends Controller {
  static targets = ["name", "age", "card", "more"];
  connect() {}

  card(event) {
    this.nameTarget.innerHTML = event.target.dataset.name;
    this.ageTarget.innerHTML = event.target.dataset.age;
    this.cardTarget.style.backgroundImage = `url('${event.target.dataset.picture}')`;
    console.log(event.target.dataset.id)
    this.moreTarget.href = `/friends/${event.target.dataset.id}`
  }
}

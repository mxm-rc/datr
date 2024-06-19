import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="place-selection"
export default class extends Controller {
  static targets = ["card", "submitButton", "choiceText"]

  connect() {
    console.log("Stimulus Place Selection Controller connected");
    // To ensure correct initial state of the submit button and choice text
    this.updateVisibility();
  }

  toggle(event) {
    event.currentTarget.classList.toggle("selected");
    this.updateVisibility();
  }

  updateVisibility() {
    const anySelected = this.cardTargets.some(card => card.classList.contains("selected"));
    // Change text of the choiceText based on if any card is selected
    this.choiceTextTarget.textContent = anySelected ? "Faites votre choix" : "Faites au moins un choix";
    // Toggle visibility of the submit button based on if any card is selected
    this.submitButtonTarget.style.display = anySelected ? "block" : "none";
  }
}

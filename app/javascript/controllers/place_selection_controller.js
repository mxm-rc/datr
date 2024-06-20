import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="place-selection"
export default class extends Controller {
  static targets = ["card", "submitButton", "choiceText"]
  static values = { cardId: String }

  connect() {
    console.log("Stimulus Place Selection Controller connected");
    // To ensure correct initial state of the submit button and choice text
    this.updateVisibility();
  }

  toggle(event) {
    event.preventDefault();
    let card = event.currentTarget;
    let checkboxId = card.dataset.placeSelectionCardIdValue;
    let checkbox = document.getElementById(checkboxId);

    card.classList.toggle("selected");
    checkbox.checked = !checkbox.checked;
    this.updateVisibility();
  }

  toggleCheckbox(event) {
    let checkbox = event.target;
    let cardId = checkbox.id;
    let card = this.cardTargets.find(c => c.dataset.placeSelectionCardIdValue === cardId);

    if (card) {
      card.classList.toggle("selected", checkbox.checked);
    }
    this.updateVisibility();
  }

  updateVisibility() {
    const anySelected = this.cardTargets.some(card => card.classList.contains("selected"));
    // Change text of the choiceText based on if any card is selected
    this.choiceTextTarget.textContent = anySelected ? "Cliquez vos choix puis : " : "Cliquez un choix au moins";
    // Toggle visibility of the submit button based on if any card is selected
    this.submitButtonTarget.style.display = anySelected ? "block" : "none";
  }
}

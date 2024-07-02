import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["card"]

  connect() {
    console.log("Modal Controller connected.")
  }

  openModal(event) {
    // Prevent the default action
    event.preventDefault();

    // Remove the selected class from all cards
    this.cardTargets.forEach((card) => {
      card.classList.remove("halfway-selected-card");
    });

    // Add the selected border class to the clicked card
    const cardElement = event.currentTarget;
    cardElement.classList.add("halfway-selected-card");

    // Assuming you have an image and some text you want to display in the modal
    // For demonstration, let's assume the image URL and text are stored in data attributes
    const imageUrl = cardElement.dataset.imageUrl; // Ensure you have this data attribute
    const meetDetails = cardElement.dataset.meetDetails; // Ensure you have this data attribute

    // Find the modal and its content container by ID
    const modal = document.getElementById('customModal');
    const modalContent = document.getElementById('modalContent');

    // Clear previous content
    modalContent.innerHTML = '';

    // Insert new content - an image and some text
    modalContent.innerHTML = `<img src="${imageUrl}" alt="Meet Image" style="width: 100%;"><p>${meetDetails}</p>`;

    // Show the modal
    modal.style.display = "block";
  }

  // Method to close the modal
  closeModal() {
    const modal = document.getElementById('customModal');
    modal.style.display = "none";
  }
}

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
    this.removeBorder();

    // Add the selected border class to the clicked card
    const cardElement = event.currentTarget;
    cardElement.classList.add("halfway-selected-card");

    // Get the image URL and meet details from the clicked card
    const friendImageUrl = cardElement.dataset.friendImageUrl;
    const placeImageUrl = cardElement.dataset.placeImageUrl;
    const meetDetails = cardElement.dataset.meetDetails;
    const friendDetails = cardElement.dataset.friendDetails;
    const friendBio = cardElement.dataset.friendBio;
    const placeName = cardElement.dataset.placeName;
    const placeAddress = cardElement.dataset.placeAddress;
    const friendPrefs = cardElement.dataset.friendPrefs;

    // Find the modal and its content container by ID
    const modal = document.getElementById('customModal');
    const modalContent = document.getElementById('modalContent');

    // Clear previous content
    modalContent.innerHTML = '';

    // Insert new content - an image and some text
    modalContent.innerHTML = `
                              <div class="content-wrapper">
                                <img src="${friendImageUrl}" alt="Meet Image" class="m-1 halfway-modal-image" style="width: 80%;">
                                <h1 class="mb-1">${friendDetails}</h1>
                                <p class="mb-1 border-bottom border-dark">${friendPrefs}</p>
                                <p class="mb-1" style="text-align: justify;">${friendBio}</p>
                                <p class="m-4 text-danger">Prévue le ${meetDetails}, ici 👇</p>
                                ${placeName ? `
                                  <div class="text-center">
                                    <p>${placeName}</p>
                                    <p>${placeAddress}</p>
                                    <img src="${placeImageUrl}" alt="Place Image" class="m-2 halfway-modal-image" style="width: 50%;">
                                  </div>
                                  ` : `<div class="text-center"><h1>Lieu en attente de validation ! </h1></div>`}
                              </div>`;
    // Show the modal
    modal.style.display = "block";
  }

  // Method to close the modal
  closeModal() {
    const modal = document.getElementById('customModal');
    modal.style.display = "none";

    // Remove the selected class from all cards
    this.removeBorder();
  }

  // Method to remove border
  removeBorder() {
    // Remove the selected class from all cards
    this.cardTargets.forEach((card) => {
      card.classList.remove("halfway-selected-card");
    });
  }
}

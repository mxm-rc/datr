import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["meets", "preferences"];

  connect() {
    console.log("Hello from profile controller!")
    this.initializeProfileVisibility();
  }

  toggleProfile(event) {
    const selectedValue = event.target.value;
    console.log("radio button clicked: " + selectedValue);
    this.setVisibility(selectedValue);
  }

  initializeProfileVisibility() {
    // Set initial visibility based on 'planned_meets'
    console.log("Initial visibility set to 'meets'")
    this.setVisibility('meets');
  }

  setVisibility(selectedValue) {
    if (selectedValue === 'preferences') {
      console.log("Hiding meets, showing preferences");

      this.meetsTarget.style.display = 'none';
      this.preferencesTarget.style.display = '';
    } else if (selectedValue === 'meets') {
      console.log("Hiding preferences, showing meets");

      this.preferencesTarget.style.display = 'none';
      this.meetsTarget.style.display = '';
    }
  }
}

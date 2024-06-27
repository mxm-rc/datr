import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["secondRowContainer", // Use to show/hide all categories based on joker box checked
                    "jokerCheckbox", // Use to get joker box status
                    "preference", // Use to get all other category checkboxes status
                    "preferencesSerialized"]; // Use to store serialized preferences based on checked boxes

  connect() {
    console.log('Connected preference_selection_controller');
    this.toggleSecondRowVisibility();
    this.updatePreferencesArray();
  }

  jokerClicked() {
    console.log('Surprise clicked');
    this.toggleSecondRowVisibility();
    this.updatePreferencesArray();
  }

  preferenceClicked() {
    console.log('Preference clicked');
    this.updatePreferencesArray();
  }

  toggleSecondRowVisibility() {
    this.secondRowContainerTarget.style.display = this.jokerCheckboxTarget.checked ? 'none' : 'block';
  }

  updatePreferencesArray() {
    let selectedCategories = [];

    if (this.jokerCheckboxTarget.checked) {
      // Clear all other checkboxes if joker
      this.preferenceTargets.forEach((checkbox) => {
        if (checkbox !== this.jokerCheckboxTarget) {
          checkbox.checked = false;
        }
      });

      // Push 'Surprise' when joker box is checked and ignore other checkboxes
      selectedCategories.push(this.jokerCheckboxTarget.dataset.category);
     } else {
      // When joker box unchecked, deal with all other checked boxes
      selectedCategories = this.preferenceTargets.filter((checkbox) => checkbox.checked).map((checkbox) => checkbox.dataset.category);

      // If no preference selected, check the first preference by default
      if (selectedCategories.length === 0 && this.preferenceTargets.length > 0) {
        this.preferenceTargets[0].checked = true;
        selectedCategories.push(this.preferenceTargets[0].dataset.category);
      }
    console.log("Updating preferences array, SelectedCategories: ", selectedCategories);
    }
  }
}

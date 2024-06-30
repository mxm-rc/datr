import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["secondRowContainer", // Use to show/hide all categories based on joker box checked
                    "jokerCheckbox", // Use to get joker box status
                    "preference", // Use to get all other category checkboxes status
                    "preferencesSerialized"]; // Use to store serialized preferences based on checked boxes

  connect() {
    console.log('Connected preference_selection_controller');
    this.updateJokerCheckboxes();
    this.updatePreferencesArray();
  }

  jokerClicked() {
    console.log('Surprise clicked');
    this.updateJokerCheckboxes();
    this.updatePreferencesArray();
  }

  preferenceClicked() {
    console.log('Preference clicked');
    this.updatePreferencesArray();
  }

  updateJokerCheckboxes() {
    if (this.jokerCheckboxTarget.checked) {
      // all other checkboxes disabled if joker
      this.preferenceTargets.forEach((checkbox) => {
        if (checkbox !== this.jokerCheckboxTarget) {
          checkbox.disabled = true;
        }
      });
    } else {
      // all other checkboxes enabled if no joker
      this.preferenceTargets.forEach((checkbox) => {
        if (checkbox !== this.jokerCheckboxTarget) {
          checkbox.disabled = false;
        }
      });
    }
  }

  updatePreferencesArray(type) {
    let selectedCategories = [];

    if (this.jokerCheckboxTarget.checked) {
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

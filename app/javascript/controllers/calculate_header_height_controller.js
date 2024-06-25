import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="calculate-header-height"
export default class extends Controller {
  static targets = ["genericHeader", "landingPageArticle"]

  connect() {
    this.updateContainerPositions(this.landingPageArticleTargets, 'paddingTop');
  }

  updateContainerPositions(targets, styleProperty) {
    if (this.hasGenericHeaderTarget) {
      const totalHeight = this.genericHeaderTarget.offsetHeight;
      targets.forEach(target => target.style[styleProperty] = `${totalHeight}px`);
    } else {
      console.warn('Header introuvable');
    }
  }
}

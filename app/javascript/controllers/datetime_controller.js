import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["output"]

  connect() {
    this.updateDateTime()
  }

  updateDateTime() {
    const now = new Date();
    const day = String(now.getDate()).padStart(2, '0');
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const year = now.getFullYear();
    const hours = String(now.getHours()).padStart(2, '0');
    const minutes = String(now.getMinutes()).padStart(2, '0');

    // format : dd/mm/yyyy hh:mm
    const datetime = `${day}/${month}/${year} ${hours}:${minutes}`;
    this.outputTarget.textContent = datetime;

    setTimeout(() => this.updateDateTime(), 60000); // Update every minutes
  }}

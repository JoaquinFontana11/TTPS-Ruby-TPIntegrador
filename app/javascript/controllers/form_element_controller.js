import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="form-element"
export default class extends Controller {
  static targets = ["validate_staff"];
  connect() {
    this.validate_staffTarget.hidden = true;
  }

  remoteValidate() {
    console.log("Hola");
    this.validate_staffTarget.click();
  }
}

import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js";

export default class extends Controller {
  static targets = [ "#focusNotes" ]

  change(event) {
    let focus_id = event.target.selectedOptions[0].value
    console.log(focus_id)
    get(`/foci/${focus_id}`, {
      responseKind: "turbo-stream"
    })

  }
}

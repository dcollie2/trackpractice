import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js";

export default class extends Controller {
  static targets = [ "#lyrics" ]

  change(event) {
    let song_id = event.target.selectedOptions[0].value
    console.log(song_id)
    get(`/songs/${song_id}`, {
      responseKind: "turbo-stream"
    })

  }
}

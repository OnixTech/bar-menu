import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  connect() {
    alert("hello");
    createConsumer().subscriptions.create({channel: "StationChannel", room: this.element.dataset.stationid }, {
      received(data){
        if (data.action === "created"){
          location.reload()
        }
      }
    })
  }
}

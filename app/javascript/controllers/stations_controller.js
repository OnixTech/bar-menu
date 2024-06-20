import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  connect() {
    createConsumer().subscriptions.create({channel: "StationChannel", room: this.element.dataset.stationid }, {
      received(data){
        console.log("Received data:", data);
        if (data.action === "created"){
          location.reload()
        }
      }
    })
  }
}

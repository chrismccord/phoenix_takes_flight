import {Socket} from "phoenix"

let App = {
  init: function(){
    let socket = new Socket("/ws")
    socket.connect()

    socket.join("rooms:lobby", {})
      .receive("ignore", () => console.log("authnentication failure") )
      .receive("ok", chan => {
        console.log("Welcome to Phoenix Lobby chat!")

        chan.on("ping", payload => console.log("PING", payload) )

      })
  }
}

App.init()
export default App

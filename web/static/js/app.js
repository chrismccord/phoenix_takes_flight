import {Socket} from "phoenix"

let App = {
  init: function(){
    let socket = new Socket("/ws")
    let msgInput = $("#msg-input")
    let msgContainer = $("#msg-container")
    socket.connect()

    socket.join("rooms:lobby", {})
      .receive("ignore", () => console.log("authnentication failure") )
      .receive("ok", chan => {
        console.log("Welcome to Phoenix Lobby chat!")

        chan.on("ping", payload => console.log("PING", payload) )

        msgInput.off("keypress").on("keypress", e => {
          if(e.which === 13){ // enter pressed
            chan.push("new_msg", {body: msgInput.val()})
            msgInput.val("")
          }
        })

        chan.on("new_msg", payload => {
          if(payload.owner){
            msgContainer.append(`<br/>me: ${payload.body}`)
          } else {
            msgContainer.append(`<br/>${payload.body}`)
          }

        })
      })
  }
}

App.init()
export default App

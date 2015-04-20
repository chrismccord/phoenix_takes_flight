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

        chan.on("message_feed", ({messages}) => {
          messages.forEach( msg => msgContainer.append(`<br/>${msg.body}`) )
        })

        chan.on("ping", payload => console.log("PING", payload) )

        msgInput.off("keypress").on("keypress", e => {
          if(e.which === 13){ // enter pressed
            chan.push("new_msg", {body: msgInput.val()})
                .receive("ok", payload => msgContainer.append(`<br/>me: ${payload.body}`))
                .after(2000, () => console.log("waiting for 2s") )

            msgInput.val("")
          }
        })

        chan.on("new_msg", payload => {
          msgContainer.append(`<br/>${payload.body}`)
          window.scrollTo(0, $("body").height())
        })
      })
  }
}

App.init()
export default App

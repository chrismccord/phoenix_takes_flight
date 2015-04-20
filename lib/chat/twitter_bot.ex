defmodule Chat.TwitterBot do
  use GenServer
  require Logger

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init(_) do
    Phoenix.PubSub.subscribe(Chat.PubSub, self, "rooms:lobby")
    {:ok, %{keywords: []}}
  end

  def handle_info({:tweet, tweet}, state) do
    Chat.Endpoint.broadcast("rooms:lobby", "new_msg", %{from: "twitterbot", body: tweet.text})
    {:noreply, state}
  end

  def handle_info({:socket_broadcast, %{payload: %{from: "twitterbot"}}}, state) do
    {:noreply, state}
  end
  def handle_info({:socket_broadcast, %{event: "new_msg", payload: msg}}, state) do
    parent = self
    case msg.body do
      "/stream " <> keyword ->
        keywords = [keyword | state.keywords]
        Logger.info("track #{Enum.join(keywords, ", ")}")
        spawn_link fn ->
          for tweet <- ExTwitter.stream_filter(track: keyword) do
            send(parent, {:tweet, tweet})
          end
        end

        {:noreply, %{state | keywords: keywords}}
      _ ->
        Logger.info("Ignore")
        {:noreply, state}
    end
  end

end

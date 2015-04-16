defmodule Chat.RoomChannel do
  use Phoenix.Channel
  import Ecto.Query
  alias Chat.Repo
  alias Chat.Message

  def join("rooms:lobby", _auth_msg, socket) do
    :timer.send_interval(30_000, :ping)
    user_id = :crypto.strong_rand_bytes(24) |> Base.encode64
    send(self, :after_join)

    {:ok, assign(socket, :user_id, user_id)}
  end
  def join("rooms:" <> _private_room_id, _auth_msg, _socket) do
    :ignore
  end

  def handle_info(:after_join, socket) do
    messages = from(m in Message, limit: 100, order_by: m.inserted_at) |> Repo.all()
    push socket, "message_feed", %{messages: messages}
    {:noreply, socket}
  end

  def handle_info(:ping, socket) do
    push socket, "ping", %{time: inspect(:os.timestamp())}
    {:noreply, socket}
  end

  def handle_in("new_msg", payload, socket) do
    message_params = Map.put(payload, "room_id", socket.topic)
    changeset = Message.changeset(%Message{}, message_params)

    if changeset.valid? do
      msg = Repo.insert(changeset)
      broadcast_from! socket, "new_msg", %{
        body: msg.body,
        user_id: socket.assigns.user_id
      }
      {:reply, {:ok, msg}, socket}
    else
      {:reply, {:error, %{errors: changeset.errors}}, socket}
    end
  end
end

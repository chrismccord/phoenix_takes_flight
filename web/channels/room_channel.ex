defmodule Chat.RoomChannel do
  use Phoenix.Channel

  def join("rooms:lobby", _auth_msg, socket) do
    :timer.send_interval(2000, :ping)
    user_id = :crypto.strong_rand_bytes(24) |> Base.encode64

    {:ok, assign(socket, :user_id, user_id)}
  end
  def join("rooms:" <> _private_room_id, _auth_msg, _socket) do
    :ignore
  end

  def handle_info(:ping, socket) do
    push socket, "ping", %{time: inspect(:os.timestamp())}
    {:noreply, socket}
  end

  def handle_in("new_msg", payload, socket) do
    broadcast! socket, "new_msg", %{
      body: payload["body"],
      user_id: socket.assigns.user_id
    }
    {:noreply, socket}
  end

  def handle_out("new_msg", payload, socket) do
    if payload.user_id == socket.assigns.user_id do
      push socket, "new_msg", Map.merge(payload, %{owner: true})
    else
      push socket, "new_msg", payload
    end
    {:noreply, socket}
  end
end

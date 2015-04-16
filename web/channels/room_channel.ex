defmodule Chat.RoomChannel do
  use Phoenix.Channel

  def join("rooms:lobby", _auth_msg, socket) do
    :timer.send_interval(2000, :ping)
    {:ok, socket}
  end
  def join("rooms:" <> _private_room_id, _auth_msg, _socket) do
    :ignore
  end

  def handle_info(:ping, socket) do
    push socket, "ping", %{time: inspect(:os.timestamp())}
    {:noreply, socket}
  end

end

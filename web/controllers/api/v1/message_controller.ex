defmodule Chat.Api.V1.MessageController do
  use Chat.Web, :controller

  plug :action

  def index(conn, _params) do
    conn
    |> assign(:messages, Repo.all(Message))
    |> render("index.json")
  end

  def create(conn, %{"message" => message_params}) do
    changeset = Message.changeset(%Message{}, message_params)

    if changeset.valid? do
      msg = Repo.insert(changeset)
      Chat.Endpoint.broadcast("rooms:" <> msg.room_id, "new_msg", %{
        body: msg.body
      })
      render conn, "show.json", message: msg
    else
      render conn, "error.json", errors: changeset
    end
  end

  def show(conn, %{"id" => id}) do
    render conn, "show.json", message: Repo.get(Message, id)
  end
end

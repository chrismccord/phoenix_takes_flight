defmodule Chat.MessageController do
  use Chat.Web, :controller

  alias Chat.Message

  plug :scrub_params, "message" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    messages = Repo.all(Message)
    render conn, "index.html", messages: messages
  end

  def new(conn, _params) do
    changeset = Message.changeset(%Message{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"message" => message_params}) do
    changeset = Message.changeset(%Message{}, message_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Message created successfully.")
      |> redirect(to: message_path(conn, :index))
    else
      render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => id}) do
    message = Repo.get(Message, id)
    render conn, "show.html", message: message
  end

  def edit(conn, %{"id" => id}) do
    message = Repo.get(Message, id)
    changeset = Message.changeset(message)
    render conn, "edit.html", message: message, changeset: changeset
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Repo.get(Message, id)
    changeset = Message.changeset(message, message_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Message updated successfully.")
      |> redirect(to: message_path(conn, :index))
    else
      render conn, "edit.html", message: message, changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Repo.get(Message, id)
    Repo.delete(message)

    conn
    |> put_flash(:info, "Message deleted successfully.")
    |> redirect(to: message_path(conn, :index))
  end
end

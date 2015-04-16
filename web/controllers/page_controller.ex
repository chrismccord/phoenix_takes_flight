defmodule Chat.PageController do
  use Chat.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  def chat(conn, _params) do
    render conn, :chat
  end
end

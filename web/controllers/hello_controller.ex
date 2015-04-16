defmodule Chat.HelloController do
  use Chat.Web, :controller

  plug :action


  def hello(conn, %{"name" => name}) do
    render conn, "hello.html", name: name
  end
end

defmodule Chat.Router do
  use Phoenix.Router

  socket "/ws", Chat do
    channel "rooms:*", RoomChannel
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Chat do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/hello/:name", HelloController, :hello

    resources "/messages", MessageController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Chat do
  #   pipe_through :api
  # end
end

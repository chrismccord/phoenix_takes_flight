defmodule Chat.Api.V1.MessageView do
  use Chat.Web, :view

  def render("index.json", attrs) do
    %{
       data: attrs[:messages]
     }
  end

  def render("show.json", %{message: msg}) do
    msg
  end

  def render("error.json", %{errors: errors}) do
    %{errors: errors}
  end
end

defmodule Chat.MessageControllerTest do
  use Chat.ConnCase

  def msg_count(), do: Repo.all(Message) |> Enum.count

  test "POST /messages creates a new message" do
    count_before = msg_count()
    conn = post conn(), "/messages", %{message: %{body: "hello", room_id: "lobby"}}

    assert html_response(conn, 302)
    assert get_flash(conn, :info) =~ "Message create"
    assert msg_count() == count_before + 1
  end

  test "POST /messages with invalid params display an error" do
    count_before = msg_count()
    conn = post conn(), "/messages", %{message: %{body: "hello"}}

    assert html_response(conn, 200) =~ "Please check the errors"
    assert msg_count() == count_before
  end

  test "GET /messages renders messages" do
    conn = get conn(), "/messages", %{message: %{body: "hello"}}

    assert html_response(conn, 200) =~ "Messages"
  end

  test "GET /messages/:id renders message" do
    msg = Repo.insert(%Message{body: "a message"})
    conn = get conn(), message_path(Endpoint, :show, msg.id)

    assert html_response(conn, 200) =~ "a message"
  end
end

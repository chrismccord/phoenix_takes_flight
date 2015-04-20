defmodule Chat.PageControllerTest do
  use Chat.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert conn.resp_body =~ "Welcome to Phoenix!"
  end

  test "GET /messages" do
    conn = get conn(), "/messages"
    assert html_response(conn, 200) =~ "Messages"
  end
end

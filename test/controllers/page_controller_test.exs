defmodule EventRegistry.PageControllerTest do
  use EventRegistry.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert conn.resp_body =~ "Welcome to Phoenix!"
  end
end
